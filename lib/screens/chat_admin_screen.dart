import 'package:flutter/material.dart';

class ChatAdminScreen extends StatelessWidget {
  const ChatAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color colorPrimary = Color(0xFF8B0000);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Modo claro
      appBar: AppBar(
        title: const Text("Soporte Técnico"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Mensaje Admin (Izquierda) - Tarjeta blanca
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(right: 60, bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                    ),
                    child: const Text(
                      "¡Hola! Bienvenido al soporte técnico de Fidelidad Multimarca. ¿En qué te podemos ayudar hoy?",
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ),
                ),
                // Mensaje Usuario (Derecha) - Tarjeta roja
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 60, bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: colorPrimary.withOpacity(0.3), blurRadius: 4)],
                    ),
                    child: const Text(
                      "Tengo una duda con los puntos de Sauna Lavapiés.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ZONA DE ESCRIBIR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Escribe un mensaje...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: colorPrimary, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}