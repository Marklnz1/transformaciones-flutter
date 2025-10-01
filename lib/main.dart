import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/pintores/renderizador_sistema.dart';
import 'package:transformaciones_app/proveedores/proveedor_canvas.dart';
import 'package:transformaciones_app/widgets/contenido_origen_transformacional.dart';
import 'package:transformaciones_app/widgets/graficos.dart';
import 'package:transformaciones_app/proveedores/proveedor_sistema_coordenado.dart';
import 'package:transformaciones_app/widgets/mostrar_puntos.dart';
import 'package:transformaciones_app/widgets/tab_simple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color accentColor = Colors.cyanAccent;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProveedorCanvas()),
        ChangeNotifierProvider(create: (_) => ProveedorSistemaTransformado()),
      ],
      builder: (context, child) {
        final provSistema = context.watch<ProveedorSistemaTransformado>();
        final provCanvas = context.watch<ProveedorCanvas>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: ColorScheme.dark(
              primary: accentColor,
              secondary: accentColor,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              fillColor: Color(0xFF2B2B2B),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Graficos(
                          escala: provCanvas.escala,
                          onClick: (posClick) {
                            var posicionCanvas = provCanvas
                                .traducirPosicionPantallaACanvas(posClick);

                            provSistema.agregarPunto(posicionCanvas);
                          },
                          dibujarConTransformacion: (canvas, size, escala) {
                            final renderizador = RenderizadorSistema(
                              provSistema.figura,
                              provSistema.control,
                            );

                            renderizador.mostrarHomotecia =
                                provSistema.mostrarHomotecia;
                            renderizador.rellenar = provSistema.rellenarFigura;

                            renderizador.dibujar(canvas, size, escala);
                          },
                          dibujarSinTransformacion: (canvas, size) {},
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFF1E1E1E),
                  child: TabSimple(
                    vistaPrimaria: ContenidoOrigenTransformacional(),
                    vistaSecundaria: MostrarPuntos(
                      puntosOriginales: provSistema.figura.originales,
                      puntosTransformados: provSistema.figura.transformados,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
