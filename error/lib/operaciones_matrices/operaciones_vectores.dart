import 'dart:math';

import 'package:flutter/widgets.dart';

class TransformacionesLineales {
  static List<List<double>> matrizRotacion(double radianes) {
    final c = cos(radianes);
    final s = sin(radianes);
    return [
      [c, -s],
      [s, c],
    ];
  }

  static Offset multiplicarMatrizVector(
    List<List<double>> matriz,
    Offset vector,
  ) {
    final x = matriz[0][0] * vector.dx + matriz[0][1] * vector.dy;
    final y = matriz[1][0] * vector.dx + matriz[1][1] * vector.dy;
    return Offset(x, y);
  }

  static List<List<double>> matrizBase(Offset u, Offset v) {
    return [
      [u.dx, v.dx],
      [u.dy, v.dy],
    ];
  }

  static List<List<double>> matrizInversa(List<List<double>> matriz) {
    final a = matriz[0][0], b = matriz[0][1];
    final c = matriz[1][0], d = matriz[1][1];
    final det = a * d - b * c;
    if (det == 0) throw Exception("Matriz no es invertible");

    return [
      [d / det, -b / det],
      [-c / det, a / det],
    ];
  }
}
