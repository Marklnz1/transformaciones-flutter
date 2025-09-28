import 'package:flutter/material.dart';

class DibujarCruz {
  final Offset baseU; // Vector horizontal
  final Offset baseV; // Vector vertical

  DibujarCruz({required this.baseU, required this.baseV});

  void dibujar(Canvas lienzo, Size size, double escala) {
    final pincelLinea = Paint()
      ..color = Colors.white
      ..strokeWidth = 2 / escala;

    final pincelPunto = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    const double longitud = 1000;
    lienzo.drawLine(-baseU * longitud, baseU * longitud, pincelLinea);
    lienzo.drawLine(-baseV * longitud, baseV * longitud, pincelLinea);
    lienzo.drawCircle(Offset.zero, 6 / escala, pincelPunto);
  }
}
