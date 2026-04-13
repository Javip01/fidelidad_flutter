import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ofertas_screen.dart';
import 'ajustes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _cameraController;
  late PageController _pageController; // Controlador para el deslizamiento tipo iPhone

  final List<Widget> _screens = [
    const OfertasScreen(),
    const AjustesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador de páginas en la pestaña actual
    _pageController = PageController(initialPage: _selectedIndex);

    _cameraController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _pageController.dispose(); // Importante limpiar el controlador
    super.dispose();
  }

  // Función para abrir la cámara nativa
  Future<void> _abrirCamara() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
  }

  // Función que maneja el cambio de pestaña con la animación tipo iPhone
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Animación de deslizamiento horizontal muy suave
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400), // Duración de la transición
      curve: Curves.easeOutCubic, // Curva suave tipo iOS
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo general en modo claro
      body: Stack(
        children: [
          // SISTEMA DE PÁGINAS DESLIZANTES
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Bloquea el deslizar con el dedo (opcional, quítalo si quieres permitirlo)
            children: _screens,
          ),

          // BARRA INFERIOR (MENÚ) EN MODO CLARO
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _onItemTapped(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_offer, color: _selectedIndex == 0 ? const Color(0xFF8B0000) : Colors.grey),
                          Text("Ofertas", style: TextStyle(color: _selectedIndex == 0 ? const Color(0xFF8B0000) : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 80), // Espacio central para la cámara
                  Expanded(
                    child: InkWell(
                      onTap: () => _onItemTapped(1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings, color: _selectedIndex == 1 ? const Color(0xFF8B0000) : Colors.grey),
                          Text("Ajustes", style: TextStyle(color: _selectedIndex == 1 ? const Color(0xFF8B0000) : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botón de Cámara Central
          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width / 2 - 32.5,
            child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _cameraController, curve: Curves.easeInOut)),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF8B0000), // Rojo primario
                elevation: 6,
                onPressed: _abrirCamara,
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}