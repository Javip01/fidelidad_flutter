import 'package:flutter/material.dart';

class CondicionesScreen extends StatelessWidget {
  const CondicionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color colorPrimary = Color(0xFF8B0000); // Rojo corporativo

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo claro
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5), // AppBar clara
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black), // Icono oscuro
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Términos y Condiciones",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Texto oscuro
              ),
              const SizedBox(height: 16),

              // Text area con Scroll
              Expanded(
                child: SingleChildScrollView(
                  child: const Text(
                    "Aquí irá todo el texto legal de las condiciones de uso de la app de fidelidad. \n\nEl usuario debe leer esto antes de poder continuar...",
                    style: TextStyle(color: Colors.black87, fontSize: 16, height: 1.5), // Texto oscuro
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Botón inferior
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("He leído y acepto", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}