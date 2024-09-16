import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importamos HomeScreen para la navegación
import 'wereable_screen.dart';
import 'modem_screen.dart';

class AjustesContactoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes de Contacto'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Pantalla Ajustes de Contacto',
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
        currentIndex: 3, // Para destacar el botón actual (Ajustes)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(contactData: {})),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WearableScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModemScreen()),
              );
              break;
            case 3:
              // Ya estamos en AjustesContactoScreen, no se hace nada
              break;
          }
        },
      ),
    );
  }
}
