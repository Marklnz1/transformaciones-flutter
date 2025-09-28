import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transformaciones_app/operaciones_matrices/operaciones_vectores.dart';
import 'package:transformaciones_app/operaciones_matrices/sistema_coordenadas.dart';

class GridProvider extends ChangeNotifier {
  final SistemaCoordenado sistemaCoordenado = SistemaCoordenado();

  GridProvider() {
    // sistema.notificarListeners = notifyListeners;
  }

  void moverCentro(Offset desplazamiento) {
    sistemaCoordenado.centro += desplazamiento;
    notifyListeners();
  }

  void borrarFigura() {
    sistemaCoordenado.puntos.clear();
    notifyListeners();
  }

  void agregarPuntoCoordenadasScreen(Offset position) {
    try {
      sistemaCoordenado.agregarPunto(position);
      notifyListeners();
    } catch (_) {}
  }

  void reflejarEnU() {
    final nuevaBaseV = Offset(
      -sistemaCoordenado.baseV.dx,
      -sistemaCoordenado.baseV.dy,
    );
    sistemaCoordenado.actualizarBase(sistemaCoordenado.baseU, nuevaBaseV);
    notifyListeners();
  }

  void reflejarEnV() {
    final nuevaBaseU = Offset(
      -sistemaCoordenado.baseU.dx,
      -sistemaCoordenado.baseU.dy,
    );
    sistemaCoordenado.actualizarBase(nuevaBaseU, sistemaCoordenado.baseV);
    notifyListeners();
  }

  void rotarBase(int direccion) {
    sistemaCoordenado.rotarBase(direccion);
    notifyListeners();
  }

  void rotarPantalla(int direccion) {
    final radianes = direccion * sistemaCoordenado.gradoRotacion * pi / 180;
    final matrizRot = TransformacionesLineales.matrizRotacion(radianes);

    final nuevoU = TransformacionesLineales.multiplicarMatrizVector(
      matrizRot,
      sistemaCoordenado.baseU,
    );
    final nuevoV = TransformacionesLineales.multiplicarMatrizVector(
      matrizRot,
      sistemaCoordenado.baseV,
    );

    sistemaCoordenado.actualizarBase(nuevoU, nuevoV);
    notifyListeners();
  }

  void reiniciarBase() {
    sistemaCoordenado.reiniciarBase();
    notifyListeners();
  }

  void actualizarGradoRotacion(String valor) {
    final nuevoGrado =
        double.tryParse(valor) ?? sistemaCoordenado.gradoRotacion;
    sistemaCoordenado.gradoRotacion = nuevoGrado;
    notifyListeners();
  }

  void actualizarBaseU(String valorI, String valorJ) {
    final nuevoU = Offset(
      double.tryParse(valorI) ?? sistemaCoordenado.baseU.dx,
      double.tryParse(valorJ) ?? sistemaCoordenado.baseU.dy,
    );
    sistemaCoordenado.actualizarBase(nuevoU, sistemaCoordenado.baseV);
    notifyListeners();
  }

  void actualizarBaseV(String valorI, String valorJ) {
    final nuevoV = Offset(
      double.tryParse(valorI) ?? sistemaCoordenado.baseV.dx,
      double.tryParse(valorJ) ?? sistemaCoordenado.baseV.dy,
    );
    sistemaCoordenado.actualizarBase(sistemaCoordenado.baseU, nuevoV);
    notifyListeners();
  }
}
