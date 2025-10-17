import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cosmic_speed_state.dart';

class CosmicSpeedCubit extends Cubit<CosmicSpeedState> {
  CosmicSpeedCubit() : super(CosmicSpeedInitial());

  void calculate(double mass, double radius, bool isAgreed) {
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
    emit(CosmicSpeedSuccess(velocity));
  }
}