import 'dart:math';
import 'package:flutter/material.dart';

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
  int vidaHeroe = 100;
  int vidaMonstruo = 100;

  String mensaje = '¡Empieza la batalla!';

  final Random generadorAleatorio = Random();

  void atacar() {
    int danioHeroe = generadorAleatorio.nextInt(20) + 5;
    int danioMonstruo = generadorAleatorio.nextInt(15) + 3;

    setState(() {
      vidaMonstruo -= danioHeroe;
      mensaje = 'Atacaste al monstruo causándole $danioHeroe de daño.\n';

      if (vidaMonstruo > 0) {
        vidaHeroe -= danioMonstruo;
        mensaje += 'El monstruo te contraataca causando $danioMonstruo de daño.';
      } else {
        mensaje += ' ¡El monstruo ha sido derrotado!';
        vidaMonstruo = 0;
      }

      if (vidaHeroe <= 0) {
        vidaHeroe = 0;
        mensaje = 'Has sido derrotado. Fin del juego.';
      }
    });
  }

  void ataca_heroe() {
    int danioHeroe = generadorAleatorio.nextInt(20) + 5;
    setState(() {
      vidaMonstruo -= danioHeroe;
      mensaje = 'Atacaste al monstruo causándole $danioHeroe de daño.\n';

      if (vidaMonstruo <= 0) {
        vidaMonstruo = 0;
        mensaje += '¡El monstruo ha sido derrotado!';
      }
    });
  }

  void ataca_monstruo() {
    int danioMonstruo = generadorAleatorio.nextInt(15) + 3;
    setState(() {
      vidaHeroe -= danioMonstruo;
      mensaje = 'El monstruo atacó al Héroe causándole $danioMonstruo de daño.\n';

      if (vidaHeroe <= 0) {
        vidaHeroe = 0;
        mensaje += '¡El Héroe ha muerto!';
      }
    });
  }

  void reiniciarJuego() {
    setState(() {
      vidaHeroe = 100;
      vidaMonstruo = 100;
      mensaje = '¡Empieza la batalla!';
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
                  // Mensaje de la batalla
                  Text(
                    mensaje,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 200,
                            height: 25,
                            child: LinearProgressIndicator(
                              // Vida en porcentaje (0.0 a 1.0)
                              value: vidaHeroe / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('$vidaHeroe / 100'),
                        ],
                      ),

                      // BARRA DE VIDA DEL MONSTRUO
                      Column(
                        children: [
                          Text(
                            'Monstruo',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 200,
                            height: 25,
                            child: LinearProgressIndicator(
                              value: vidaMonstruo / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('$vidaMonstruo / 100'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- PARTE CENTRAL: Héroe y Monstruo ---
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
