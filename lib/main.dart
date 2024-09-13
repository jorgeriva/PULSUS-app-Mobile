import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart'; // Importa la pantalla de inicio de sesión

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los bindings estén inicializados antes de continuar.

  // Inicializar Supabase
  await Supabase.initialize(
    url: 'https://bfpappwbxuqylrvrqsxf.supabase.co',  // Reemplaza esto con tu URL de Supabase
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmcGFwcHdieHVxeWxydnJxc3hmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI0ODIxNTgsImV4cCI6MjAzODA1ODE1OH0.kU0qEm4RJ9z493nsEwSlDlYeJ_3-gBtw4Vp2PFu-YXM',  // Reemplaza esto con tu clave pública (anon key)
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(), // Pantalla de bienvenida
    );
  }
}

// Pantalla de bienvenida
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Texto grande "terceridade"
            Text(
              'PULSUS',
              style: TextStyle(
                fontSize: 40.0, // Tamaño de la fuente
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
            SizedBox(height: 50.0),
            // Botón cuadrado de "Empezar"
            ElevatedButton(
              onPressed: () {
                // Navegar a LoginScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                //primary: Colors.cyan, // Color turquesa
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Bordes no redondeados
                ),
              ),
              child: Text(
                'Empezar',
                style: TextStyle(fontSize: 20.0), // Tamaño del texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
