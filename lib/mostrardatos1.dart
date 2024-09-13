import 'package:flutter/material.dart';
import 'mostrardatos2.dart'; // Asegúrate de tener esta pantalla definida
import 'main.dart';
class ThirdScreen extends StatefulWidget {
  final String name;
  final String age;
  final String gender;
  final String email;

  ThirdScreen({
    required this.name,
    required this.age,
    required this.gender,
    required this.email,
  });

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int _dataCount = 0;
  List<Map<String, String>> _dataList = [];

  void _showAddDataDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    String? selectedGender;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadir Datos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(labelText: 'Género'),
                items: ['Hombre', 'Mujer', 'Otro'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Añadir'),
              onPressed: () {
                if (nameController.text.isEmpty ||
                    ageController.text.isEmpty ||
                    selectedGender == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Debe completar todos los campos'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  setState(() {
                    _dataList.add({
                      'name': nameController.text,
                      'age': ageController.text,
                      'gender': selectedGender!,
                    });
                    _dataCount++;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDataDialog(Map<String, String> data) {
    final TextEditingController nameController =
        TextEditingController(text: data['name']);
    final TextEditingController ageController =
        TextEditingController(text: data['age']);
    String? selectedGender = data['gender'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Datos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(labelText: 'Género'),
                items: ['Hombre', 'Mujer', 'Otro'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                if (nameController.text.isEmpty ||
                    ageController.text.isEmpty ||
                    selectedGender == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Debe completar todos los campos'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  setState(() {
                    final index = _dataList.indexOf(data);
                    if (index != -1) {
                      _dataList[index] = {
                        'name': nameController.text,
                        'age': ageController.text,
                        'gender': selectedGender!,
                      };
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar y Mostrar Datos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Mostrar datos en la parte superior
            if (_dataList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    final data = _dataList[index];
                    return Card(
                      child: ListTile(
                        title: Text('Nombre: ${data['name']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Edad: ${data['age']}'),
                            Text('Género: ${data['gender']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DatosDos(
                                      name: data['name']!,
                                      age: data['age']!,
                                      gender: data['gender']!,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditDataDialog(data);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDataDialog,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
