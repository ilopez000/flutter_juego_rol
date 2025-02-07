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
  // Puntos de vida iniciales.
  int vidaHeroe = 100;
  int vidaMonstruo = 100;

  // Mensaje que se muestra en el recuadro negro.
  String mensaje = '¡Empieza la batalla!';

  // Valor de ataque elegido para cada personaje (0..20).
  double ataqueHeroe = 10.0;
  double ataqueMonstruo = 10.0;

  // Elimina lógica aleatoria; ahora el ataque depende del slider.
  // --------------------------------------------------------------------------------
  // Ataca el Héroe (usa ataqueHeroe).
  void ataca_heroe() {
    // Convertimos el valor double del slider a int con round().
    int danio = ataqueHeroe.round();
    setState(() {
      vidaMonstruo -= danio;
      mensaje = 'El Héroe ataca con $danio de daño.\n';

      if (vidaMonstruo <= 0) {
        vidaMonstruo = 0;
        mensaje += '¡El monstruo ha sido derrotado!';
      }
    });
  }

  // Ataca el Monstruo (usa ataqueMonstruo).
  void ataca_monstruo() {
    int danio = ataqueMonstruo.round();
    setState(() {
      vidaHeroe -= danio;
      mensaje = 'El Monstruo ataca con $danio de daño.\n';

      if (vidaHeroe <= 0) {
        vidaHeroe = 0;
        mensaje += '¡El Héroe ha muerto!';
      }
    });
  }
  // --------------------------------------------------------------------------------

  // Reinicia el juego a los valores iniciales
  void reiniciarJuego() {
    setState(() {
      vidaHeroe = 100;
      vidaMonstruo = 100;
      mensaje = '¡Empieza la batalla!';
      // Opcionalmente podemos reconfigurar los sliders a 10 (o 0).
      ataqueHeroe = 10.0;
      ataqueMonstruo = 10.0;
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
            // --- PARTE SUPERIOR: Mensaje y Barras de vida ---
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

                  // Fila con las barras de vida
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // BARRA DE VIDA DEL HÉROE
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

                          // --- Slider de ataque del Héroe ---
                          SizedBox(height: 10),
                          Text('Ataque Héroe: ${ataqueHeroe.round()}'),
                          Slider(
                            value: ataqueHeroe,
                            min: 0,
                            max: 20,
                            divisions: 20, // Para que el "salto" sea entero
                            label: ataqueHeroe.round().toString(),
                            onChanged: (valor) {
                              setState(() {
                                ataqueHeroe = valor;
                              });
                            },
                          ),
                        ],
                      ),

                      // BARRA DE VIDA DEL MONSTRUO
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

                          // --- Slider de ataque del Monstruo ---
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
                  // Al hacer TAP en el Héroe, aplicamos ataca_heroe()
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

                  // Al hacer TAP en el Monstruo, aplicamos ataca_monstruo()
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
