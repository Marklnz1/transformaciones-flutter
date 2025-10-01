import 'package:flutter/material.dart';

class DibujarCruz {
  void dibujar(Canvas lienzo, Size size, double escala) {
    final pincelLinea = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2 / escala;

    final pincelPunto = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.fill;

    const double longitud = 1000;
    final Offset vectorX = const Offset(1, 0);
    final Offset vectorY = const Offset(0, 1);

    lienzo.drawLine(-vectorX * longitud, vectorX * longitud, pincelLinea);
    lienzo.drawLine(-vectorY * longitud, vectorY * longitud, pincelLinea);
    lienzo.drawCircle(Offset.zero, 8 / escala, pincelPunto);
  }
}
