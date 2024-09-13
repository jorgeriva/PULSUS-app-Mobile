import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'contactlist_screen.dart';
import 'credentialerror_screen.dart';
import 'supabase_service.dart';
import 'logup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberPassword = false;

  final SupabaseClient supabase = Supabase.instance.client;
  SupabaseService _supabaseService = SupabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido a Terceridade'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recuerda que... "Siempre viene bien un poco de ayuda"',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Puedes iniciar sesión con:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  child: Text('Login with Google'),
                  onPressed: () {
                    // Acción para iniciar sesión con Google (No implementado)
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: rememberPassword,
                  onChanged: (newValue) {
                    setState(() {
                      rememberPassword = newValue!;
                    });
                  },
                ),
                Text('Recordar mi contraseña'),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CredentialErrorScreen()),
                );
              },
              child: Text(
                'Olvidé mi contraseña',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  child: Text('Iniciar sesión'),
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    try {
                      final AuthResponse res =
                          await supabase.auth.signInWithPassword(
                        email: email,
                        password: password,
                      );
                      final Session? session = res.session;
                      final User? user = res.user;

                      if (user != null) {
                        final tenantData =
                            await supabase.from('saas.tenants').select('id');

                        print('Tenant Data: $tenantData');

                        if (tenantData != null && tenantData.isNotEmpty) {
                          int tenantId = tenantData as int;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ContactListScreen(tenantId: tenantId),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "No se encontró el tenant del usuario",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Email o contraseña incorrectos",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    } catch (error) {
                      Fluttertoast.showToast(
                        msg: "Error al iniciar sesión: $error",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogUpScreen()),
                  );
                },
                child: Text(
                  'Registrarte aquí',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
