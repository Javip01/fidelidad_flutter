import 'package:flutter/material.dart';

class Oferta {
  final String texto;
  final Color color;

  Oferta({required this.texto, required this.color});
}

class OfertaCupon {
  final String texto;
  final String puntos;

  OfertaCupon({required this.texto, required this.puntos});
}