import 'package:flutter/widgets.dart';
import 'package:transformaciones_app/logica_transformacion/matriz_transformacion.dart';
import 'package:transformaciones_app/logica_transformacion/transformaciones_lineales.dart';
import 'package:transformaciones_app/logica_transformacion/sistema_coordenado.dart';

class VectorCoordenado {
  SistemaCoordenado sistemaCoordenado;
  Offset coordenadasRelativas;

  VectorCoordenado({
    required this.sistemaCoordenado,
    required this.coordenadasRelativas,
  });

  // Convertir a coordenadas canónicas
  Offset aCoordenadasCanonicas() {
    // Si coordenadasRelativas = (u, v), entonces las coordenadas canónicas son:
    // (x, y) = u*baseU + v*baseV
    MatrizTransformacion matrizBase = MatrizTransformacion.desdeBases(
      sistemaCoordenado.baseU,
      sistemaCoordenado.baseV,
    );
    return matrizBase.aplicar(coordenadasRelativas);
  }

  // Trasladar en coordenadas canónicas
  void trasladarCoordenadasCanonicas(Offset desplazamiento) {
    final canonicas = aCoordenadasCanonicas() + desplazamiento;
    coordenadasRelativas = sistemaCoordenado.proyectarPuntoCanonico(
      coordenadasCanonicas: canonicas,
    );
  }

  // Reflejar respecto a otro vector
  void reflejarRespecto(VectorCoordenado otro) {
    final base = otro.coordenadasRelativas;
    final vector = coordenadasRelativas;

    // Cálculo de la proyección: proyección = (v·b / |b|²) * b
    final dot = vector.dx * base.dx + vector.dy * base.dy;
    final normSq = base.dx * base.dx + base.dy * base.dy;
    final escalar = dot / normSq;
    final proyeccion = Offset(base.dx * escalar, base.dy * escalar);

    // Vector reflejado = 2 * proyección - vector
    final reflejado = Offset(
      2 * proyeccion.dx - vector.dx,
      2 * proyeccion.dy - vector.dy,
    );

    coordenadasRelativas = reflejado;
  }

  // Rotar alrededor de un punto central
  void rotarAlrededorDe({
    required VectorCoordenado centro,
    required double grados,
  }) {
    // 1. Trasladar al origen (restar las coordenadas del centro)
    final centroRelativo = centro.coordenadasRelativas;
    final coordenadasCentro = coordenadasRelativas - centroRelativo;

    // 2. Rotar usando una matriz de rotación
    final matrizRotacion = TransformacionesLineales.matrizRotacion(grados);
    final coordenadasRotadas = matrizRotacion.aplicar(coordenadasCentro);

    // 3. Trasladar de vuelta (sumar las coordenadas del centro)
    coordenadasRelativas = coordenadasRotadas + centroRelativo;
  }

  // Rotar alrededor del origen
  void rotarAlrededorCentro(double grados) {
    final matrizRotacion = TransformacionesLineales.matrizRotacion(grados);
    coordenadasRelativas = matrizRotacion.aplicar(coordenadasRelativas);
  }
}
