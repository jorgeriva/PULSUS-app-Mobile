import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importar Supabase
import 'addcontact_screen.dart'; // Para navegar a la pantalla de añadir contacto
import 'home_screen.dart'; // Importamos la pantalla HomeScreen
import 'nodesarrollad_screen.dart'; // Importamos la pantalla NoDesarrolladScreen

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
    final newContact =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

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
          'foto': newContact['foto'] ?? '', // Añadimos el campo foto
          'estado':
              newContact['estado'] ?? 'offline', // Añadimos el campo estado
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
        matchingUser =
            response; // Almacenamos los datos del usuario coincidente
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen'),
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
                color: Colors.blue.withOpacity(
                    0.5), // Color azul claro con 50% de transparencia
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: matchingUser!['photo_url'] != null &&
                                matchingUser!['photo_url']!.isNotEmpty
                            ? NetworkImage(matchingUser!['photo_url'])
                            : AssetImage('assets/default_profile.png')
                                as ImageProvider, // Imagen por defecto
                        radius: 30,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '${matchingUser!['first_name']} ${matchingUser!['last_name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        matchingUser!['status'] == 'online'
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: matchingUser!['status'] == 'online'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: contacts.isEmpty
                ? Center()
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return GestureDetector(
                        onTap: () {
                          // Navegar a HomeScreen al hacer clic en el recuadro, pasando los datos del contacto
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                contactData:
                                    contact, // Enviamos los datos del contacto seleccionado
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.blue.withOpacity(
                              0.5), // Color azul claro con 50% de transparencia
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundImage: contact['foto'] != null &&
                                      contact['foto']!.isNotEmpty
                                  ? NetworkImage(contact['foto']!)
                                  : AssetImage('assets/default_profile.png')
                                      as ImageProvider, // Imagen por defecto
                              radius: 30,
                            ),
                            title: Text(
                              '${contact['nombre']} ${contact['apellido']}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Género: ${contact['genero']}'),
                                Text('Edad: ${contact['edad']} años'),
                                Text('Parentesco: ${contact['parentesco']}'),
                                Text('Altura: ${contact['altura']}'),
                                Text('Peso: ${contact['peso']}'),
                              ],
                            ),
                            trailing: Icon(
                              contact['estado'] == 'online'
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: contact['estado'] == 'online'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // Barra de navegación inferior con tres botones
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart), // Primer botón de estadísticas
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Segundo botón para añadir contacto
            label: 'Persona',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Tercer botón para ajustes
            label: 'Ajustes',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Estadísticas, permanecemos en la pantalla actual
          } else if (index == 1) {
            // Al tocar el botón de "Persona", navegamos a la pantalla de añadir contacto
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddContactScreen()), // Navegamos a la pantalla de añadir contacto
            );
          } else if (index == 2) {
            // Al tocar el botón de "Ajustes", navegamos a NoDesarrolladScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NoDesarrolladScreen()), // Navegamos a NoDesarrolladScreen
            );
          }
        },
      ),
    );
  }
}
