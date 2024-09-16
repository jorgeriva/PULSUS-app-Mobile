import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importar Supabase
import 'nodesarrollad_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, String> contactData;

  HomeScreen({required this.contactData});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables para almacenar los datos obtenidos de la base de datos
  String gender = '';
  String dateOfBirth = '';
  String height = '';
  String weight = '';
  String lastName = '';

  // Variables para almacenar los valores de las mediciones
  String heartRate = 'N/A';
  String glucose = 'N/A';
  String bodyTemperature = 'N/A';

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Llamada para obtener los datos del usuario
    _fetchMeasurements(); // Llamada para obtener las mediciones
  }

  // Método para hacer la consulta a la tabla device_users en Supabase
  Future<void> _fetchUserData() async {
    final supabase = Supabase.instance.client;

    // Realizamos la consulta usando el 'id' que recibimos de la actividad anterior
    final response = await supabase
        .from('device_users')
        .select('gender, date_of_birth, height, weight, last_name')
        .eq('id', widget.contactData['id'] as Object)
        .maybeSingle(); // Usamos maybeSingle para obtener un solo resultado o null si no hay coincidencias

    if (response != null) {
      setState(() {
        // Asignamos los valores obtenidos a las variables correspondientes
        gender = _getGenderText(response['gender']);
        dateOfBirth = response['date_of_birth'] ?? '';
        height = response['height']?.toString() ?? '';
        weight = response['weight']?.toString() ?? '';
        lastName = response['last_name'] ?? '';
      });
    }
  }

  // Método para hacer la consulta a la tabla device_measurements en Supabase
  Future<void> _fetchMeasurements() async {
    final supabase = Supabase.instance.client;

    // Realizamos la consulta usando el 'device_user_id' que recibimos
    final response = await supabase
        .from('device_measurements')
        .select('measurement_type, measurement_value')
        .eq('device_user_id', widget.contactData['id'] as Object); // Obtenemos todas las filas que correspondan con el device_user_id

    if (response != null) {
      final measurements = response as List<dynamic>;

      // Iteramos sobre las filas obtenidas y asignamos los valores correspondientes
      for (var measurement in measurements) {
        final type = measurement['measurement_type'];
        final value = measurement['measurement_value']?.toString() ?? 'N/A';

        setState(() {
          if (type == 'Frecuencia Cardiaca') {
            heartRate = value;
          } else if (type == 'Glucosa') {
            glucose = value;
          } else if (type == 'Temperatura Corporal') {
            bodyTemperature = value;
          }
        });
      }
    }
  }

  // Función auxiliar para convertir el valor de 'gender' a texto
  String _getGenderText(String gender) {
    switch (gender) {
      case 'F':
        return 'Femenino';
      case 'M':
        return 'Masculino';
      case 'O':
        return 'Otro';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Contacto'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Parte superior con foto y datos del contacto
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                SizedBox(height: 16),
                // Mostramos el last_name debajo de la imagen
                Text(
                  lastName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                // Rellenamos los campos con los datos obtenidos de la base de datos
                Text('Género: $gender'),
                Text('Fecha de nacimiento: $dateOfBirth'), // Aquí puedes formatear la fecha si lo deseas
                Text('Altura: $height cm'),
                Text('Peso: $weight kg'),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Cuatro recuadros en dos filas con dos recuadros en cada fila
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Número de columnas
              childAspectRatio: 2, // Relación de aspecto para que sean más anchos que altos
              mainAxisSpacing: 16, // Espacio vertical entre los recuadros
              crossAxisSpacing: 16, // Espacio horizontal entre los recuadros
              padding: EdgeInsets.all(16),
              children: [
                _buildDataCard('Frecuencia Cardiaca', heartRate),
                _buildDataCard('Glucosa', glucose), // Añadido recuadro para Glucosa
                _buildDataCard('Pasos Realizados', 'N/A'),
                _buildDataCard('Temperatura Corporal', bodyTemperature), // Rellenamos con temperatura
              ],
            ),
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Estadísticas'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Agregar'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: 'Contactos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi Perfil'),
        ],
        onTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoDesarrolladScreen()),
          );
        },
      ),
    );
  }

  // Método para construir las tarjetas de datos
  Widget _buildDataCard(String label, String value) {
    return Card(
      elevation: 2,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
