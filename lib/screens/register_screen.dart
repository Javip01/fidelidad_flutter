import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  bool _aceptoCondiciones = false;
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    // Controlador para el fondo animado
    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FONDO ANIMADO (Negro con degradados de colores rotando)
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    center: Alignment.center,
                    colors: const [
                      Color(0xFF0A0A0A), Color(0xFF8B0000),
                      Color(0xFF0A0A0A), Color(0xFF2A0845),
                      Color(0xFF0A0A0A), Color(0xFF8C4A00),
                      Color(0xFF0A0A0A)
                    ],
                    stops: const [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1.0],
                    transform: GradientRotation(_bgController.value * 6.28),
                  ),
                ),
              );
            },
          ),

          // CONTENIDO DEL REGISTRO
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    color: const Color(0xFF1E1E1E), // Fondo oscuro de la tarjeta
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(color: Color(0xFF8B0000), width: 1.5), // Borde rojo
                    ),
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Crear Cuenta", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 32),

                          // SOLO EMAIL Y CONTRASEÑAS
                          _buildTextField("Email", false),
                          _buildTextField("Contraseña", true),
                          _buildTextField("Confirmar Contraseña", true),

                          const SizedBox(height: 8),

                          // CHECKBOX CONDICIONES
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
                                  side: const BorderSide(color: Color(0xFF8B0000)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text("Leer y aceptar Términos y Condiciones", style: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold, fontSize: 13)),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // BOTÓN REGISTRARSE
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

                  // VOLVER AL LOGIN
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text("¿Ya tienes cuenta? Inicia sesión aquí", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
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
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade400),
          filled: true,
          fillColor: const Color(0xFF121212), // Fondo más oscuro para el input
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white12),
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