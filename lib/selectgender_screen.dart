import 'package:flutter/material.dart';
import 'heightandweight_screen.dart'; // Importar la pantalla de altura y peso

class SelectGenderScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String parentesco;

  SelectGenderScreen(
      {required this.nombre, required this.apellido, required this.parentesco});

  @override
  _SelectGenderScreenState createState() => _SelectGenderScreenState();
}

class _SelectGenderScreenState extends State<SelectGenderScreen> {
  String? selectedGender;
  final TextEditingController _edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona Género y Edad'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Indica el Género',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenderOption(
                    label: 'Hombre',
                    icon: Icons.male,
                    selected: selectedGender == 'Hombre',
                    onTap: () {
                      setState(() {
                        selectedGender = 'Hombre';
                      });
                    },
                  ),
                  SizedBox(width: 16),
                  GenderOption(
                    label: 'Mujer',
                    icon: Icons.female,
                    selected: selectedGender == 'Mujer',
                    onTap: () {
                      setState(() {
                        selectedGender = 'Mujer';
                      });
                    },
                  ),
                  SizedBox(width: 16),
                  GenderOption(
                    label: 'Otro',
                    icon: Icons.transgender,
                    selected: selectedGender == 'Otro',
                    onTap: () {
                      setState(() {
                        selectedGender = 'Otro';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
              TextField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ingresa la Edad',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (selectedGender != null &&
                      _edadController.text.isNotEmpty) {
                    // Aquí navegamos a la pantalla heightandweight_screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeightAndWeightScreen(
                          nombre: widget.nombre,
                          apellido: widget.apellido,
                          parentesco: widget.parentesco,
                          genero: selectedGender!,
                          edad: _edadController.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, selecciona un género y edad'),
                      ),
                    );
                  }
                },
                child: Text('Siguiente'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const GenderOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: selected ? Colors.blue : Colors.grey,
          ),
          Text(label),
        ],
      ),
    );
  }
}
