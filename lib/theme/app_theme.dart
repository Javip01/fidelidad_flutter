import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF8B0000); // Tu rojo oscuro
  static const Color background = Color(0xFFF5F5F5); // Gris muy claro para el fondo
  static const Color surface = Colors.white; // Blanco puro para tarjetas
  static const Color textPrimary = Colors.black87; // Texto casi negro

  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.light(
      primary: primary,
      surface: surface,
      onSurface: textPrimary,
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}