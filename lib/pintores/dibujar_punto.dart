import 'package:flutter/material.dart';

class DibujarPunto {
  final Offset posicion;
  final Color color;

  DibujarPunto({required this.posicion, this.color = Colors.white});

  void dibujar(Canvas lienzo, Size size, double escala) {
    final pincelPunto = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    lienzo.drawCircle(posicion, 6 / escala, pincelPunto);
  }
}
