import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/operaciones_matrices/operaciones_vectores.dart';
import 'package:transformaciones_app/operaciones_matrices/sistema_coordenadas.dart';

class VectorCoordenado {
  final SistemaCoordenado sistema;
  Offset coordenadas;

  VectorCoordenado(this.sistema, this.coordenadas);

  Offset get canonico => sistema.transformarACanonico(coordenadas);

  void rotar(double grados, [Offset centro = Offset.zero]) {
    final radianes = grados * pi / 180;
    final matrizRot = TransformacionesLineales.matrizRotacion(radianes);
    final vectorRelativo = coordenadas - centro;
    final rotated = TransformacionesLineales.multiplicarMatrizVector(
      matrizRot,
      vectorRelativo,
    );
    coordenadas = rotated + centro;
  }
}
