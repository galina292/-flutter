import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Твоё ФИО'), // ← ОБЯЗАТЕЛЬНО замени на своё ФИО!
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        spacing: 12.0,     // горизонтальный отступ между контейнерами
        runSpacing: 12.0,  // вертикальный отступ между строками
        children: [
          _buildCard('ФИО', 'Полтаракова Галина Антоновна'),
          _buildCard('Год рождения', '2003'),
          _buildCard('Группа', 'ИСТУ-22'),
          _buildCard('Факультет', 'Информационных технологий'),
          _buildCard('Направление', 'Прикладная информатика'),
          _buildCard('Email', 'poltarakova2000@mail.ru'),
        ],
      ),
    );
  }

  Widget _buildCard(String label, String value) {
    return Container(
      width: 160,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}