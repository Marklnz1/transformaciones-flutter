import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/utils/cuadricula_utils.dart';

class DibujarCuadricula {
  final Offset baseU;
  final Offset baseV;
  final int columnas;
  final int filas;
  final Color colorCuadricula;
  final double grosorLinea;

  DibujarCuadricula({
    required this.baseU,
    required this.baseV,
    this.columnas = 10,
    this.filas = 10,
    this.colorCuadricula = const Color(0xFF1F748F),
    this.grosorLinea = 1.0,
  });

  void dibujar(Canvas canvas, Size size, double escala) {
    final pincel = Paint()
      ..color = colorCuadricula
      ..strokeWidth = grosorLinea / escala;

    final lineas = generarLineasDeCuadricula(
      vectorX: baseU,
      vectorY: baseV,
      columnas: columnas,
      filas: filas,
    );

    for (var linea in lineas) {
      canvas.drawLine(linea.inicio, linea.fin, pincel);
    }
  }
}
