import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lr4_variant5/model/calculation.dart'; // ← замени на своё имя проекта
import 'package:lr4_variant5/database/db_provider.dart';
import 'cosmic_speed_state.dart';

class CosmicSpeedCubit extends Cubit<CosmicSpeedState> {
  CosmicSpeedCubit() : super(CosmicSpeedInitial());

  void calculate(double mass, double radius, bool isAgreed) async {
    if (!isAgreed) {
      emit(CosmicSpeedError('Поставьте галочку на согласие!'));
      return;
    }
    if (mass <= 0 || radius <= 0) {
      emit(CosmicSpeedError('Масса и радиус должны быть > 0'));
      return;
    }

    const G = 6.67430e-11;
    final velocity = sqrt(G * mass / radius);

    // Сохраняем в БД
    await DBProvider.db.createCalculation(
      Calculation(mass: mass, radius: radius, velocity: velocity)
    );

    emit(CosmicSpeedSuccess(velocity));
  }
}