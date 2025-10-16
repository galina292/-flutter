import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЛР3: Вариант 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InputScreen(),
    );
  }
}

// Экран ввода данных
class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _massController = TextEditingController();
  final _radiusController = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Галина Полтаракова'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _massController,
                decoration: InputDecoration(
                  labelText: 'Масса небесного тела (кг)',
                  hintText: 'Например: 5.972e24',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите массу';
                  if (double.tryParse(value) == null) return 'Введите число';
                  if (double.parse(value) <= 0) return 'Масса должна быть > 0';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _radiusController,
                decoration: InputDecoration(
                  labelText: 'Радиус небесного тела (м)',
                  hintText: 'Например: 6.371e6',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите радиус';
                  if (double.tryParse(value) == null) return 'Введите число';
                  if (double.parse(value) <= 0) return 'Радиус должен быть > 0';
                  return null;
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('Согласен на обработку данных'),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() => _isChecked = value ?? false);
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _isChecked) {
                    final mass = double.parse(_massController.text);
                    final radius = double.parse(_radiusController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(mass: mass, radius: radius),
                      ),
                    );
                  } else if (!_isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Поставьте галочку на согласие!')),
                    );
                  }
                },
                child: Text('Рассчитать первую космическую скорость'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Экран результата
class ResultScreen extends StatelessWidget {
  final double mass;
  final double radius;

  const ResultScreen({required this.mass, required this.radius});

  @override
  Widget build(BuildContext context) {
    const G = 6.67430e-11; // гравитационная постоянная
    final velocity = sqrt(G * mass / radius);

    return Scaffold(
      appBar: AppBar(title: Text('Результат')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Первая космическая скорость:', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              Text('${velocity.toStringAsFixed(2)} м/с', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}