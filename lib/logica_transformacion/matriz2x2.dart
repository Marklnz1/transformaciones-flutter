import 'dart:math';
import 'package:flutter/material.dart';

class Matriz2x2 {
  final double a, b;
  final double c, d;

  const Matriz2x2(this.a, this.b, this.c, this.d);

  /// Identidad
  const Matriz2x2.identidad() : a = 1, b = 0, c = 0, d = 1;

  /// Escalado
  factory Matriz2x2.escalado(double sx, double sy) {
    return Matriz2x2(sx, 0, 0, sy);
  }

  /// Rotación
  factory Matriz2x2.rotacion(double grados) {
    final rad = grados * pi / 180;
    final cosT = cos(rad);
    final sinT = sin(rad);
    return Matriz2x2(cosT, -sinT, sinT, cosT);
  }

  /// Reflexión en X
  const Matriz2x2.reflexionX() : a = 1, b = 0, c = 0, d = -1;

  /// Reflexión en Y
  const Matriz2x2.reflexionY() : a = -1, b = 0, c = 0, d = 1;

  /// Reflexión angular
  factory Matriz2x2.reflexionAngular(double radianes) {
    final cos2A = cos(2 * radianes);
    final sin2A = sin(2 * radianes);
    return Matriz2x2(cos2A, sin2A, sin2A, -cos2A);
  }

  /// Aplica la transformación a un punto
  Offset aplicar(Offset punto) {
    final x = a * punto.dx + b * punto.dy;
    final y = c * punto.dx + d * punto.dy;
    return Offset(x, y);
  }

  /// Composición (multiplicación de matrices)
  Matriz2x2 multiplicar(Matriz2x2 otra) {
    return Matriz2x2(
      a * otra.a + b * otra.c,
      a * otra.b + b * otra.d,
      c * otra.a + d * otra.c,
      c * otra.b + d * otra.d,
    );
  }
}
