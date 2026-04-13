import 'package:flutter/material.dart';

class LocalPuntosCard extends StatelessWidget {
  final String nombre;
  final VoidCallback onTap;

  const LocalPuntosCard({
    super.key,
    required this.nombre,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 80,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo (puedes cambiar el placeholder por tus assets)
              const Icon(Icons.business, size: 50, color: Colors.white24),
              // Degradado
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
              // Nombre del local alineado a la derecha
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}