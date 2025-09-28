import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/operaciones_matrices/base_transformada.dart';
import 'package:transformaciones_app/operaciones_matrices/operaciones_vectores.dart';
import 'package:transformaciones_app/operaciones_matrices/vector_coordenado.dart';
import 'package:transformaciones_app/painters/dibujar_cruz.dart';
import 'package:transformaciones_app/painters/dibujar_figura.dart';
import 'package:transformaciones_app/painters/dibujar_grid.dart';

class SistemaCoordenado {
  double escala = 100;
  Offset centro = Offset.zero;
  List<VectorCoordenado> puntos = [];
  double gradoRotacion = 1;
  double rotacion = 0; // en grados

  final TextEditingController ctrlRotacion = TextEditingController(text: '1.0');
  final TextEditingController ctrlEjeUi = TextEditingController(text: '1');
  final TextEditingController ctrlEjeUj = TextEditingController(text: '0');
  final TextEditingController ctrlEjeVi = TextEditingController(text: '0');
  final TextEditingController ctrlEjeVj = TextEditingController(text: '1');

  // Bases originales sin rotación
  Offset get baseU0 => Offset(
    double.tryParse(ctrlEjeUi.text) ?? 0,
    double.tryParse(ctrlEjeUj.text) ?? 0,
  );
  Offset get baseV0 => Offset(
    double.tryParse(ctrlEjeVi.text) ?? 0,
    double.tryParse(ctrlEjeVj.text) ?? 0,
  );

  // Creamos bajo demanda un BaseTransform actualizado
  BaseTransform get _transform =>
      BaseTransform(baseU0: baseU0, baseV0: baseV0, rotDegrees: rotacion);

  // Ahora sólo delegamos
  Offset get baseU => _transform.baseU;
  Offset get baseV => _transform.baseV;
  List<List<double>> get matrizBase => _transform.matrixBase;
  List<List<double>> get matrizInversa => _transform.matrixInverse;

  // Resto de tu lógica
  void rotarBase(int direccion) {
    rotacion += direccion * gradoRotacion;
  }

  void agregarPunto(Offset posicionPantalla) {
    final puntoCanonico = (posicionPantalla - centro) / escala;
    final coords = TransformacionesLineales.multiplicarMatrizVector(
      matrizInversa,
      puntoCanonico,
    );
    puntos.add(VectorCoordenado(this, coords));
  }

  Offset transformarACanonico(Offset vector) =>
      TransformacionesLineales.multiplicarMatrizVector(matrizBase, vector);
  void actualizarBase(Offset nuevoU, Offset nuevoV) {
    ctrlEjeUi.text = nuevoU.dx.toString();
    ctrlEjeUj.text = nuevoU.dy.toString();
    ctrlEjeVi.text = nuevoV.dx.toString();
    ctrlEjeVj.text = nuevoV.dy.toString();
  }

  void reiniciarBase() {
    actualizarBase(Offset(1, 0), Offset(0, 1));
    centro = Offset.zero;
    rotacion = 0;
  }

  void dibujar(Canvas canvas, Size size, double escala) {
    canvas.translate(centro.dx / escala, centro.dy / escala);

    DibujarGrid(
      baseU: baseU,
      baseV: baseV,
      columns: 100,
      rows: 100,
    ).dibujar(canvas, size, escala);
    DibujarCruz(baseU: baseU, baseV: baseV).dibujar(canvas, size, escala);
    DibujarFigura(
      vectores: puntos,
      baseU: baseU,
      baseV: baseV,
    ).dibujar(canvas, size, escala);

    canvas.translate(-centro.dx, -centro.dy);
  }
}
