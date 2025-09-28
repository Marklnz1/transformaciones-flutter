import 'dart:async';
import 'package:flutter/material.dart';

class EtiquetaArrastrable extends StatefulWidget {
  final String texto;
  final void Function(int direccion) alArrastrar;
  final bool invertirDireccion;

  const EtiquetaArrastrable({
    super.key,
    required this.texto,
    required this.alArrastrar,
    this.invertirDireccion = false,
  });

  @override
  State<EtiquetaArrastrable> createState() => _EtiquetaArrastrableState();
}

class _EtiquetaArrastrableState extends State<EtiquetaArrastrable> {
  int direccionActual = 0;
  Timer? _temporizador;

  void iniciarArrastre(int nuevaDireccion) {
    // Si cambia la dirección, actualízala
    if (direccionActual != nuevaDireccion) {
      setState(() {
        direccionActual = nuevaDireccion;
      });
    }

    // Si el temporizador no está activo, lo iniciamos
    _temporizador ??= Timer.periodic(const Duration(milliseconds: 10), (_) {
      final direccionFinal = widget.invertirDireccion
          ? -direccionActual
          : direccionActual;
      widget.alArrastrar(direccionFinal);
    });
  }

  void detenerArrastre() {
    _temporizador?.cancel();
    _temporizador = null;
    setState(() {
      direccionActual = 0;
    });
  }

  @override
  void dispose() {
    detenerArrastre();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool haciaDerecha = direccionActual > 0;

    return GestureDetector(
      onHorizontalDragUpdate: (detalles) {
        final nuevaDireccion = detalles.delta.dx > 0 ? 1 : -1;
        iniciarArrastre(nuevaDireccion);
      },
      onHorizontalDragEnd: (_) => detenerArrastre(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            const Icon(Icons.swap_horiz, size: 20, color: Colors.cyanAccent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.texto,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            direccionActual == 0
                ? const Text(
                    'Arrastra para rotar',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Transform.flip(
                    flipX: !haciaDerecha,
                    child: const Icon(
                      Icons.forward,
                      color: Colors.cyanAccent,
                      size: 24,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
