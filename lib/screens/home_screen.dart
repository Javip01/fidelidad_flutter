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
  int _selectedIndex = 0; // 0: Ofertas, 1: Ajustes
  late AnimationController _controller;

  final List<Widget> _screens = [
    const OfertasScreen(),
    const AjustesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Función para abrir la cámara nativa
  Future<void> _abrirCamara() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo general en modo claro
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),

          // BARRA INFERIOR (MENÚ) EN MODO CLARO
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white, // Fondo BLANCO para la barra inferior
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // Sombra muy sutil
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _selectedIndex = 0),
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
                      onTap: () => setState(() => _selectedIndex = 1),
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
              scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
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