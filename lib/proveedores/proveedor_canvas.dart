import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ProveedorCanvas with ChangeNotifier {
  Offset centro = Offset(0, 0);
  double escala = 100;

  void moverCentro(Offset desplazamiento) {
    centro += desplazamiento;
    notifyListeners();
  }

  void reiniciar() {
    centro = Offset(0, 0);
  }

  Offset traducirPosicionPantallaACanvas(Offset posicion) {
    return (posicion - centro) / escala;
  }
}
