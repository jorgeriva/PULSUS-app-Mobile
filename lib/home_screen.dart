import 'package:flutter/material.dart';
import 'nodesarrollad_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, String> contactData;

  HomeScreen({required this.contactData});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                Text(
                  '${widget.contactData['nombre']} ${widget.contactData['apellido']}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Género: ${widget.contactData['genero']}'),
                Text('Edad: ${widget.contactData['edad']} años'),
                Text('Parentesco: ${widget.contactData['parentesco']}'),
                Text('Altura: ${widget.contactData['altura']}'),
                Text('Peso: ${widget.contactData['peso']}'),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Tres recuadros en blanco para datos futuros
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDataCard('Presión Cardíaca'),
                _buildDataCard('Horas de Sueño'),
                _buildDataCard('Pasos Realizados'),
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
  Widget _buildDataCard(String label) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
