import 'package:flutter/material.dart';
import 'package:transformaciones_app/logica_transformacion/matriz2x2.dart';

class EditorMatriz2x2 extends StatefulWidget {
  final void Function(Matriz2x2 matriz) onConfirmarCentro;
  final void Function(Matriz2x2 matriz) onConfirmarPunto;

  const EditorMatriz2x2({
    super.key,
    required this.onConfirmarCentro,
    required this.onConfirmarPunto,
  });

  @override
  State<EditorMatriz2x2> createState() => _EditorMatriz2x2State();
}

class _EditorMatriz2x2State extends State<EditorMatriz2x2> {
  final TextEditingController aCtrl = TextEditingController(text: '1');
  final TextEditingController bCtrl = TextEditingController(text: '0');
  final TextEditingController cCtrl = TextEditingController(text: '0');
  final TextEditingController dCtrl = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fila(aCtrl, bCtrl),
        const SizedBox(height: 6),
        _fila(cCtrl, dCtrl),
        const SizedBox(height: 12),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  widget.onConfirmarCentro(construirMatriz());
                },
                child: const Text(
                  'Aplicar al centro',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  widget.onConfirmarPunto(construirMatriz());
                },
                child: const Text(
                  'Aplicar al punto',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fila(TextEditingController ctrl1, TextEditingController ctrl2) {
    return Row(
      children: [
        Expanded(child: _campo(ctrl1)),
        const SizedBox(width: 8),
        Expanded(child: _campo(ctrl2)),
      ],
    );
  }

  Widget _campo(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(isDense: true),
    );
  }

  Matriz2x2 construirMatriz() {
    final a = double.tryParse(aCtrl.text) ?? 0;
    final b = double.tryParse(bCtrl.text) ?? 0;
    final c = double.tryParse(cCtrl.text) ?? 0;
    final d = double.tryParse(dCtrl.text) ?? 0;

    return Matriz2x2(a, b, c, d);
  }
}
