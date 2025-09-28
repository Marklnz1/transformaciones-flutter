// widgets/vector_input.dart

import 'package:flutter/material.dart';

class VectorInput extends StatelessWidget {
  final String? texto;
  final TextEditingController controller;
  final double factorArrastre;
  final void Function()? onDrag;
  final bool arrastreCambiaValor;

  const VectorInput({
    super.key,
    required this.controller,
    this.texto,
    this.factorArrastre = 0.025,
    this.onDrag,
    this.arrastreCambiaValor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (texto != null)
          GestureDetector(
            onHorizontalDragUpdate: (d) {
              if (arrastreCambiaValor) {
                final delta = d.delta.dx * factorArrastre;
                final v = double.tryParse(controller.text) ?? 0;
                controller.text = (v + delta).toStringAsFixed(2);
              }
              onDrag?.call();
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.swap_horiz, size: 16, color: Colors.white54),
                  const SizedBox(width: 4),
                  Text(texto!, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(isDense: true),
          ),
        ),
      ],
    );
  }
}
