import 'package:flutter/material.dart';

class TabSimple extends StatefulWidget {
  final Widget vistaPrimaria;
  final Widget vistaSecundaria;

  const TabSimple({
    super.key,
    required this.vistaPrimaria,
    required this.vistaSecundaria,
  });

  @override
  State<TabSimple> createState() => _TabSimpleState();
}

class _TabSimpleState extends State<TabSimple> {
  int activo = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border(bottom: BorderSide(color: Colors.white24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              _botonTab('Transformar', Icons.grid_view, 0),
              const SizedBox(width: 6),
              _botonTab('Puntos', Icons.transform, 1),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white24),
            ),
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: activo == 0
                  ? widget.vistaPrimaria
                  : widget.vistaSecundaria,
            ),
          ),
        ),
      ],
    );
  }

  Widget _botonTab(String texto, IconData icono, int index) {
    final seleccionado = activo == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activo = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            color: seleccionado ? Colors.cyanAccent : const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white24),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icono,
                size: 14,
                color: seleccionado ? Colors.black : Colors.white54,
              ),
              const SizedBox(width: 4),
              Text(
                texto,
                style: TextStyle(
                  color: seleccionado ? Colors.black : Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
