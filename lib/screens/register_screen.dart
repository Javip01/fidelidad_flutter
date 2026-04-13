import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _aceptoCondiciones = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FONDO CON LA ANIMACIÓN DE LOS GRADIENTES XML (Ampliado)
          const Positioned.fill(
            child: AnimacionXMLGradient(
              borderRadius: BorderRadius.zero,
              child: SizedBox.expand(),
            ),
          ),

          // CONTENIDO DEL REGISTRO (Modo Claro)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          const Text(
                              "Crear Cuenta",
                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black) // Texto Negro
                          ),
                          const SizedBox(height: 32),

                          _buildTextField("Email", false),
                          _buildTextField("Contraseña", true),
                          _buildTextField("Confirmar Contraseña", true),

                          const SizedBox(height: 8),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _aceptoCondiciones,
                                  onChanged: (val) => setState(() => _aceptoCondiciones = val!),
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xFF8B0000),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                    "Leer y aceptar Términos y Condiciones",
                                    style: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold, fontSize: 13)
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B0000),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              onPressed: _aceptoCondiciones ? () => Navigator.pushReplacementNamed(context, '/home') : null,
                              child: const Text("Registrarse", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                        "¿Ya tienes cuenta? Inicia sesión aquí",
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

  Widget _buildTextField(String label, bool obscure) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(color: Colors.black), // Texto Negro
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
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
      ),
    );
  }
}

// INCLUYO LA ANIMACIÓN AQUÍ PARA QUE FUNCIONE AL COPIAR/PEGAR
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