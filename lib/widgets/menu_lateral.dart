import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/proveedores/proveedor.dart';
import 'package:transformaciones_app/widgets/etiqueta_arrastrable.dart';
import 'package:transformaciones_app/widgets/vector_input.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<Proveedor>();
    final c = p.sistemaCoordenado;

    return Container(
      width: 400,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF1E1E1E),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: p.borrarFigura,
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Borrar figura',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Vectores base',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: VectorInput(controller: c.ctrlEjeUi, texto: 'Uᵢ'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: VectorInput(controller: c.ctrlEjeUj, texto: 'Uⱼ'),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: VectorInput(controller: c.ctrlEjeVi, texto: 'Vᵢ'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: VectorInput(controller: c.ctrlEjeVj, texto: 'Vⱼ'),
              ),
            ],
          ),
          GestureDetector(
            onPanUpdate: (d) => p.moverCentro(d.delta),
            child: MouseRegion(
              cursor: SystemMouseCursors.move,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  'Arrastrar eje (${c.centroEnPantalla.dx.toInt()},${c.centroEnPantalla.dy.toInt()})',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: p.reiniciarBase,
            child: const Text(
              'Restablecer base',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Reflejar',
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: p.reflejarEnU,
                  child: const Text('X', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: p.reflejarEnV,
                  child: const Text('Y', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Rotación',
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          EtiquetaArrastrable(texto: 'Base (°)', alArrastrar: p.rotarBase),
          EtiquetaArrastrable(
            texto: 'Canónico (°)',
            alArrastrar: p.rotarPantalla,
          ),
        ],
      ),
    );
  }
}
