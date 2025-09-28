import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/logica_transformacion/matriz_transformacion.dart';
import 'package:transformaciones_app/logica_transformacion/transformaciones_lineales.dart';
import 'package:transformaciones_app/logica_transformacion/vector_coordenado.dart';
import 'package:transformaciones_app/pintores/dibujar_cruz.dart';
import 'package:transformaciones_app/pintores/dibujar_figura.dart';
import 'package:transformaciones_app/pintores/dibujar_grid.dart';

class SistemaCoordenado {
  double escala = 100;

  final ctrlRotacion = TextEditingController(text: '1.0');

  final ctrlEjeUi = TextEditingController(text: '1');
  final ctrlEjeUj = TextEditingController(text: '0');
  final ctrlEjeVi = TextEditingController(text: '0');
  final ctrlEjeVj = TextEditingController(text: '1');

  Offset baseU;
  Offset baseV;
  Offset centroEnPantalla = Offset(0, 0);
  List<VectorCoordenado> puntos = [];
  double gradoRotacion = 0.5;

  SistemaCoordenado({required this.baseU, required this.baseV}) {
    ctrlEjeUi.addListener(_onBaseCambiada);
    ctrlEjeUj.addListener(_onBaseCambiada);
    ctrlEjeVi.addListener(_onBaseCambiada);
    ctrlEjeVj.addListener(_onBaseCambiada);
  }

  void _onBaseCambiada() {
    baseU = Offset(
      double.tryParse(ctrlEjeUi.text) ?? 0,
      double.tryParse(ctrlEjeUj.text) ?? 0,
    );
    baseV = Offset(
      double.tryParse(ctrlEjeVi.text) ?? 0,
      double.tryParse(ctrlEjeVj.text) ?? 0,
    );
  }

  void borrarFigura() {
    puntos.clear();
  }

  void reiniciarBase() {
    // Volver a la base canónica
    definirBase(Offset(1, 0), Offset(0, 1));
    centroEnPantalla = Offset.zero;
  }

  void agregarPuntoCoordenadasScreen(Offset position) {
    // Convertir posición de pantalla a coordenadas canónicas
    agregarPuntoCoordenadasCanonicas((position - centroEnPantalla) / escala);
  }

  void agregarPuntoCoordenadasCanonicas(Offset position) {
    puntos.add(
      VectorCoordenado(
        sistemaCoordenado: this,
        coordenadasRelativas: proyectarPuntoCanonico(
          coordenadasCanonicas: position,
        ),
      ),
    );
  }

  void reflejarEnV() {
    // Reflejar la base U respecto al eje V
    definirBaseU(baseU * -1);
  }

  void reflejarEnU() {
    // Reflejar la base V respecto al eje U
    definirBaseV(baseV * -1);
  }

  Offset proyectarPuntoCanonico({required Offset coordenadasCanonicas}) {
    // Convertir coordenadas canónicas (x,y) a coordenadas relativas (u,v)
    // Usando la matriz inversa de la base
    MatrizTransformacion matrizBase = MatrizTransformacion.desdeBases(
      baseU,
      baseV,
    );
    try {
      MatrizTransformacion matrizInversa = matrizBase.inversa();
      return matrizInversa.aplicar(coordenadasCanonicas);
    } catch (e) {
      throw Exception("La base no es válida: ${e.toString()}");
    }
  }

  void definirBaseU(Offset nuevaBase) {
    ctrlEjeUi.text = nuevaBase.dx.toString();
    ctrlEjeUj.text = nuevaBase.dy.toString();
  }

  void definirBaseV(Offset nuevaBase) {
    ctrlEjeVi.text = nuevaBase.dx.toString();
    ctrlEjeVj.text = nuevaBase.dy.toString();
  }

  void definirBase(Offset nuevaU, Offset nuevaV) {
    definirBaseU(nuevaU);
    definirBaseV(nuevaV);
  }

  void moverCentro(Offset desplazamiento) {
    centroEnPantalla += desplazamiento;
  }

  void rotarBase(int direccion) {
    // Rotar los vectores base usando matriz de rotación
    final nuevaU = TransformacionesLineales.rotarVectorBase(
      baseU,
      baseV,
      gradoRotacion * direccion,
    );
    final nuevaV = TransformacionesLineales.rotarVectorBase(
      baseV,
      baseU * -1,
      gradoRotacion * direccion,
    );

    definirBase(nuevaU, nuevaV);
  }

  void rotarPantalla(int direccion) {
    // Rotar ambos vectores base en el plano canónico
    MatrizTransformacion matrizRotacion =
        TransformacionesLineales.matrizRotacion(gradoRotacion * direccion);

    final nuevaU = matrizRotacion.aplicar(baseU);
    final nuevaV = matrizRotacion.aplicar(baseV);

    definirBase(nuevaU, nuevaV);
  }

  void dibujar(Canvas canvas, Size size, double escala) {
    canvas.translate(
      centroEnPantalla.dx / escala,
      centroEnPantalla.dy / escala,
    );

    DibujarCuadricula(
      columnas: 100,
      filas: 100,
      colorCuadricula: const Color(0xFF488FA5),
      grosorLinea: 1.5,
      baseU: baseU,
      baseV: baseV,
    ).dibujar(canvas, size, escala);
    DibujarCruz(baseU: baseU, baseV: baseV).dibujar(canvas, size, escala);
    DibujarFigura(
      vectores: puntos,
      baseU: baseU,
      baseV: baseV,
    ).dibujar(canvas, size, escala);
    canvas.translate(-centroEnPantalla.dx, -centroEnPantalla.dy);
  }
}
