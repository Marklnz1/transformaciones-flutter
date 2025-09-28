import 'dart:math';
import 'dart:ui';

import 'package:transformaciones_app/operaciones_matrices/operaciones_vectores.dart';

class BaseTransform {
  Offset baseU0, baseV0;
  double rotDegrees;

  BaseTransform({
    required this.baseU0,
    required this.baseV0,
    this.rotDegrees = 0,
  });

  /// 1) Ejes canónicos rotados
  Offset get _uCanonRot {
    final rad = rotDegrees * pi / 180;
    return Offset(cos(rad), sin(rad));
  }

  Offset get _vCanonRot {
    final rad = rotDegrees * pi / 180;
    return Offset(-sin(rad), cos(rad));
  }

  /// 2) Mapea un vector (en canónico) a la base (U0, V0)
  Offset _mapToBase(Offset v) {
    return Offset(
      v.dx * baseU0.dx + v.dy * baseV0.dx,
      v.dx * baseU0.dy + v.dy * baseV0.dy,
    );
  }

  /// 3) Nuevas bases en coordenadas de pantalla
  Offset get baseU => _mapToBase(_uCanonRot);
  Offset get baseV => _mapToBase(_vCanonRot);

  /// 4) Matriz base 2×2 y su inversa
  List<List<double>> get matrixBase => [
    [baseU.dx, baseV.dx],
    [baseU.dy, baseV.dy],
  ];

  List<List<double>> get matrixInverse =>
      TransformacionesLineales.matrizInversa(matrixBase);
}
