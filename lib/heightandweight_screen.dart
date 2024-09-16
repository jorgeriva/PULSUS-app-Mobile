import 'package:flutter/material.dart';
import 'contactlist_screen.dart'; // Asegúrate de importar tu pantalla de lista de contactos

class HeightAndWeightScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String genero;
  final String edad;
  final String parentesco; // Ahora también recibimos parentesco

  HeightAndWeightScreen({
    required this.nombre,
    required this.apellido,
    required this.genero,
    required this.edad,
    required this.parentesco, // Recibimos parentesco
  });

  @override
  _HeightAndWeightScreenState createState() => _HeightAndWeightScreenState();
}

class _HeightAndWeightScreenState extends State<HeightAndWeightScreen> {
  int? altura;
  int? peso;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Altura y Peso'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Altura',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: altura,
              items: [150, 160, 170, 180].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value cm'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  altura = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Peso',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: peso,
              items: [50, 60, 70, 80].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value kg'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  peso = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (altura != null && peso != null) {
                  // Al presionar CONTINUAR, enviamos los datos a ContactListScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactListScreen(tenantId: '2'),
                      settings: RouteSettings(
                        arguments: {
                          'nombre': widget.nombre,
                          'apellido': widget.apellido,
                          'genero': widget.genero,
                          'edad': widget.edad,
                          'parentesco':
                              widget.parentesco, // Incluimos parentesco
                          'altura': '$altura cm',
                          'peso': '$peso kg',
                        },
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Por favor, selecciona la altura y el peso'),
                    ),
                  );
                }
              },
              child: Text('CONTINUAR'),
            ),
          ],
        ),
      ),
    );
  }
}
