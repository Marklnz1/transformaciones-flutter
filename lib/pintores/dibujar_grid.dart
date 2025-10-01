import 'package:flutter/widgets.dart';

class DibujarCuadricula {
  final int columnas;
  final int filas;
  final Color colorCuadricula;
  final double grosorLinea;

  DibujarCuadricula({
    this.columnas = 10,
    this.filas = 10,
    this.colorCuadricula = const Color(0xFF1F748F),
    this.grosorLinea = 1.0,
  });

  void dibujar(Canvas lienzo, Size size, double escala) {
    final pincel = Paint()
      ..color = colorCuadricula
      ..strokeWidth = grosorLinea / escala;

    final mitadColumnas = (columnas / 2).floor();
    final mitadFilas = (filas / 2).floor();
    final vectorX = Offset(1, 0);
    final vectorY = Offset(0, 1);

    for (int i = -mitadColumnas; i <= mitadColumnas; i++) {
      final punto = vectorX * i.toDouble();
      final inicio = punto - vectorY * mitadFilas.toDouble();
      final fin = punto + vectorY * mitadFilas.toDouble();
      lienzo.drawLine(inicio, fin, pincel);
    }

    for (int j = -mitadFilas; j <= mitadFilas; j++) {
      final punto = vectorY * j.toDouble();
      final inicio = punto - vectorX * mitadColumnas.toDouble();
      final fin = punto + vectorX * mitadColumnas.toDouble();
      lienzo.drawLine(inicio, fin, pincel);
    }
  }
}
