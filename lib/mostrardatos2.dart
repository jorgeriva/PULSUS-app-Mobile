import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Asegúrate de tener esta dependencia en tu pubspec.yaml

class DatosDos extends StatelessWidget {
  final String name;
  final String age;
  final String gender;

  DatosDos({
    required this.name,
    required this.age,
    required this.gender,
  });

  void _showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void _showOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showToast(context, 'Ajustes');
                  },
                  child: Icon(Icons.settings),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showToast(context, 'Añadir dispositivos');
                  },
                  child: Icon(Icons.devices),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Datos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Mostrar los datos
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: $name', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Edad: $age', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Género: $gender', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                // Recuadro para añadir una foto
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      // Aquí se puede añadir la funcionalidad para añadir una foto
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.add_a_photo, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Tres gráficos en una fila, más grandes y menos separados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gráfico 1
                Column(
                  children: [
                    Container(
                      width: 210,
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Gráfica 1',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text('Sueño'),
                  ],
                ),
                // Gráfico 2
                Column(
                  children: [
                    Container(
                      width: 210,
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Gráfica 2',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text('Frecuencia Cardiaca'),
                  ],
                ),
                // Gráfico 3
                Column(
                  children: [
                    Container(
                      width: 210,
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Gráfica 3',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text('Presión Arterial'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showOptions(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
