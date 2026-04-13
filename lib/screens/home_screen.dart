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
    _cameraController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pageController = AnimationController(
      duration: const Duration(milliseconds: 600), // Un poco más lento para que se aprecie la fluidez
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    if (index == 1) {
      _pageController.forward();
    } else {
      _pageController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definimos una animación de opacidad que solo es visible durante el trayecto
    // El "Interval" hace que aparezca rápido al inicio y desaparezca al final
    final Animation<double> haloOpacity = CurvedAnimation(
      parent: _pageController,
      curve: const Interval(0.1, 0.9, curve: Curves.easeInOut),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // 1. PANTALLA OFERTAS
          SlideTransition(
            position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0))
                .animate(CurvedAnimation(parent: _pageController, curve: Curves.easeInOutSine)),
            child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const RepaintBoundary(child: OfertasScreen()),
                  // HALO DINÁMICO (Derecho): Solo visible al salir hacia la izquierda
                  Positioned(
                    right: -70, top: 0, bottom: 0, width: 70,
                    child: FadeTransition(
                      opacity: _pageController, // Se desvanece al salir
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [const Color(0xFFF5F5F5), const Color(0xFFF5F5F5).withOpacity(0.0)],
                              )
                          )
                      ),
                    ),
                  )
                ]
            ),
          ),

          // 2. PANTALLA AJUSTES
          SlideTransition(
            position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .animate(CurvedAnimation(parent: _pageController, curve: Curves.easeInOutSine)),
            child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const RepaintBoundary(child: AjustesScreen()),
                  // HALO DINÁMICO (Izquierdo): Solo visible mientras entra
                  Positioned(
                    left: -70, top: 0, bottom: 0, width: 70,
                    child: FadeTransition(
                      opacity: _pageController, // Aparece mientras entra
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [const Color(0xFFF5F5F5).withOpacity(0.0), const Color(0xFFF5F5F5)],
                              )
                          )
                      ),
                    ),
                  )
                ]
            ),
          ),

          // BARRA INFERIOR Y BOTÓN (Aislados en RepaintBoundary)
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

          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width / 2 - 32.5,
            child: RepaintBoundary(
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _cameraController, curve: Curves.easeInOut)),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFF8B0000),
                  elevation: 6,
                  onPressed: () {},
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