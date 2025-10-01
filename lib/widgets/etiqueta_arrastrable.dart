import 'package:flutter/material.dart';

class EtiquetaArrastrable extends StatelessWidget {
  final String texto;
  final void Function(int delta) alArrastrar;
  final bool invertirDireccion;

  const EtiquetaArrastrable({
    super.key,
    required this.texto,
    required this.alArrastrar,
    this.invertirDireccion = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (d) =>
          alArrastrar((d.delta.dx > 0 ? 1 : -1) * (invertirDireccion ? -1 : 1)),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              const Icon(Icons.swap_horiz, size: 20, color: Colors.cyanAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  texto,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const Text(
                'Arrastra',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
