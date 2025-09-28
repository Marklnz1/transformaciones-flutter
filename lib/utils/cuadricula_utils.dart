import 'package:flutter/material.dart';

class Linea {
  final Offset inicio;
  final Offset fin;

  Linea({required this.inicio, required this.fin});
}

List<Linea> generarLineasDeCuadricula({
  required Offset vectorX,
  required Offset vectorY,
  required int columnas,
  required int filas,
}) {
  final mitadColumnas = (columnas / 2).floor();
  final mitadFilas = (filas / 2).floor();
  final lineas = <Linea>[];

  for (int i = -mitadColumnas; i <= mitadColumnas; i++) {
    final punto = vectorX * i.toDouble();
    final inicio = punto - vectorY * mitadFilas.toDouble();
    final fin = punto + vectorY * mitadFilas.toDouble();
    lineas.add(Linea(inicio: inicio, fin: fin));
  }

  for (int j = -mitadFilas; j <= mitadFilas; j++) {
    final punto = vectorY * j.toDouble();
    final inicio = punto - vectorX * mitadColumnas.toDouble();
    final fin = punto + vectorX * mitadColumnas.toDouble();
    lineas.add(Linea(inicio: inicio, fin: fin));
  }

  return lineas;
}
