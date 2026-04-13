import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PuntosScreen extends StatefulWidget {
  const PuntosScreen({super.key});
  @override
  State<PuntosScreen> createState() => _PuntosScreenState();
}

class _PuntosScreenState extends State<PuntosScreen> with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    // Animación suave para el fondo de la cabecera de puntos
    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  // POPUP CENTRAL DEL QR
  void _mostrarQrPopup() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
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
                color: const Color(0xFF1E1E1E), // Modo oscuro para el popup
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF8B0000), width: 2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Tu Código QR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text("Muéstralo en la caja del local", style: TextStyle(color: Colors.white54, fontSize: 13)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: QrImageView(
                      data: "USER_QR_${DateTime.now().millisecondsSinceEpoch}",
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
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
      backgroundColor: const Color(0xFF121212), // Fondo general oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // 1. CABECERA TUS PUNTOS
              AnimatedBuilder(
                  animation: _bgController,
                  builder: (context, child) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 1.5,
                          colors: [
                            Color.lerp(const Color(0xFF3E0000), const Color(0xFF1A0000), _bgController.value)!,
                            const Color(0xFF0A0A0A)
                          ],
                        ),
                        border: Border.all(color: const Color(0xFF8B0000).withOpacity(0.3)),
                      ),
                      child: const Column(
                        children: [
                          Text("TUS PUNTOS", style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12)),
                          Text("1.250", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }
              ),
              const SizedBox(height: 16),

              // 2. BANNER DE INFORMACIÓN
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: Colors.lightBlueAccent, size: 18),
                    SizedBox(width: 8),
                    Text("Pulsa nuestro logo central para abrir tu código QR.", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. PESTAÑAS (Títulos)
              Row(
                children: [
                  Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: const BoxDecoration(color: Color(0xFF3E0000), borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))), child: const Text("Restaurantes", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                  const SizedBox(width: 4),
                  Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: const BoxDecoration(color: Color(0xFF3E0000), borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))), child: const Text("Experiencias", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                ],
              ),
              const SizedBox(height: 8),

              // 4. CUADRÍCULA DE IMÁGENES + LOGO CENTRAL (Botón QR)
              Expanded(
                child: Stack(
                  children: [
                    // Fondo con la cuadrícula de 3 filas y 2 columnas
                    Column(
                      children: [
                        // FILA 1: Rincón Guay | Lavapiés
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
                        // FILA 2: One Love | The Ring (Imágenes apartadas para dejar sitio al centro)
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
                        // FILA 3: Rebel Flame | Sauna Toledo
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

                    // BOTÓN CENTRAL (Logo que abre el QR)
                    Center(
                      child: GestureDetector(
                        onTap: _mostrarQrPopup, // ESTE ES EL ÚNICO BOTÓN AHORA
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black, // Fondo negro
                            border: Border.all(color: Colors.white, width: 4), // Borde blanco grueso
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 15, spreadRadius: 5)],
                            image: const DecorationImage(
                              image: AssetImage('lib/assets/logo.png'), // Tu logo principal
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Constructor de las celdas de fondo (No son clicables, solo visuales)
  Widget _buildImageCell(String bgPath, String logoPath, Alignment logoAlignment) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo
          Image.asset(bgPath, fit: BoxFit.cover),
          // Oscurecedor sutil para que el logo resalte
          Container(color: Colors.black.withOpacity(0.4)),
          // Logo posicionado
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: logoAlignment,
              child: Image.asset(logoPath, width: 80, height: 80, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}