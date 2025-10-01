import 'dart:math';

import 'package:flutter/material.dart';

class DibujarLineaRotada {
  final Offset posicion;
  final double grados;
  DibujarLineaRotada({required this.posicion, required this.grados});

  void dibujar(Canvas lienzo, Size size, double escala) {
    final radianes = grados * pi / 180;

    final pincelLinea = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5 / escala;

    final longitud = 10000.0;

    final mitad = longitud / 2;

    final dx = mitad * cos(radianes);
    final dy = mitad * sin(radianes);

    final inicio = Offset(posicion.dx - dx, posicion.dy - dy);
    final fin = Offset(posicion.dx + dx, posicion.dy + dy);

    lienzo.drawLine(inicio, fin, pincelLinea);
  }
}
