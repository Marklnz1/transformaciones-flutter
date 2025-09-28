import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/logica_transformacion/matriz_transformacion.dart';

class TransformacionesLineales {
  // Matriz de rotación en el plano canónico
  static MatrizTransformacion matrizRotacion(double grados) {
    final radianes = grados * pi / 180;
    final cosA = cos(radianes);
    final sinA = sin(radianes);

    // Matriz de rotación:
    // [cos(θ) -sin(θ)]
    // [sin(θ)  cos(θ)]
    return MatrizTransformacion(cosA, -sinA, sinA, cosA);
  }

  // Rotar un vector en el plano canónico
  static Offset rotarEnPlanoCanonico(Offset vector, double grados) {
    return matrizRotacion(grados).aplicar(vector);
  }

  // Rotar un vector en una base específica
  static Offset rotarVectorBase(Offset vectorU, Offset vectorV, double grados) {
    final radianes = grados * pi / 180;
    final cosA = cos(radianes);
    final sinA = sin(radianes);

    // Combinación lineal de los vectores base rotados
    // u' = u*cos(θ) + v*sin(θ)
    return Offset(
      vectorU.dx * cosA + vectorV.dx * sinA,
      vectorU.dy * cosA + vectorV.dy * sinA,
    );
  }

  // Matrices de reflexión
  static MatrizTransformacion matrizReflexionX() {
    return MatrizTransformacion(1, 0, 0, -1);
  }

  static MatrizTransformacion matrizReflexionY() {
    return MatrizTransformacion(-1, 0, 0, 1);
  }

  // Matrices de cambio de base
  static MatrizTransformacion matrizCambioBase(Offset baseU, Offset baseV) {
    return MatrizTransformacion.desdeBases(baseU, baseV);
  }

  static MatrizTransformacion matrizCambioBaseInversa(
    Offset baseU,
    Offset baseV,
  ) {
    return matrizCambioBase(baseU, baseV).inversa();
  }
}
