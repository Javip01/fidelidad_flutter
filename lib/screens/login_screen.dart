import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF330000), Colors.black],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Color(0xFF8B0000), shape: BoxShape.circle),
              child: const CircleAvatar(radius: 65, backgroundColor: Colors.white, backgroundImage: AssetImage('lib/assets/logo.png')),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)]),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // BUG CORREGIDO: Texto negro en el Input
                  const TextField(
                    style: TextStyle(color: Colors.black), // Texto que escribe el usuario en negro
                    decoration: InputDecoration(
                      labelText: 'E-Mail o DNI',
                      labelStyle: TextStyle(color: Colors.grey), // Label gris
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // BUG CORREGIDO: Texto negro en el Input
                  const TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black), // Texto que escribe el usuario en negro
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.remove_red_eye, color: Color(0xFF8B0000)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/olvide_password'),
                      child: const Text('Olvidé la Contraseña', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/registro'),
              child: const Text('¿Todavía no estas registrado? Registrate Aqui', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}