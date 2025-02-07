// Importamos la librería para generar números aleatorios.
import 'dart:math';
// Importamos el paquete principal de Flutter.
import 'package:flutter/material.dart';

void main() {
  // Punto de entrada de la aplicación.
  runApp(MiAplicacion());
}

// Widget raíz de la aplicación.
class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Rol', // Título de la aplicación.
      theme: ThemeData(primarySwatch: Colors.blue), // Definimos el tema.
      home: PaginaJuego(), // Página principal del juego.
    );
  }
}

// Página principal del juego, se utiliza un StatefulWidget para manejar los cambios de estado.
class PaginaJuego extends StatefulWidget {
  @override
  _PaginaJuegoEstado createState() => _PaginaJuegoEstado();
}

// Estado de la página del juego.
class _PaginaJuegoEstado extends State<PaginaJuego> {
  // Variables que representan los puntos de vida del héroe y del monstruo.
  int vidaHeroe = 100;
  int vidaMonstruo = 100;

  // Variable que almacena el mensaje que se muestra al usuario.
  String mensaje = '¡Empieza la batalla!';

  // Instancia para generar números aleatorios.
  final Random generadorAleatorio = Random();

  // Función que se ejecuta al pulsar el botón "Atacar" (versión antigua).
  // La dejamos aquí por si la necesitas como referencia,
  // pero ya no la usamos al tener botones separados.
  void atacar() {
    int danioHeroe = generadorAleatorio.nextInt(20) + 5;
    int danioMonstruo = generadorAleatorio.nextInt(15) + 3;

    setState(() {
      vidaMonstruo -= danioHeroe;
      mensaje = 'Atacaste al monstruo causándole $danioHeroe de danio.\n';

      if (vidaMonstruo > 0) {
        vidaHeroe -= danioMonstruo;
        mensaje += 'El monstruo te contraataca causando $danioMonstruo de danio.';
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

  //Ataca el Héroe (solo el héroe ataca).
  void ataca_heroe() {
    // Se genera un daño aleatorio para el ataque del héroe (entre 5 y 24).
    int danioHeroe = generadorAleatorio.nextInt(20) + 5;
    setState(() {
      vidaMonstruo -= danioHeroe;
      mensaje = 'Atacaste al monstruo causándole $danioHeroe de danio.\n';

      if (vidaMonstruo <= 0) {
        mensaje += ' ¡El monstruo ha sido derrotado!';
        vidaMonstruo = 0;
      }
    });
  }

  //Ataca el Monstruo (solo el monstruo ataca).
  void ataca_monstruo() {
    // Se genera un daño aleatorio para el ataque del monstruo (entre 3 y 17).
    int danioMonstruo = generadorAleatorio.nextInt(15) + 3;
    setState(() {
      vidaHeroe -= danioMonstruo;
      mensaje = 'El monstruo atacó al Héroe causándole $danioMonstruo de danio.\n';

      if (vidaHeroe <= 0) {
        mensaje += ' ¡El Héroe ha muerto!';
        vidaHeroe = 0;
      }
    });
  }

  // Función para reiniciar el juego y restablecer los estados iniciales.
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
      // Barra superior con el título de la aplicación.
      appBar: AppBar(
        title: Text('Juego de Rol Sencillo'),
      ),
      // Contenedor principal del contenido.
      body: Padding(
        padding: EdgeInsets.all(16.0), // Espaciado interno.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical de los widgets.
            children: [
              // Muestra los puntos de vida del héroe.
              Text(
                'HP del Héroe: $vidaHeroe',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10), // Espacio entre widgets.
              // Muestra los puntos de vida del monstruo.
              Text(
                'HP del Monstruo: $vidaMonstruo',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 30), // Espacio entre widgets.
              // Muestra el mensaje actual de la batalla.
              Text(
                mensaje,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30), // Espacio entre widgets.
              // Botón para que ataque el Héroe.
              ElevatedButton(
                onPressed: (vidaHeroe > 0 && vidaMonstruo > 0) ? ataca_heroe : null,
                style: ElevatedButton.styleFrom(
                  // Ajusta el estilo según tus preferencias.
                  padding: EdgeInsets.all(12.0),
                  // backgroundColor (Material 3) o primary (Material 2)
                  // Ejemplo: backgroundColor: Colors.green,
                ),
                child: Image.asset(
                  'assets/images/heroe.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 30), // Espacio entre widgets.
              // Botón para que ataque el Monstruo.
              ElevatedButton(
                onPressed: (vidaHeroe > 0 && vidaMonstruo > 0) ? ataca_monstruo : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12.0),
                ),
                child: Image.asset(
                  'assets/images/monstruo.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20), // Espacio entre widgets.
              // Botón para reiniciar el juego.
              ElevatedButton(
                onPressed: reiniciarJuego,
                child: Text('Reiniciar Juego'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
