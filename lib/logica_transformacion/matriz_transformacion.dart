import 'dart:math';

import 'package:flutter/material.dart';

class MatrizTransformacion {
  // Matriz de 2x2 representada como [a, b, c, d] donde:
  // [a b]
  // [c d]
  final double a, b, c, d;

  MatrizTransformacion(this.a, this.b, this.c, this.d);

  // Constructor para crear una matriz de rotación
  // La matriz de rotación tiene la forma:
  // [cos(θ) -sin(θ)]
  // [sin(θ)  cos(θ)]
  MatrizTransformacion.rotacion(double gradosAngulo)
    : a = cos(gradosAngulo * pi / 180),
      b = -sin(gradosAngulo * pi / 180),
      c = sin(gradosAngulo * pi / 180),
      d = cos(gradosAngulo * pi / 180);

  // Constructor para crear la matriz identidad
  // [1 0]
  // [0 1]
  MatrizTransformacion.identidad() : a = 1, b = 0, c = 0, d = 1;

  // Constructor para crear matriz de reflexión en X
  // [1  0]
  // [0 -1]
  MatrizTransformacion.reflexionX() : a = 1, b = 0, c = 0, d = -1;

  // Constructor para crear matriz de reflexión en Y
  // [-1 0]
  // [ 0 1]
  MatrizTransformacion.reflexionY() : a = -1, b = 0, c = 0, d = 1;

  // Aplicar la transformación a un vector
  // [a b] [x] = [ax + by]
  // [c d] [y]   [cx + dy]
  Offset aplicar(Offset vector) {
    return Offset(a * vector.dx + b * vector.dy, c * vector.dx + d * vector.dy);
  }

  // Multiplicar dos matrices
  // [a b] [e f] = [ae + bg  af + bh]
  // [c d] [g h]   [ce + dg  cf + dh]
  MatrizTransformacion multiplicar(MatrizTransformacion otra) {
    return MatrizTransformacion(
      a * otra.a + b * otra.c,
      a * otra.b + b * otra.d,
      c * otra.a + d * otra.c,
      c * otra.b + d * otra.d,
    );
  }

  // Obtener el determinante
  // det([a b]) = ad - bc
  //    ([c d])
  double determinante() {
    return a * d - b * c;
  }

  // Obtener la matriz inversa
  // inv([a b]) = 1/(ad-bc) * [ d  -b]
  //     ([c d])              [-c   a]
  MatrizTransformacion inversa() {
    final det = determinante();
    if (det == 0) {
      throw Exception("La matriz no tiene inversa (determinante = 0)");
    }

    return MatrizTransformacion(d / det, -b / det, -c / det, a / det);
  }

  // Crear matriz a partir de dos vectores base
  // Si baseU = (ux, uy) y baseV = (vx, vy), entonces:
  // [ux vx]
  // [uy vy]
  static MatrizTransformacion desdeBases(Offset baseU, Offset baseV) {
    return MatrizTransformacion(baseU.dx, baseV.dx, baseU.dy, baseV.dy);
  }
}
