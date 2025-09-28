import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/providers/grid_provider.dart';
import 'package:transformaciones_app/widgets/drag_label.dart';
import 'package:transformaciones_app/widgets/vector_input.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({super.key});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext contexto) {
    final proveedor = contexto.watch<GridProvider>();
    final sistemaCoordenado = proveedor.sistemaCoordenado;
    // print(sistemaCoordenado.centroEnPantalla);
    return Container(
      width: 400,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF1E1E1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: proveedor.borrarFigura,
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Borrar figura',
              style: TextStyle(color: Colors.black),
            ),
          ),
          construirSeccion(
            titulo: 'Vectores base',
            contenido: [
              ParDeVectores(
                etiquetaX: 'Uᵢ:',
                controladorX: sistemaCoordenado.ctrlEjeUi,
                etiquetaY: 'Uⱼ:',
                controladorY: sistemaCoordenado.ctrlEjeUj,
              ),
              ParDeVectores(
                etiquetaX: 'Vᵢ:',
                controladorX: sistemaCoordenado.ctrlEjeVi,
                etiquetaY: 'Vⱼ:',
                controladorY: sistemaCoordenado.ctrlEjeVj,
              ),
              GestureDetector(
                onPanUpdate: (detalles) =>
                    proveedor.moverCentro(detalles.delta),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2B2B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Mover eje (${sistemaCoordenado.centro.dx.toInt()},${sistemaCoordenado.centro.dy.toInt()})',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: proveedor.reiniciarBase,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Restablecer base',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          construirSeccion(
            titulo: 'Reflejar',
            contenido: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        proveedor.reflejarEnU();
                      },
                      icon: const Icon(Icons.flip),
                      label: const Text(
                        'Reflejar X',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        proveedor.reflejarEnV();
                      },
                      icon: const Icon(Icons.flip),
                      label: const Text(
                        'Reflejar Y',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          construirSeccion(
            titulo: "Rotación",
            contenido: [
              EtiquetaArrastrable(
                texto: 'Base (°)',
                alArrastrar: proveedor.rotarBase,
              ),
              EtiquetaArrastrable(
                texto: 'Canónico (°)',
                alArrastrar: proveedor.rotarPantalla,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget construirSeccion({
  required String titulo,
  required List<Widget> contenido,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...contenido,
      ],
    ),
  );
}

class ParDeVectores extends StatelessWidget {
  final String etiquetaX;
  final TextEditingController controladorX;
  final String etiquetaY;
  final TextEditingController controladorY;

  const ParDeVectores({
    super.key,
    required this.etiquetaX,
    required this.controladorX,
    required this.etiquetaY,
    required this.controladorY,
  });

  @override
  Widget build(BuildContext contexto) {
    return Row(
      children: [
        Expanded(
          child: VectorInput(controller: controladorX, label: etiquetaX),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: VectorInput(controller: controladorY, label: etiquetaY),
        ),
      ],
    );
  }
}
