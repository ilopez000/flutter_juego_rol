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

  // Función que se ejecuta al pulsar el botón "Atacar".
  void atacar() {
    // Se genera un daño aleatorio para el ataque del héroe (entre 5 y 24).
    int danioHeroe = generadorAleatorio.nextInt(20) + 5;
    // Se genera un daño aleatorio para el contraataque del monstruo (entre 3 y 17).
    int danioMonstruo = generadorAleatorio.nextInt(15) + 3;

    // Actualizamos el estado de la aplicación.
    setState(() {
      // El héroe ataca al monstruo, reduciendo sus puntos de vida.
      vidaMonstruo -= danioHeroe;
      // Actualizamos el mensaje para reflejar el ataque del héroe.
      mensaje = 'Atacaste al monstruo causándole $danioHeroe de danio.\n';

      // Si el monstruo sigue con vida, realiza un contraataque.
      if (vidaMonstruo > 0) {
        vidaHeroe -= danioMonstruo;
        mensaje += 'El monstruo te contraataca causando $danioMonstruo de danio.';
      } else {
        // Si el monstruo es derrotado, ajustamos sus puntos de vida y actualizamos el mensaje.
        mensaje += ' ¡El monstruo ha sido derrotado!';
        vidaMonstruo = 0;
      }

      // Verificamos si el héroe ha sido derrotado.
      if (vidaHeroe <= 0) {
        vidaHeroe = 0;  // Nos aseguramos de que la vida no sea negativa.
        mensaje = 'Has sido derrotado. Fin del juego.';
      }
    });
  }

  //Ataca el Heroe
  void ataca_heroe(){
    // Se genera un daño aleatorio para el ataque del héroe (entre 5 y 24).
    int danioHeroe = generadorAleatorio.nextInt(20) + 5;
    // Actualizamos el estado de la aplicación.
    setState(() {
      // El héroe ataca al monstruo, reduciendo sus puntos de vida.
      vidaMonstruo -= danioHeroe;
      // Actualizamos el mensaje para reflejar el ataque del héroe.
      mensaje = 'Atacaste al monstruo causándole $danioHeroe de danio.\n';

      // Si el monstruo sigue con vida, realiza un contraataque.
      if (vidaMonstruo <= 0)  {
        // Si el monstruo es derrotado, ajustamos sus puntos de vida y actualizamos el mensaje.
        mensaje += ' ¡El monstruo ha sido derrotado!';
        vidaMonstruo = 0;
      }
    });
  }

  //Ataca el Monstruo
void ataca_monstruo(){
  // Se genera un daño aleatorio para el contraataque del monstruo (entre 3 y 17).
  int danioMonstruo = generadorAleatorio.nextInt(15) + 3;
  setState(() {
    // El héroe ataca al monstruo, reduciendo sus puntos de vida.
    vidaHeroe -= danioMonstruo;
    // Actualizamos el mensaje para reflejar el ataque del héroe.
    mensaje = 'Atacaste al Heroe causándole $danioMonstruo de danio.\n';

    // Si el monstruo sigue con vida, realiza un contraataque.
    if (vidaHeroe<= 0)  {
      // Si el monstruo es derrotado, ajustamos sus puntos de vida y actualizamos el mensaje.
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
              // Botón para atacar. Se deshabilita si alguno de los personajes ha sido derrotado.
              ElevatedButton(
                onPressed: (vidaHeroe > 0 && vidaMonstruo > 0) ? ataca_heroe : null,
                child: Text('Ataca Heroe'),
              ),
              SizedBox(height: 30), // Espacio entre widgets.
              // Botón para atacar. Se deshabilita si alguno de los personajes ha sido derrotado.
              ElevatedButton(
                onPressed: (vidaHeroe > 0 && vidaMonstruo > 0) ? ataca_monstruo : null,
                child: Text('Ataca Monstruo'),
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
