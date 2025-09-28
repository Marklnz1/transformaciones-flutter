import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformaciones_app/widgets/graficos.dart';
import 'package:transformaciones_app/proveedores/proveedor.dart';
import 'package:transformaciones_app/widgets/menu_lateral.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color accentColor = Colors.cyanAccent;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Proveedor(),
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
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Consumer<Proveedor>(
                        builder: (context, prov, _) {
                          return Graficos(
                            escala: prov.sistemaCoordenado.escala,
                            onClick: (posClick) {
                              prov.agregarPuntoCoordenadasScreen(posClick);
                            },
                            dibujar: (canvas, size) {
                              canvas.scale(prov.sistemaCoordenado.escala);
                              prov.sistemaCoordenado.dibujar(
                                canvas,
                                size,
                                prov.sistemaCoordenado.escala,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const MenuLateral(),
            ],
          ),
        ),
      ),
    );
  }
}
