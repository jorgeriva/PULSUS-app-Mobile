import 'package:flutter/material.dart';
import 'registrarse2.dart';

class Registrarse1 extends StatefulWidget {
  @override
  _Registrarse1State createState() => _Registrarse1State();
}

class _Registrarse1State extends State<Registrarse1> {
  final TextEditingController _codigoAmigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: Center(
        // Centraliza todo
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Alinea al centro
            children: <Widget>[
              // Botón Creador (cuadrado con bordes puntiagudos)
              SizedBox(
                width: 300, // Aumenta el tamaño del botón
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Borde puntiagudo
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registrarse2()),
                    );
                  },
                  child: Text('Creador'),
                ),
              ),
              SizedBox(height: 30), // Espacio entre los elementos

              // EditText para "Código amigo"
              SizedBox(
                width:
                    300, // Mantiene el tamaño del TextField igual que el botón
                child: TextField(
                  controller: _codigoAmigoController,
                  decoration: InputDecoration(
                    labelText: 'Código amigo',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio entre el EditText y el botón

              // Botón "Invitado" (más pequeño)
              SizedBox(
                width: 120, // Reduce el tamaño del botón
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Borde puntiagudo
                    ),
                  ),
                  onPressed: () {
                    if (_codigoAmigoController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Rellenar con código amigo'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registrarse2()),
                      );
                    }
                  },
                  child: Text('Invitado'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
