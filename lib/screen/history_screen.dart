import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..loadHistory(),
      child: Scaffold(
        appBar: AppBar(title: Text('История расчётов')),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HistoryLoaded) {
              if (state.calculations.isEmpty) {
                return Center(child: Text('Нет сохранённых расчётов'));
              }
              return ListView.builder(
                itemCount: state.calculations.length,
                itemBuilder: (context, index) {
                  final calc = state.calculations[index];
                  return ListTile(
                    title: Text('Масса: ${calc.mass.toStringAsFixed(2)} кг'),
                    subtitle: Text(
                      'Радиус: ${calc.radius.toStringAsFixed(2)} м\n'
                      'Скорость: ${calc.velocity.toStringAsFixed(2)} м/с',
                    ),
                  );
                },
              );
            }
            if (state is HistoryError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}