import 'package:flutter/material.dart';

class Transaccion {
  final String local;
  final String logoPath;
  final double gasto;
  final int puntos;
  final DateTime fecha;
  final int productosCount;

  Transaccion({
    required this.local,
    required this.logoPath,
    required this.gasto,
    required this.puntos,
    required this.fecha,
    required this.productosCount,
  });

  String get tiempoParaCaducar {
    final fechaCaducidad = fecha.add(const Duration(days: 180));
    final diferencia = fechaCaducidad.difference(DateTime.now());

    if (diferencia.isNegative) return "Caducado";

    final meses = (diferencia.inDays / 30).floor();
    final dias = diferencia.inDays % 30;

    if (meses > 0) {
      return "Caduca en: $meses meses y $dias días";
    } else {
      return "Caduca en: $dias días";
    }
  }

  String get fechaFormateada {
    return "${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year} ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}";
  }
}

// ==========================================
// ESTADO GLOBAL (CEREBRO CENTRAL PROVISIONAL)
// ==========================================
final ValueNotifier<int> globalPuntos = ValueNotifier<int>(1250); // Puntos iniciales
final ValueNotifier<List<Transaccion>> globalHistorial = ValueNotifier<List<Transaccion>>([]); // Historial vacío inicial