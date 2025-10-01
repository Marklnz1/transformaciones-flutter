import 'package:flutter/material.dart';
import 'package:transformaciones_app/logica_transformacion/control_transformacion.dart';
import 'package:transformaciones_app/logica_transformacion/figura_transformada.dart';
import 'package:transformaciones_app/pintores/dibujar_cruz.dart';
import 'package:transformaciones_app/pintores/dibujar_figura.dart';
import 'package:transformaciones_app/pintores/dibujar_grid.dart';
import 'package:transformaciones_app/pintores/dibujar_linea.dart';
import 'package:transformaciones_app/pintores/dibujar_linea_rotada.dart';
import 'package:transformaciones_app/pintores/dibujar_punto.dart';

class RenderizadorSistema {
  final FiguraTransformada figura;
  final ControlTransformacion control;
  bool mostrarHomotecia = false;
  bool rellenar = true;

  RenderizadorSistema(this.figura, this.control);

  void dibujar(Canvas lienzo, Size size, double escala) {
    DibujarCuadricula(
      columnas: 100,
      filas: 100,
      colorCuadricula: Colors.white,
      grosorLinea: 0.5,
    ).dibujar(lienzo, size, escala);

    DibujarCruz().dibujar(lienzo, size, escala);

    DibujarFigura(
      vectores: figura.originales,
      colorLinea: Colors.white,
      colorPunto: Colors.white,
      colorRelleno: Colors.white,
      alphaRelleno: rellenar ? 1 : 0,
    ).dibujar(lienzo, size, escala);

    DibujarFigura(
      vectores: figura.transformados,
      colorLinea: Colors.yellow,
      colorPunto: Colors.yellow,
      colorRelleno: Colors.yellow,
      alphaRelleno: rellenar ? 1 : 0,
    ).dibujar(lienzo, size, escala);

    if (mostrarHomotecia) {
      for (int i = 0; i < figura.originales.length; i++) {
        DibujarLinea(
          inicio: figura.transformados[i],
          fin: figura.homotecia[i],
        ).dibujar(lienzo, size, escala);
      }

      DibujarFigura(
        vectores: figura.homotecia,
        colorLinea: Colors.deepOrange,
        colorPunto: Colors.deepOrange,
        colorRelleno: Colors.deepOrange,
        alphaRelleno: rellenar ? 0.6 : 0,
      ).dibujar(lienzo, size, escala);

      for (int i = 0; i < figura.originales.length; i++) {
        DibujarLinea(
          inicio: figura.referencia,
          fin: figura.homotecia[i],
        ).dibujar(lienzo, size, escala);
      }
    }

    DibujarLineaRotada(
      posicion: figura.referencia,
      grados: control.rotacion,
    ).dibujar(lienzo, size, escala);

    DibujarPunto(
      posicion: figura.referencia,
      color: Colors.green,
    ).dibujar(lienzo, size, escala);
  }
}
