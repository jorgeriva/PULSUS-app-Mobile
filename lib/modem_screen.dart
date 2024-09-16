import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importamos HomeScreen para la navegación
import 'wereable_screen.dart';
import 'ajustescontacto_screen.dart';

class ModemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módem'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Pantalla Módem',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Estadísticas'),
          BottomNavigationBarItem(icon: Icon(Icons.watch), label: 'Wearable'),
          BottomNavigationBarItem(icon: Icon(Icons.router), label: 'Módem'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
        currentIndex: 2, // Para destacar el botón actual (Módem)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(contactData: {})),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WearableScreen()),
              );
              break;
            case 2:
              // Ya estamos en ModemScreen, no se hace nada
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AjustesContactoScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
