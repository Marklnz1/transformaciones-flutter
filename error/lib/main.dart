import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/widgets/graficos.dart';
import 'package:transformaciones_app/providers/grid_provider.dart';
import 'package:transformaciones_app/widgets/side_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color accentColor = Colors.cyanAccent;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GridProvider(),
      child: MaterialApp(
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
              // Canvas principal
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Consumer<GridProvider>(
                        builder: (context, prov, _) {
                          return Graficos(
                            escala: prov.sistemaCoordenado.escala,
                            onClick: (posClick) {
                              prov.agregarPuntoCoordenadasScreen(posClick);
                            },
                            dibujar: (canvas, size) {
                              // Centro y escala
                              // canvas.translate(
                              //   prov.sistemaCoordenado.centroEnPantalla.dx,
                              //   prov.sistemaCoordenado.centroEnPantalla.dy,
                              // );
                              canvas.scale(prov.sistemaCoordenado.escala);
                              prov.sistemaCoordenado.dibujar(
                                canvas,
                                size,
                                prov.sistemaCoordenado.escala,
                              );
                              // // Grid canónico y transformado
                              // DibujarGrid(
                              //   columns: 200,
                              //   rows: 200,
                              //   gridColor: Colors.white.withValues(alpha: 0.2),
                              //   strokeWidth: 0.5,
                              //   vectorX: const Offset(0.5, 0),
                              //   vectorY: const Offset(0, 0.5),
                              // ).dibujar(canvas, size, prov.escala);

                              // DibujarGrid(
                              //   columns: 100,
                              //   rows: 100,
                              //   gridColor: Colors.white.withOpacity(0.3),
                              //   strokeWidth: 0.7,
                              //   vectorX: const Offset(1, 0),
                              //   vectorY: const Offset(0, 1),
                              // ).dibujar(canvas, size, prov.escala);

                              // // Ejes transformados
                              // DibujarGrid(
                              //   columns: 100,
                              //   rows: 100,
                              //   gridColor: const Color(0xFF488FA5),
                              //   strokeWidth: 2,
                              //   vectorX: prov.ejeU,
                              //   vectorY: prov.ejeV,
                              // ).dibujar(canvas, size, prov.escala);

                              // // Ejes X/Y centrales

                              // // Figura con puntos
                              // DibujarFigura(
                              //   vectorBaseX: prov.ejeU,
                              //   vectorBaseY: prov.ejeV,
                              //   vectores: prov.puntos,
                              // ).dibujar(canvas, size, prov.escala);

                              // // Punto central
                              // DibujarPunto(
                              //   punto: prov.puntoCentral,
                              //   vectorBaseX: const Offset(1, 0),
                              //   vectorBaseY: const Offset(0, 1),
                              // ).dibujar(canvas, size, prov.escala);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              // SideMenu estilizado
              const MenuLateral(),
            ],
          ),
        ),
      ),
    );
  }
}
