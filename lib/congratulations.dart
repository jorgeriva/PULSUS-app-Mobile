import 'package:flutter/material.dart';
import 'mostrardatos1.dart'; // Importa la pantalla que mencionaste
import 'contactlist_screen.dart';

class CongratulationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mensaje de enhorabuena
              Text(
                '¡Enhorabuena!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Te has registrado con éxito.',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0),

              // Botón para ir a la pantalla Mostrardatos1
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactListScreen(tenantId:'2'), // cambiar a futuro
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  //primary: Colors.teal, // Color del botón
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                ),
                child: Text(
                  'CONTINUAR',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
