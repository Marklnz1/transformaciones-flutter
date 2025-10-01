import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/proveedores/proveedor_canvas.dart';
import 'package:transformaciones_app/proveedores/proveedor_sistema_coordenado.dart';
import 'package:transformaciones_app/widgets/editor_matriz2x2.dart';
import 'package:transformaciones_app/widgets/etiqueta_arrastrable.dart';
import 'package:transformaciones_app/widgets/vector_input.dart';

class ContenidoOrigenTransformacional extends StatefulWidget {
  const ContenidoOrigenTransformacional({super.key});

  @override
  State<ContenidoOrigenTransformacional> createState() =>
      _ContenidoOrigenTransformacionalState();
}

class _ContenidoOrigenTransformacionalState
    extends State<ContenidoOrigenTransformacional> {
  @override
  Widget build(BuildContext context) {
    final provSistema = context.watch<ProveedorSistemaTransformado>();
    final provCanvas = context.watch<ProveedorCanvas>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Figura',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text(
                  'Rellenar figura',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                value: provSistema.rellenarFigura,
                onChanged: (value) {
                  provSistema.setRellenarFigura(value);
                },
                activeThumbColor: Colors.cyanAccent,
              ),
            ),
            Expanded(
              child: SwitchListTile(
                contentPadding: EdgeInsets.all(0),
                title: const Text(
                  'Mostrar Homotecia',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                value: provSistema.mostrarHomotecia,
                onChanged: (value) {
                  provSistema.setMostrarHomotecia(value);
                },
                activeThumbColor: Colors.cyanAccent,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: provSistema.borrarFigura,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Borrar figura',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),

        Text(
          'Configuración de Punto y linea',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        GestureDetector(
          onPanUpdate: (d) {
            provSistema.moverReferencia(d.delta / provCanvas.escala);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.move,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
              ),
              child: Text(
                'Arrastrar Punto (${provSistema.figura.referencia.dx.toInt()},${provSistema.figura.referencia.dy.toInt()})',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

        VectorInput(
          factorArrastre: 0.5,
          controller: provSistema.control.ctrlRotacionReferencia,
          texto: 'Angulo linea',
        ),

        Text(
          'Homotecia',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: VectorInput(
                factorArrastre: 0.005,
                controller: provSistema.control.ctrlRazon,
                texto: 'Razon',
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  provSistema.aplicarHomotecia();
                },
                child: const Text(
                  'Aplicar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),

        Text(
          'Rotar Figura Respecto al',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          spacing: 8,
          children: [
            Expanded(
              child: EtiquetaArrastrable(
                texto: 'Punto (°)',
                alArrastrar: (delta) {
                  provSistema.rotarRespectoPunto(delta * 1);
                },
              ),
            ),

            Expanded(
              child: EtiquetaArrastrable(
                texto: 'Centro (°)',
                alArrastrar: (delta) {
                  provSistema.rotarRespectoCentro(delta * 1);
                },
              ),
            ),
          ],
        ),

        Text(
          'Reflejar Figura',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          spacing: 6,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  provSistema.reflejarRespectoAngulo(
                    provSistema.control.radianes,
                  );
                },
                child: const Text(
                  'En linea',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: provSistema.reflejarRespectoEjeX,
                child: const Text(
                  'En X',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: provSistema.reflejarRespectoEjeY,
                child: const Text(
                  'En Y',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        Text(
          'Transformación personalizada',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        EditorMatriz2x2(
          onConfirmarCentro: (matriz) {
            provSistema.aplicarTransformacion(matriz);
          },
          onConfirmarPunto: (matriz) {
            provSistema.aplicarTransformacionRespecto(matriz);
          },
        ),
      ],
    );
  }
}
