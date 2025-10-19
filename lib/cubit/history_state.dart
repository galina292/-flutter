// lib/cubit/history_state.dart
import '../model/calculation.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Calculation> calculations;
  HistoryLoaded(this.calculations);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}