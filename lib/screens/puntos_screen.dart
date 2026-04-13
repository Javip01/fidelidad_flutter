import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'register_screen.dart'; // Para usar la AnimacionXMLGradient

class PuntosScreen extends StatefulWidget {
  const PuntosScreen({super.key});
  @override
  State<PuntosScreen> createState() => _PuntosScreenState();
}

class _PuntosScreenState extends State<PuntosScreen> {
  // POPUP CENTRAL DEL QR (Se mantiene oscuro para visibilidad)
  void _mostrarQrPopup() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      barrierDismissible: true,
      barrierLabel: 'Cerrar',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E), // VENTANA QR OSCURA
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF8B0000), width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Tu Código QR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: QrImageView(
                      data: "USER_QR_${DateTime.now().millisecondsSinceEpoch}",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // MODO CLARO
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. CABECERA TUS PUNTOS CON BOTÓN ATRÁS INTEGRADO
              AnimacionXMLGradient(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Contenido de Puntos
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Column(
                            children: const [
                              Text("TUS PUNTOS", style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12)),
                              Text("1.250", style: TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      // BOTÓN VOLVER ATRÁS (Dentro de la tarjeta, arriba a la izquierda)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white70),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2. INFO BANNER (Modo Claro)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.info, color: Colors.blue, size: 18),
                    SizedBox(width: 8),
                    Text(
                        "Pulsa nuestro logo central para abrir tu código QR.",
                        style: TextStyle(color: Colors.black54, fontSize: 12)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. TÍTULOS PESTAÑAS
              Row(
                children: [
                  Expanded(child: _buildTabTitle("Restaurantes", true)),
                  const SizedBox(width: 4),
                  Expanded(child: _buildTabTitle("Experiencias", false)),
                ],
              ),
              const SizedBox(height: 8),

              // 4. CUADRÍCULA Y BOTÓN CENTRAL
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: _buildImageCell("lib/assets/elrinconguay_grad.png", "lib/assets/elrinconguay.png", Alignment.center)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildImageCell("lib/assets/saunalava_grad.png", "lib/assets/saunalava.png", Alignment.center)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: _buildImageCell("lib/assets/onelove_grad.png", "lib/assets/onelove.png", Alignment.centerLeft)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildImageCell("lib/assets/theringprivate_grad.png", "lib/assets/thering.png", Alignment.centerRight)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: _buildImageCell("lib/assets/rebelflame_grad.png", "lib/assets/rebelflame.png", Alignment.bottomCenter)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildImageCell("lib/assets/saunatoledo_grad.png", "lib/assets/saunatoledo.png", Alignment.bottomCenter)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // BOTÓN LOGO CENTRAL
                    Center(
                      child: GestureDetector(
                        onTap: _mostrarQrPopup,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF8B0000), width: 3),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)],
                            image: const DecorationImage(image: AssetImage('lib/assets/logo.png'), fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabTitle(String title, bool isLeft) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF8B0000),
        borderRadius: isLeft
            ? const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
            : const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }

  Widget _buildImageCell(String bgPath, String logoPath, Alignment logoAlignment) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(bgPath, fit: BoxFit.cover),
          Container(color: Colors.black26),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: logoAlignment,
              child: Image.asset(logoPath, width: 70, height: 70, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}