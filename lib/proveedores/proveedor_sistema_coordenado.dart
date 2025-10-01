import 'package:flutter/material.dart';
import 'package:transformaciones_app/logica_transformacion/control_transformacion.dart';
import 'package:transformaciones_app/logica_transformacion/figura_transformada.dart';
import 'package:transformaciones_app/logica_transformacion/matriz2x2.dart';

class ProveedorSistemaTransformado extends ChangeNotifier {
  final figura = FiguraTransformada();
  final control = ControlTransformacion();

  bool mostrarHomotecia = false;
  bool rellenarFigura = true;

  ProveedorSistemaTransformado() {
    control.onCambioRazon = () {
      figura.recalcularHomotecia(razon: control.razon);
      notifyListeners();
    };
  }

  void setRellenarFigura(bool valor) {
    rellenarFigura = valor;
    notifyListeners();
  }

  void setMostrarHomotecia(bool valor) {
    mostrarHomotecia = valor;
    notifyListeners();
  }

  void agregarPunto(Offset punto) {
    figura.agregar(punto);
    notifyListeners();
  }

  void borrarFigura() {
    figura.borrar();
    notifyListeners();
  }

  void moverReferencia(Offset desplazamiento) {
    figura.moverReferencia(desplazamiento);
    notifyListeners();
  }

  void aplicarTransformacion(Matriz2x2 matriz) {
    figura.aplicar(matriz);
    notifyListeners();
  }

  void aplicarTransformacionRespecto(Matriz2x2 matriz) {
    figura.aplicarRespecto(matriz);
    notifyListeners();
  }

  void aplicarHomotecia() {
    aplicarTransformacionRespecto(
      Matriz2x2.escalado(control.razon, control.razon),
    );
    notifyListeners();
  }

  void rotarRespectoCentro(double angulo) {
    aplicarTransformacion(Matriz2x2.rotacion(angulo));
  }

  void rotarRespectoPunto(double angulo) {
    aplicarTransformacionRespecto(Matriz2x2.rotacion(angulo));
  }

  void reflejarRespectoEjeX() {
    aplicarTransformacion(Matriz2x2.reflexionX());
  }

  void reflejarRespectoEjeY() {
    aplicarTransformacion(Matriz2x2.reflexionY());
  }

  void reflejarRespectoAngulo(double angulo) {
    aplicarTransformacionRespecto(Matriz2x2.reflexionAngular(angulo));
  }
}
