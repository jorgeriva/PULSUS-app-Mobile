// checkyouremail_screen.dart
import 'package:flutter/material.dart';
import 'newpassword_screen.dart'; // Importar la siguiente pantalla

class CheckYourEmailScreen extends StatefulWidget {
  final String email;

  CheckYourEmailScreen({required this.email});

  @override
  _CheckYourEmailScreenState createState() => _CheckYourEmailScreenState();
}

class _CheckYourEmailScreenState extends State<CheckYourEmailScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revisa tu correo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Revisa tu correo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Por favor ingresa el código de 4 dígitos que hemos enviado a la dirección:',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0),
            Text(
              widget.email,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (codeController.text.length == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPasswordScreen()),
                  );
                } else {
                  // Mostrar algún mensaje de error si es necesario
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
