import 'dart:math';
import 'package:flutter/material.dart';

class ControlTransformacion {
  final ctrlRazon = TextEditingController(text: "-1");
  final ctrlRotacionReferencia = TextEditingController(text: "0");

  double get razon => double.tryParse(ctrlRazon.text) ?? -1;
  double get rotacion => double.tryParse(ctrlRotacionReferencia.text) ?? 0;
  double get radianes => rotacion * pi / 180;

  ControlTransformacion() {
    ctrlRazon.addListener(() => onCambioRazon?.call());
  }
  VoidCallback? onCambioRazon;
}
