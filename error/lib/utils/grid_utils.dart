import 'package:flutter/material.dart';

class Line {
  final Offset start;
  final Offset end;
  Line({required this.start, required this.end});
}

List<Line> computeGridLinesFromCenter({
  required Size size,
  required Offset vectorX,
  required Offset vectorY,
  required int columns, // número de líneas verticales
  required int rows, // número de líneas horizontales
}) {
  final int halfColumns = (columns / 2).floor();
  final int halfRows = (rows / 2).floor();
  final lines = <Line>[];

  // Líneas paralelas a vY, desplazadas a lo largo de vX
  for (int i = -halfColumns; i <= halfColumns; i++) {
    final origin = vectorX * i.toDouble();
    final start = origin - vectorY * halfRows.toDouble();
    final end = origin + vectorY * halfRows.toDouble();
    lines.add(Line(start: start, end: end));
  }

  // Líneas paralelas a vX, desplazadas a lo largo de vY
  for (int j = -halfRows; j <= halfRows; j++) {
    final origin = vectorY * j.toDouble();
    final start = origin - vectorX * halfColumns.toDouble();
    final end = origin + vectorX * halfColumns.toDouble();
    lines.add(Line(start: start, end: end));
  }

  return lines;
}
