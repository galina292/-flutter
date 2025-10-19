// lib/cubit/history_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/calculation.dart';
import '../database/db_provider.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      final calculations = await DBProvider.db.getAllCalculations();
      emit(HistoryLoaded(calculations));
    } catch (e) {
      emit(HistoryError('Ошибка загрузки истории'));
    }
  }
}