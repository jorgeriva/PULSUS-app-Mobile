import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importamos HomeScreen para la navegación
import 'modem_screen.dart';
import 'ajustescontacto_screen.dart';

class WearableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wearable'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Pantalla Wearable',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Estadísticas'),
          BottomNavigationBarItem(icon: Icon(Icons.watch), label: 'Wearable'),
          BottomNavigationBarItem(icon: Icon(Icons.router), label: 'Módem'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
        currentIndex: 1, // Para destacar el botón actual (Wearable)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(contactData: {})),
              );
              break;
            case 1:
              // Ya estamos en WearableScreen, no se hace nada
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModemScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjustesContactoScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
