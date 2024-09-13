import 'package:flutter/material.dart';
import 'home_screen.dart';

class NoDesarrolladScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Desarrollado'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rueda giratoria
            CircularProgressIndicator(),
            SizedBox(height: 20),
            // Texto de disculpa
            Text(
              'Perdón por las molestias',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            // Botón para volver a la pantalla Home
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Volver a la pantalla Home
              },
              child: Text('Volver a Inicio'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
