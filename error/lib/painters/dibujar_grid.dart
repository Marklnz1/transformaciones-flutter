import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/utils/grid_utils.dart';

class DibujarGrid {
  final Offset baseU;
  final Offset baseV;
  final int columns;
  final int rows;
  final Color gridColor;
  final double strokeWidth;

  DibujarGrid({
    required this.baseU,
    required this.baseV,
    this.columns = 10,
    this.rows = 10,
    this.gridColor = const Color(0xFF1F748F),
    this.strokeWidth = 1.0,
  });
  void dibujar(Canvas canvas, Size size, double escala) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = strokeWidth / escala;

    // final axisPaint = Paint()
    //   ..color = Colors.blue
    //   ..strokeWidth = strokeWidth + 1;

    final lines = computeGridLinesFromCenter(
      size: size,
      vectorX: baseU,
      vectorY: baseV,
      columns: columns,
      rows: rows,
    );

    for (var line in lines) {
      canvas.drawLine(line.start, line.end, gridPaint);
    }
  }
}
