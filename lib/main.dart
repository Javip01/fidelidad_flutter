import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/olvide_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/puntos_screen.dart';
import 'screens/ajustes_screen.dart';
import 'screens/chat_admin_screen.dart';
import 'screens/editar_perfil_screen.dart';
import 'screens/condiciones_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FidelidadApp());
}

class FidelidadApp extends StatelessWidget {
  const FidelidadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fidelidad App',
      theme: AppTheme.lightTheme, // Cambiado a TEMA CLARO
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registro': (context) => const RegisterScreen(),
        '/olvide_password': (context) => const OlvidePasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/puntos': (context) => const PuntosScreen(),
        // RUTAS DE AJUSTES REPARADAS:
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/chat': (context) => const ChatAdminScreen(),
        '/condiciones': (context) => const CondicionesScreen(),
      },
    );
  }
}