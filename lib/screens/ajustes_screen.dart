import 'package:flutter/material.dart';

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color colorPrimary = Color(0xFF8B0000); // Tu rojo característico

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo claro
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Configuración",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),

              // TARJETA 1: PERFIL (CON BORDE ROJIZO)
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: colorPrimary, width: 1.5), // MARCO ROJIZO RESTAURADO
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Nombre de Usuario", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 4),
                      Text("usuario@fidelidad.com", style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/editar_perfil'),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("Editar Perfil", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colorPrimary)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // TARJETA 2: CHAT SOPORTE (CON BORDE ROJIZO)
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: colorPrimary, width: 1.5), // MARCO ROJIZO RESTAURADO
                ),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/chat'),
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(child: Text("Chat con Administrador", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
                        Icon(Icons.email, color: Colors.black87, size: 30),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // TARJETA 3: LEGALES (CON BORDE ROJIZO)
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: colorPrimary, width: 1.5), // MARCO ROJIZO RESTAURADO
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text("◉ Términos y Condiciones", style: TextStyle(fontSize: 15, color: Colors.black87)),
                        onTap: () => Navigator.pushNamed(context, '/condiciones'),
                      ),
                      Divider(height: 1, color: Colors.grey.shade300),
                      ListTile(
                        title: const Text("◉ Aviso Legal", style: TextStyle(fontSize: 15, color: Colors.black87)),
                        onTap: () => Navigator.pushNamed(context, '/condiciones'),
                      ),
                      Divider(height: 1, color: Colors.grey.shade300),
                      ListTile(
                        title: const Text("◉ Preguntas Frecuentes (FAQ)", style: TextStyle(fontSize: 15, color: Colors.black87)),
                        onTap: () => Navigator.pushNamed(context, '/condiciones'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // BOTÓN ELIMINAR CUENTA
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: colorPrimary, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    _mostrarDialogoEliminar(context);
                  },
                  child: const Text("ELIMINAR CUENTA", style: TextStyle(color: colorPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("¿Eliminar cuenta?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        content: const Text("Esta acción es irreversible y perderás todos tus puntos.", style: TextStyle(color: Colors.black87)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar", style: TextStyle(color: Colors.black))),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
            child: const Text("ELIMINAR", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}