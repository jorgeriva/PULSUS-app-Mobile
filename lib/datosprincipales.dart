import 'package:flutter/material.dart';
import 'mostrardatos1.dart'; // Importa la tercera pantalla

class SecondScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final String email;

  SecondScreen(
      {
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.1,
                vertical: constraints.maxHeight * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Edad',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                      labelText: 'Sexo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThirdScreen(
                            name: nameController.text,
                            age: ageController.text,
                            gender: genderController.text,
                            email: email,
                          ),
                        ),
                      );
                    },
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
