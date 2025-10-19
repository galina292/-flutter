import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cosmic_speed_cubit.dart';
import 'screen/calculator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЛР5: Хранение данных',
      home: BlocProvider(
        create: (context) => CosmicSpeedCubit(),
        child: CalculatorScreen(),
      ),
    );
  }
}