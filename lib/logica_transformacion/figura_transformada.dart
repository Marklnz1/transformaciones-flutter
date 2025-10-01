import 'package:flutter/material.dart';
import 'package:transformaciones_app/logica_transformacion/matriz2x2.dart';

class FiguraTransformada {
  List<Offset> originales = [];
  List<Offset> transformados = [];
  List<Offset> homotecia = [];
  Offset referencia = Offset.zero;

  void agregar(Offset punto) {
    originales.add(punto);
    transformados.add(punto);
    recalcularHomotecia();
  }

  void borrar() {
    originales.clear();
    transformados.clear();
    recalcularHomotecia();
  }

  void moverReferencia(Offset delta) {
    referencia += delta;
    recalcularHomotecia();
  }

  void aplicar(Matriz2x2 matriz) {
    transformados = transformados.map((p) => matriz.aplicar(p)).toList();
    recalcularHomotecia();
  }

  void aplicarRespecto(Matriz2x2 matriz) {
    transformados = transformados.map((p) {
      final desplazado = p - referencia;
      final resultado = matriz.aplicar(desplazado) + referencia;
      return resultado;
    }).toList();
    recalcularHomotecia();
  }

  void recalcularHomotecia({double razon = -1}) {
    final matriz = Matriz2x2.escalado(razon, razon);
    homotecia = transformados.map((p) {
      final desplazado = p - referencia;
      return matriz.aplicar(desplazado) + referencia;
    }).toList();
  }
}
