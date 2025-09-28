import 'package:flutter/material.dart';

class Graficos extends StatefulWidget {
  final void Function(Offset pos)? onClick;
  final void Function(Canvas canvas, Size size) dibujar;
  final double escala;
  const Graficos({
    super.key,
    this.onClick,
    required this.dibujar,
    required this.escala,
  });

  @override
  GraficosState createState() => GraficosState();
}

class GraficosState extends State<Graficos> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desplazamientoCentral =
            Offset(constraints.maxWidth, constraints.maxHeight) / 2;

        return Listener(
          onPointerUp: (event) {
            widget.onClick?.call(event.localPosition - desplazamientoCentral);
          },
          onPointerMove: (event) {
            widget.onClick?.call(event.localPosition - desplazamientoCentral);
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: Pintor(widget.dibujar),
          ),
        );
      },
    );
  }
}

class Pintor extends CustomPainter {
  final void Function(Canvas canvas, Size size) dibujar;
  Pintor(this.dibujar);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    dibujar(canvas, size);
  }

  @override
  bool shouldRepaint(covariant Pintor old) {
    return true;
  }
}
