import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/proveedores/proveedor_canvas.dart';

class Graficos extends StatefulWidget {
  final void Function(Offset pos)? onClick;
  final void Function(Canvas canvas, Size size, double escala)
  dibujarConTransformacion;
  final void Function(Canvas canvas, Size size) dibujarSinTransformacion;
  final double escala;
  const Graficos({
    super.key,
    this.onClick,
    required this.dibujarConTransformacion,
    required this.dibujarSinTransformacion,
    required this.escala,
  });

  @override
  GraficosState createState() => GraficosState();
}

class GraficosState extends State<Graficos> {
  @override
  Widget build(BuildContext context) {
    final provCanvas = context.watch<ProveedorCanvas>();
    return LayoutBuilder(
      builder: (context, constraints) {
        final desplazamientoCentral =
            Offset(constraints.maxWidth, constraints.maxHeight) / 2;

        return Listener(
          onPointerUp: (event) {
            widget.onClick?.call(event.localPosition - desplazamientoCentral);
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: Pintor(
              escala: provCanvas.escala,
              centro: provCanvas.centro,
              dibujarConTransformacion: widget.dibujarConTransformacion,
              dibujarSinTransformacion: widget.dibujarSinTransformacion,
            ),
          ),
        );
      },
    );
  }
}

class Pintor extends CustomPainter {
  final Offset centro;
  final double escala;
  final void Function(Canvas canvas, Size size, double escala)
  dibujarConTransformacion;
  final void Function(Canvas canvas, Size size) dibujarSinTransformacion;
  Pintor({
    required this.escala,
    required this.centro,
    required this.dibujarConTransformacion,
    required this.dibujarSinTransformacion,
  });
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(centro.dx, centro.dy);
    canvas.scale(escala);
    dibujarConTransformacion(canvas, size, escala);
    canvas.restore();
    dibujarSinTransformacion(canvas, size);
  }

  @override
  bool shouldRepaint(covariant Pintor old) {
    return true;
  }
}
