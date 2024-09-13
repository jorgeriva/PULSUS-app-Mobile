import 'package:flutter/material.dart';
import 'selectgender_screen.dart'; // Para navegar a la pantalla de seleccionar género

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  String parentesco = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Adulto Mayor'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Ingresa el Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _apellidoController,
                decoration: InputDecoration(
                  labelText: 'Ingresa el Apellido(s)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: parentesco.isNotEmpty ? parentesco : null,
                decoration: InputDecoration(
                  labelText: 'Parentesco',
                  border: OutlineInputBorder(),
                ),
                items: ['Padre', 'Madre', 'Abuelo', 'Abuela', 'Otro'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    parentesco = newValue!;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_nombreController.text.isNotEmpty &&
                      _apellidoController.text.isNotEmpty &&
                      parentesco.isNotEmpty) {
                    // Si los campos están completos, navegar a la siguiente pantalla
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectGenderScreen(
                                nombre: _nombreController.text,
                                apellido: _apellidoController.text,
                                parentesco: parentesco,
                              )),
                    );
                  } else {
                    // Mostrar un mensaje de error si faltan campos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                      ),
                    );
                  }
                },
                child: Text('Siguiente'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
