import 'package:flutter/material.dart';

class DibujarLinea {
  final Offset inicio;
  final Offset fin;

  DibujarLinea({required this.inicio, required this.fin});

  void dibujar(Canvas lienzo, Size size, double escala) {
    final pincelLinea = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1 / escala;

    lienzo.drawLine(inicio, fin, pincelLinea);
  }
}
