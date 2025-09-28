// widgets/vector_input.dart

import 'package:flutter/material.dart';

class VectorInput extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final double dragFactor;
  final void Function()? onDrag;
  final bool arrastreCambiaValor;

  const VectorInput({
    super.key,
    required this.controller,
    this.label,
    this.dragFactor = 0.025,
    this.onDrag,
    this.arrastreCambiaValor = true,
  });

  @override
  State<VectorInput> createState() => _VectorInputState();
}

class _VectorInputState extends State<VectorInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.label != null)
          MouseRegion(
            cursor: SystemMouseCursors.resizeLeftRight,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (widget.arrastreCambiaValor) {
                  final delta = details.delta.dx * widget.dragFactor;
                  double value = double.tryParse(widget.controller.text) ?? 0;
                  value += delta;
                  widget.controller.text = value.toStringAsFixed(2);
                }
                widget.onDrag?.call();
              },
              child: Tooltip(
                message: 'Arrastrar para cambiar valor',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swap_horiz, size: 16, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text(
                      widget.label!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: widget.controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(isDense: true),
          ),
        ),
      ],
    );
  }
}
