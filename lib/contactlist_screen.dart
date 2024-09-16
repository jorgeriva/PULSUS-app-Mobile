import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importar Supabase
import 'addcontact_screen.dart'; // Para navegar a la pantalla de añadir contacto
import 'home_screen.dart'; // Importamos la pantalla HomeScreen

class ContactListScreen extends StatefulWidget {
  final String tenantId; // Añadimos el tenantId como parte del constructor

  // Modificamos el constructor para recibir el tenantId
  ContactListScreen({required this.tenantId});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Map<String, String>> contacts = []; // Lista para almacenar contactos
  Map<String, dynamic>? matchingUser; // Almacenar el usuario coincidente

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newContact = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    
    // Si hay un contacto nuevo, lo añadimos a la lista
    if (newContact != null) {
      setState(() {
        contacts.add({
          'nombre': newContact['nombre'],
          'apellido': newContact['apellido'],
          'genero': newContact['genero'],
          'edad': newContact['edad'],
          'parentesco': newContact['parentesco'],
          'altura': newContact['altura'],
          'peso': newContact['peso'],
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMatchingUser(); // Llamada para buscar coincidencias en la base de datos
  }

  // Método para hacer la consulta a la tabla device_users en Supabase
  Future<void> _fetchMatchingUser() async {
    final supabase = Supabase.instance.client;
    
    // Hacemos la consulta a la tabla 'device_users' para buscar coincidencias con tenantId
    final response = await supabase
        .from('device_users')
        .select('*')
        .eq('tenant_id', widget.tenantId)
        .maybeSingle(); // Usamos maybeSingle para obtener un solo resultado o null si no hay coincidencias
    
    if (response != null) {
      setState(() {
        matchingUser = response; // Almacenamos los datos del usuario coincidente
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adultos mayores'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Contacto',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Si hay un usuario coincidente, mostramos el recuadro azul claro
          if (matchingUser != null)
            GestureDetector(
              onTap: () {
                // Al hacer clic, navegamos a HomeScreen pasando el ID del usuario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      contactData: {
                        'id': matchingUser!['id'],
                      },
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.lightBlue[100], // Relleno azul clarito
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${matchingUser!['first_name']} ${matchingUser!['last_name']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: contacts.isEmpty
                ? Center(
                    child: Text('No hay contactos aún.'),
                  )
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navegar a HomeScreen al hacer clic en el recuadro, pasando los datos del contacto
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                contactData: contacts[index], // Enviamos los datos del contacto seleccionado
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${contacts[index]['nombre']} ${contacts[index]['apellido']}',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('Género: ${contacts[index]['genero']}'),
                                Text('Edad: ${contacts[index]['edad']} años'),
                                Text('Parentesco: ${contacts[index]['parentesco']}'),
                                Text('Altura: ${contacts[index]['altura']}'),
                                Text('Peso: ${contacts[index]['peso']}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Navegar a la pantalla de añadir contacto
              final newContact = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddContactScreen()), // Aquí navegas a la pantalla AddContactScreen
              );
              if (newContact != null) {
                setState(() {
                  contacts.add(newContact); // Agregar el nuevo contacto
                });
              }
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
