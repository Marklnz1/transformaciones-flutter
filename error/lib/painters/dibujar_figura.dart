import 'package:flutter/material.dart';
import 'package:transformaciones_app/operaciones_matrices/vector_coordenado.dart';

class DibujarFigura {
  final Offset baseU;
  final Offset baseV;
  final List<VectorCoordenado> vectores;

  DibujarFigura({
    required this.vectores,
    required this.baseU,
    required this.baseV,
  });

  void dibujar(Canvas canvas, Size size, double escala) {
    final relleno = Paint()
      ..color = Colors.yellow.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final linea = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2 / escala
      ..style = PaintingStyle.stroke;

    final punto = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (final p in vectores) {
      canvas.drawCircle(p.canonico, 4 / escala, punto);
    }

    if (vectores.length > 2) {
      final path = Path()
        ..moveTo(vectores[0].canonico.dx, vectores[0].canonico.dy);
      for (int i = 1; i < vectores.length; i++) {
        path.lineTo(vectores[i].canonico.dx, vectores[i].canonico.dy);
      }
      path.close();
      canvas.drawPath(path, relleno);
      canvas.drawPath(path, linea);
    }
  }
}
