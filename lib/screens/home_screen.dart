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

  final List<Widget> _screens = [
    const OfertasScreen(key: ValueKey('ofertas')),
    const AjustesScreen(key: ValueKey('ajustes')),
  ];

  @override
  void initState() {
    super.initState();
    _cameraController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _abrirCamara() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // TRANSICIÓN UNIFORME DESDE EL BORDE REAL DE LA PANTALLA
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), // 500ms: Velocidad media-alta y muy fluida
            // easeInOutSine crea un movimiento uniforme: arranca suave (sin saltos) y frena suave
            switchInCurve: Curves.easeInOutSine,
            switchOutCurve: Curves.easeInOutSine,
            transitionBuilder: (Widget child, Animation<double> animation) {

              final bool isAjustes = child.key == const ValueKey('ajustes');

              // CORRECCIÓN: Ahora viene desde el 100% (1.0) del borde exterior del teléfono,
              // no desde el centro, eliminando el efecto de teletransporte.
              final double offsetX = isAjustes ? 1.0 : -1.0;

              final offsetAnimation = Tween<Offset>(
                begin: Offset(offsetX, 0.0),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, widgetChild) {
                      return ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: isAjustes ? Alignment.centerLeft : Alignment.centerRight,
                            end: isAjustes ? Alignment.centerRight : Alignment.centerLeft,
                            colors: [
                              // El borde se hace opaco uniformemente mientras entra
                              Colors.white.withOpacity(animation.value),
                              Colors.white
                            ],
                            stops: const [0.0, 0.25], // Ampliado al 25% para un difuminado más inmersivo
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: widgetChild,
                      );
                    },
                    child: child,
                  ),
                ),
              );
            },
            child: _screens[_selectedIndex],
          ),

          // BARRA INFERIOR (MENÚ)
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
                  const SizedBox(width: 80), // Espacio para la cámara
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
              scale: Tween(begin: 1.0, end: 1.08).animate(CurvedAnimation(parent: _cameraController, curve: Curves.easeInOut)),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF8B0000),
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