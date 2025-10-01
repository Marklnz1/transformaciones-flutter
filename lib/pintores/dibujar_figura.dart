import 'package:flutter/material.dart';

class DibujarFigura {
  final List<Offset> vectores;
  final Color colorRelleno;
  final Color colorLinea;
  final Color colorPunto;
  final double alphaRelleno;

  DibujarFigura({
    required this.vectores,
    this.colorRelleno = Colors.yellow,
    this.colorLinea = Colors.yellow,
    this.colorPunto = Colors.red,
    this.alphaRelleno = 1,
  });

  void dibujar(Canvas lienzo, Size size, double escala) {
    final relleno = Paint()
      ..color = colorRelleno.withOpacity(alphaRelleno)
      ..style = PaintingStyle.fill;

    final linea = Paint()
      ..color = colorLinea
      ..strokeWidth = 4 / escala
      ..style = PaintingStyle.stroke;

    final punto = Paint()
      ..color = colorPunto
      ..style = PaintingStyle.fill;

    for (final p in vectores) {
      lienzo.drawCircle(p, 4 / escala, punto);
    }

    if (vectores.length > 2) {
      final path = Path()..moveTo(vectores[0].dx, vectores[0].dy);
      for (int i = 1; i < vectores.length; i++) {
        path.lineTo(vectores[i].dx, vectores[i].dy);
      }
      path.close();
      lienzo.drawPath(path, relleno);
      lienzo.drawPath(path, linea);
    }
  }
}
