import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ofertas_screen.dart';
import 'ajustes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _cameraController;
  late AnimationController _pageController;

  @override
  void initState() {
    super.initState();

    // Animación de latido para el botón central
    _cameraController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Animación de las pantallas: 550ms con curva suave (como en el código visual que te gustó)
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Cámara a prueba de errores
  Future<void> _abrirCamara() async {
    try {
      final ImagePicker picker = ImagePicker();
      await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al abrir la cámara.', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF8B0000),
          ),
        );
      }
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() => _selectedIndex = index);

    // Reproduce la animación según la pestaña tocada
    if (index == 1) {
      _pageController.forward();
    } else {
      _pageController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Color de fondo base para la fusión
      body: Stack(
        children: [
          // ==========================================
          // 1. PANTALLA OFERTAS (Arquitectura Zero-Lag + Visual Fade)
          // ==========================================
          // Mientras _pageController va de 0 a 1, Ofertas se hace transparente (1.0 -> 0.0)
          FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0)
                .animate(CurvedAnimation(parent: _pageController, curve: Curves.easeInOutSine)),
            // Y se desliza hacia la izquierda (0.0 -> -1.0)
            child: SlideTransition(
              position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0))
                  .animate(CurvedAnimation(parent: _pageController, curve: Curves.easeInOutSine)),
              child: Stack(
                clipBehavior: Clip.none, // Permite dibujar el halo fuera de la pantalla
                children: [
                  const RepaintBoundary(child: OfertasScreen()),

                  // EL HALO EXTERNO (Visual exacto de tu primer código)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: -70,
                    width: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color(0xFFF5F5F5), // Sólido tocando la pantalla
                            const Color(0xFFF5F5F5).withOpacity(0.0), // Transparente lejos
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // 2. PANTALLA AJUSTES (Arquitectura Zero-Lag + Visual Fade)
          // ==========================================
          // Mientras _pageController va de 0 a 1, Ajustes se hace opaco (0.0 -> 1.0)
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0)
                .animate(CurvedAnimation(parent: _pageController, curve: Curves.easeInOutSine)),
            // Y se desliza desde la derecha hacia el centro (1.0 -> 0.0)
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .animate(CurvedAnimation(parent: _pageController, curve: Curves.easeInOutSine)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const RepaintBoundary(child: AjustesScreen()),

                  // EL HALO EXTERNO (Visual exacto de tu primer código)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: -70,
                    width: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color(0xFFF5F5F5).withOpacity(0.0), // Transparente lejos
                            const Color(0xFFF5F5F5), // Sólido tocando la pantalla
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // 3. BARRA INFERIOR (Aislada contra el lag)
          // ==========================================
          Align(
            alignment: Alignment.bottomCenter,
            child: RepaintBoundary(
              child: Container(
                height: 80,
                padding: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
                ),
                child: Row(
                  children: [
                    _buildNavTab(0, Icons.local_offer, "Ofertas"),
                    const SizedBox(width: 80),
                    _buildNavTab(1, Icons.settings, "Ajustes"),
                  ],
                ),
              ),
            ),
          ),

          // ==========================================
          // 4. BOTÓN DE CÁMARA (Aislado contra el lag)
          // ==========================================
          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width / 2 - 32.5,
            child: RepaintBoundary(
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _cameraController, curve: Curves.easeInOut)),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFF8B0000),
                  elevation: 6,
                  onPressed: _abrirCamara,
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTab(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF8B0000) : Colors.grey),
            Text(label, style: TextStyle(color: isSelected ? const Color(0xFF8B0000) : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}