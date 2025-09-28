import 'package:flutter/material.dart';
import 'package:transformaciones_app/logica_transformacion/vector_coordenado.dart';

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

    List<Offset> puntosConvertidos = vectores.map((p) {
      return p.aCoordenadasCanonicas();
    }).toList();

    for (final p in puntosConvertidos) {
      canvas.drawCircle(p, 4 / escala, punto);
    }

    if (puntosConvertidos.length > 2) {
      final path = Path()
        ..moveTo(puntosConvertidos[0].dx, puntosConvertidos[0].dy);
      for (int i = 1; i < puntosConvertidos.length; i++) {
        path.lineTo(puntosConvertidos[i].dx, puntosConvertidos[i].dy);
      }
      path.close();
      canvas.drawPath(path, relleno);
      canvas.drawPath(path, linea);
    }
  }
}
