import 'package:flutter/material.dart';

class MostrarPuntos extends StatelessWidget {
  final List<Offset> puntosOriginales;
  final List<Offset> puntosTransformados;

  const MostrarPuntos({
    super.key,
    required this.puntosOriginales,
    required this.puntosTransformados,
  });

  @override
  Widget build(BuildContext context) {
    if (puntosOriginales.isEmpty || puntosTransformados.isEmpty) {
      return const Center(
        child: Text(
          'No hay puntos',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    final pares = List.generate(
      puntosOriginales.length,
      (i) => (puntosOriginales[i], puntosTransformados[i]),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Puntos Transformados',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...pares.map((par) => _filaPunto(par.$1, par.$2)).toList(),
      ],
    );
  }

  Widget _filaPunto(Offset original, Offset transformado) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          _puntoTexto('Original', original),
          const Spacer(),
          _puntoTexto('Transformado', transformado),
        ],
      ),
    );
  }

  Widget _puntoTexto(String etiqueta, Offset punto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
        Text(
          '(${punto.dx.toStringAsFixed(2)}, ${punto.dy.toStringAsFixed(2)})',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
