import 'package:flutter/material.dart';
import 'congratulations.dart'; // Importa la pantalla de felicitaciones

class LogUpScreen extends StatefulWidget {
  @override
  _LogUpScreenState createState() => _LogUpScreenState();
}

class _LogUpScreenState extends State<LogUpScreen> {
  bool rememberPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Flecha de regreso
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Terceridad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal, // Color turquesa
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Bienvenido a',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Mensaje de Bienvenida',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal, // Color turquesa para el subtítulo
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Puedes registrarte usando:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Acción para el botón de Google
                  },
                  icon: Icon(Icons.g_mobiledata), // Icono de Google
                  label: Text('Google'),
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.white,
                    //onPrimary: Colors.black,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Ingrese su nombre'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nombre',
                ),
              ),
              SizedBox(height: 10),
              Text('Ingrese sus apellidos'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Apellidos',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Puedes usar letras, números y signos.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text('Ingrese su E-mail'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: '*******',
                      ),
                      obscureText: true, // Campo de contraseña
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Confirmar',
                        hintText: '*******',
                      ),
                      obscureText: true, // Campo de confirmar contraseña
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Usa más de 8 caracteres, combinando letras números y símbolos.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: rememberPassword,
                    onChanged: (newValue) {
                      setState(() {
                        rememberPassword = newValue!;
                      });
                    },
                  ),
                  Text('Recordar mi Contraseña'),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navega a la pantalla de felicitaciones
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CongratulationsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.teal, // Color turquesa
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'REGISTRARME',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
