import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Rol',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PaginaJuego(),
    );
  }
}

class PaginaJuego extends StatefulWidget {
  @override
  _PaginaJuegoEstado createState() => _PaginaJuegoEstado();
}

class _PaginaJuegoEstado extends State<PaginaJuego> {
  // Puntos de vida iniciales
  int vidaHeroe = 100;
  int vidaMonstruo = 100;

  // Mensaje principal mostrado en la parte superior (fondo negro)
  String mensaje = '¡Empieza la batalla!';

  // Valores de ataque (0..20)
  double ataqueHeroe = 10.0;
  double ataqueMonstruo = 10.0;

  // Valores de defensa (0..20)
  double defensaHeroe = 5.0;
  double defensaMonstruo = 5.0;

  // Ataca el Héroe
  void ataca_heroe() {
    // Convertimos a int con round()
    int atk = ataqueHeroe.round();
    int defMonstruo = defensaMonstruo.round();

    // Cálculo del daño = ataque - defensa del oponente
    int danio = atk - defMonstruo;
    // Si da negativo, lo ajustamos a 0
    if (danio < 0) danio = 0;

    setState(() {
      vidaMonstruo -= danio;
      mensaje = 'El Héroe ataca con $atk de ATK '
          'contra $defMonstruo de DEF.\n';
      mensaje += 'Daño infligido: $danio.\n';

      if (vidaMonstruo <= 0) {
        vidaMonstruo = 0;
        mensaje += '¡El monstruo ha sido derrotado!';
      }
    });
  }

  // Ataca el Monstruo
  void ataca_monstruo() {
    int atk = ataqueMonstruo.round();
    int defHeroe = defensaHeroe.round();

    int danio = atk - defHeroe;
    if (danio < 0) danio = 0;

    setState(() {
      vidaHeroe -= danio;
      mensaje = 'El Monstruo ataca con $atk de ATK '
          'contra $defHeroe de DEF.\n';
      mensaje += 'Daño infligido: $danio.\n';

      if (vidaHeroe <= 0) {
        vidaHeroe = 0;
        mensaje += '¡El Héroe ha muerto!';
      }
    });
  }

  // Reinicia el juego
  void reiniciarJuego() {
    setState(() {
      vidaHeroe = 100;
      vidaMonstruo = 100;
      mensaje = '¡Empieza la batalla!';

      // Ajustamos, si queremos, valores por defecto de ataque y defensa
      ataqueHeroe = 10.0;
      ataqueMonstruo = 10.0;
      defensaHeroe = 5.0;
      defensaMonstruo = 5.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Rol Sencillo'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- PARTE SUPERIOR: Mensaje y Barras/Sliders ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Contenedor con fondo negro y texto gótico en blanco
                  Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      mensaje,
                      style: GoogleFonts.medievalSharp(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),

                  // --- Fila con las barras de vida y sliders ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // BLOQUE HÉROE
                      Column(
                        children: [
                          Text(
                            'Héroe',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Barra de vida
                          Container(
                            width: 200,
                            height: 25,
                            child: LinearProgressIndicator(
                              value: vidaHeroe / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('$vidaHeroe / 100'),

                          // -- SLIDERS del HÉROE: Ataque y Defensa --
                          SizedBox(height: 10),
                          Text('Ataque Héroe: ${ataqueHeroe.round()}'),
                          Slider(
                            value: ataqueHeroe,
                            min: 0,
                            max: 20,
                            divisions: 20,
                            label: ataqueHeroe.round().toString(),
                            onChanged: (valor) {
                              setState(() {
                                ataqueHeroe = valor;
                              });
                            },
                          ),
                          Text('Defensa Héroe: ${defensaHeroe.round()}'),
                          Slider(
                            value: defensaHeroe,
                            min: 0,
                            max: 20,
                            divisions: 20,
                            label: defensaHeroe.round().toString(),
                            onChanged: (valor) {
                              setState(() {
                                defensaHeroe = valor;
                              });
                            },
                          ),
                        ],
                      ),

                      // BLOQUE MONSTRUO
                      Column(
                        children: [
                          Text(
                            'Monstruo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Barra de vida
                          Container(
                            width: 200,
                            height: 25,
                            child: LinearProgressIndicator(
                              value: vidaMonstruo / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('$vidaMonstruo / 100'),

                          // -- SLIDERS del MONSTRUO: Ataque y Defensa --
                          SizedBox(height: 10),
                          Text('Ataque Monstruo: ${ataqueMonstruo.round()}'),
                          Slider(
                            value: ataqueMonstruo,
                            min: 0,
                            max: 20,
                            divisions: 20,
                            label: ataqueMonstruo.round().toString(),
                            onChanged: (valor) {
                              setState(() {
                                ataqueMonstruo = valor;
                              });
                            },
                          ),
                          Text('Defensa Monstruo: ${defensaMonstruo.round()}'),
                          Slider(
                            value: defensaMonstruo,
                            min: 0,
                            max: 20,
                            divisions: 20,
                            label: defensaMonstruo.round().toString(),
                            onChanged: (valor) {
                              setState(() {
                                defensaMonstruo = valor;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- PARTE CENTRAL: Imágenes del Héroe y Monstruo ---
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pulsar sobre la imagen del Héroe => ataca el Héroe
                  GestureDetector(
                    onTap: (vidaHeroe > 0 && vidaMonstruo > 0)
                        ? ataca_heroe
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/heroe.jpg',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  // Pulsar sobre la imagen del Monstruo => ataca el Monstruo
                  GestureDetector(
                    onTap: (vidaHeroe > 0 && vidaMonstruo > 0)
                        ? ataca_monstruo
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent, width: 2),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/monstruo.jpg',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- PARTE INFERIOR: Botón de Reiniciar ---
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: reiniciarJuego,
                child: Text('Reiniciar Juego'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
