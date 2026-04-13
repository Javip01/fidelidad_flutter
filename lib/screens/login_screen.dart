import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FONDO CON LA ANIMACIÓN DE LOS GRADIENTES XML
          const Positioned.fill(
            child: AnimacionXMLGradient(
              borderRadius: BorderRadius.zero,
              child: SizedBox.expand(),
            ),
          ),

          // CONTENIDO DEL LOGIN
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LOGO CIRCULAR
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B0000),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)],
                    ),
                    child: const CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('lib/assets/logo.png')
                    ),
                  ),
                  const SizedBox(height: 20),

                  // TARJETA DE LOGIN (Modo Claro)
                  Card(
                    color: Colors.white, // MODO CLARO
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(color: Color(0xFF8B0000), width: 1.5),
                    ),
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTextField("E-Mail o DNI", false),
                          const SizedBox(height: 16),
                          _buildTextField("Contraseña", true),

                          // OLVIDÉ LA CONTRASEÑA
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/olvide_password'),
                              child: const Text(
                                  'Olvidé la Contraseña',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // BOTÓN INICIAR SESIÓN
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B0000),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                              child: const Text('Iniciar Sesion', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ENLACE AL REGISTRO
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/registro'),
                    child: const Text(
                        '¿Todavía no estas registrado? Registrate Aqui',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Textfields en Modo Claro adaptados al estilo del registro
  Widget _buildTextField(String label, bool obscure) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.black), // Texto Negro
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: const Color(0xFFF5F5F5), // Fondo gris clarito
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF8B0000), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: obscure ? const Icon(Icons.remove_red_eye, color: Color(0xFF8B0000)) : null,
      ),
    );
  }
}

// ANIMACIÓN XML REUTILIZABLE (Igual que en Registro para que funcione sin dependencias extra)
class AnimacionXMLGradient extends StatefulWidget {
  final Widget child;
  final BorderRadius borderRadius;
  const AnimacionXMLGradient({super.key, required this.child, required this.borderRadius});

  @override
  State<AnimacionXMLGradient> createState() => _AnimacionXMLGradientState();
}

class _AnimacionXMLGradientState extends State<AnimacionXMLGradient> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final LinearGradient grad1 = const LinearGradient(colors: [Color(0xFF0A0A0A), Color(0xFF3E0000)], begin: Alignment.bottomLeft, end: Alignment.topRight);
  final LinearGradient grad2 = const LinearGradient(colors: [Color(0xFF121212), Color(0xFF8C4A00)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  final LinearGradient grad3 = const LinearGradient(colors: [Color(0xFF000000), Color(0xFF2A0845)], begin: Alignment.bottomRight, end: Alignment.topLeft);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double t = _controller.value * 3;
        LinearGradient currentGradient;
        if (t < 1) currentGradient = LinearGradient.lerp(grad1, grad2, t)!;
        else if (t < 2) currentGradient = LinearGradient.lerp(grad2, grad3, t - 1)!;
        else currentGradient = LinearGradient.lerp(grad3, grad1, t - 2)!;

        return Container(
          decoration: BoxDecoration(borderRadius: widget.borderRadius, gradient: currentGradient),
          child: widget.child,
        );
      },
    );
  }
}