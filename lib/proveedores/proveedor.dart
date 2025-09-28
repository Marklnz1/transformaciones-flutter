import 'package:flutter/material.dart';
import 'package:transformaciones_app/logica_transformacion/sistema_coordenado.dart';

class Proveedor extends ChangeNotifier {
  SistemaCoordenado sistemaCoordenado = SistemaCoordenado(
    baseU: Offset(1, 0),
    baseV: Offset(0, 1),
  );
  void moverCentro(Offset desplazamiento) {
    sistemaCoordenado.moverCentro(desplazamiento);
    notifyListeners();
  }

  void borrarFigura() {
    sistemaCoordenado.borrarFigura();
    notifyListeners();
  }

  void agregarPuntoCoordenadasScreen(Offset position) {
    try {
      sistemaCoordenado.agregarPuntoCoordenadasScreen(position);
    } catch (e) {}
    notifyListeners();
  }

  void reflejarEnU() {
    sistemaCoordenado.reflejarEnU();
    notifyListeners();
  }

  void reflejarEnV() {
    sistemaCoordenado.reflejarEnV();
    notifyListeners();
  }

  void rotarBase(int direccion) {
    sistemaCoordenado.rotarBase(direccion);
    notifyListeners();
  }

  void rotarPantalla(int direccion) {
    sistemaCoordenado.rotarPantalla(direccion);
    notifyListeners();
  }

  void reiniciarBase() {
    sistemaCoordenado.reiniciarBase();
    notifyListeners();
  }
}
