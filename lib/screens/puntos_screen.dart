import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'ofertas_screen.dart'; // Importa AnimacionXMLGradient

class PuntosScreen extends StatefulWidget {
  const PuntosScreen({super.key});
  @override
  State<PuntosScreen> createState() => _PuntosScreenState();
}

class _PuntosScreenState extends State<PuntosScreen> {
  int _activeColumn = 1;

  final List<_LocalData> _restaurantes = [
    _LocalData("El Rincón Guay", "lib/assets/elrinconguay_grad.png", "lib/assets/elrinconguay.png"),
    _LocalData("One Love", "lib/assets/onelove_grad.png", "lib/assets/onelove.png"),
    _LocalData("Rebel Flame", "lib/assets/rebelflame_grad.png", "lib/assets/rebelflame.png"),
  ];

  final List<_LocalData> _experiencias = [
    _LocalData("Sauna Lavapiés", "lib/assets/saunalava_grad.png", "lib/assets/saunalava.png"),
    _LocalData("The Private Ring", "lib/assets/theringprivate_grad.png", "lib/assets/thering.png"),
    _LocalData("Sauna Toledo", "lib/assets/saunatoledo_grad.png", "lib/assets/saunatoledo.png"),
  ];

  // POPUP CENTRAL DEL QR (RECONSTRUIDO Y GARANTIZADO)
  void _mostrarQrPopup(String nombre) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7), // Oscurece el fondo
      barrierDismissible: true,
      barrierLabel: 'Cerrar',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        // En lugar de AlertDialog, usamos Center y Material para evitar colapsos
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Se ajusta al contenido
                children: [
                  const Text(
                      "Escanea este QR en caja",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  const SizedBox(height: 24),

                  // CONTENEDOR DEL QR REAL
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    ),
                    child: QrImageView(
                      data: "PUNTOS_${nombre}_${DateTime.now().millisecondsSinceEpoch}",
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      errorCorrectionLevel: QrErrorCorrectLevel.M,
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                      nombre,
                      style: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 24),

                  // BOTÓN DE CERRAR
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000), // Rojo de la app
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("CERRAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Animación de rebote elástico hacia el centro
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo modo claro
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 16),
              child: Column(
                children: [
                  // CABECERA (Píldora Puntos con Animación XML)
                  AnimacionXMLGradient(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: const Column(
                        children: [
                          Text("TUS PUNTOS", style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12)),
                          Text("1.250", style: TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // COLUMNAS ACORDEÓN CON EMPUJE FÍSICO REAL
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double totalWidth = constraints.maxWidth - 8;

                        double widthCol1 = _activeColumn == 1 ? totalWidth * 0.72 : totalWidth * 0.28;
                        double widthCol2 = _activeColumn == 2 ? totalWidth * 0.72 : totalWidth * 0.28;

                        return Row(
                          children: [
                            _buildColumnaAcordeonFisico("Restaurantes", _restaurantes, 1, widthCol1),
                            const SizedBox(width: 8),
                            _buildColumnaAcordeonFisico("Experiencias", _experiencias, 2, widthCol2),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BARRA SUPERIOR PÍLDORA FLOTANTE
          Positioned(
            top: 40, left: 16, right: 16,
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: const Color(0xFF1A0000), borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18), onPressed: () => Navigator.pop(context)),
                  const Expanded(child: Text("Mis Puntos", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                  const SizedBox(width: 48), // Balance visual
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnaAcordeonFisico(String title, List<_LocalData> locales, int index, double currentWidth) {
    bool isExpanded = _activeColumn == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
      width: currentWidth,
      child: Column(
        children: [
          // Título de la columna
          Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: const Color(0xFF1A0000), borderRadius: BorderRadius.circular(16)),
            child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1, overflow: TextOverflow.clip),
          ),
          const SizedBox(height: 8),

          // Locales
          ...locales.map((data) => Expanded(
            child: GestureDetector(
              onTap: () {
                if (isExpanded) {
                  _mostrarQrPopup(data.nombre); // Lanza el Popup asegurado
                } else {
                  setState(() => _activeColumn = index); // Expande la columna
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // --- ESTADO 1: CONTRAÍDO (Animación XML + Logo) ---
                      AnimatedOpacity(
                        opacity: isExpanded ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 350),
                        child: AnimacionXMLGradient(
                          borderRadius: BorderRadius.circular(16),
                          child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(data.logo, fit: BoxFit.contain)
                              )
                          ),
                        ),
                      ),

                      // --- ESTADO 2: EXPANDIDO (Imagen + Overlay) ---
                      AnimatedOpacity(
                        opacity: isExpanded ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 450),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // ANCLAJE FÍSICO: La imagen no se estira, se recorta.
                            Image.asset(
                                data.imageGrad,
                                fit: BoxFit.cover,
                                alignment: index == 1 ? Alignment.centerLeft : Alignment.centerRight
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      data.nombre,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.clip,
                                    )
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}

class _LocalData {
  final String nombre, imageGrad, logo;
  _LocalData(this.nombre, this.imageGrad, this.logo);
}