import 'package:flutter/material.dart';

class DibujarCruz {
  final Offset baseU;
  final Offset baseV;

  DibujarCruz({required this.baseU, required this.baseV});

  void dibujar(Canvas canvas, Size size, double escala) {
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2 / escala;

    final dotPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Longitud arbitraria para extender las líneas
    const double longitud = 1000;

    // Línea en dirección baseU
    canvas.drawLine(-baseU * longitud, baseU * longitud, linePaint);

    // Línea en dirección baseV
    canvas.drawLine(-baseV * longitud, baseV * longitud, linePaint);

    // Punto rojo en el centro
    canvas.drawCircle(Offset.zero, 6 / escala, dotPaint);
  }
}
