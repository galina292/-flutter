import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cosmic_speed_cubit.dart';
import '../cubit/cosmic_speed_state.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _massController = TextEditingController();
  final _radiusController = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Галина Иванова'), // ← ЗАМЕНИ НА СВОЁ ФИО!
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<CosmicSpeedCubit, CosmicSpeedState>(
          listener: (context, state) {
            if (state is CosmicSpeedError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<CosmicSpeedCubit, CosmicSpeedState>(
            builder: (context, state) {
              if (state is CosmicSpeedSuccess) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Первая космическая скорость:',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${state.velocity.toStringAsFixed(2)} м/с',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          _massController.clear();
                          _radiusController.clear();
                          _isChecked = false;
                          context.read<CosmicSpeedCubit>().emit(CosmicSpeedInitial());
                        },
                        child: Text('Назад к вводу'),
                      ),
                    ],
                  ),
                );
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _massController,
                      decoration: InputDecoration(labelText: 'Масса (кг)'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => v?.isEmpty == true ? 'Введите массу' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _radiusController,
                      decoration: InputDecoration(labelText: 'Радиус (м)'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => v?.isEmpty == true ? 'Введите радиус' : null,
                    ),
                    SizedBox(height: 16),
                    CheckboxListTile(
                      title: Text('Согласен на обработку данных'),
                      value: _isChecked,
                      onChanged: (v) => setState(() => _isChecked = v ?? false),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final mass = double.parse(_massController.text);
                          final radius = double.parse(_radiusController.text);
                          context.read<CosmicSpeedCubit>().calculate(mass, radius, _isChecked);
                        }
                      },
                      child: Text('Рассчитать'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}