part of 'calorie_cubit.dart';

abstract class CalorieState extends Equatable {
  const CalorieState();

  @override
  List<Object> get props => [];
}

class CalorieInitial extends CalorieState {}

class SaveCalorieLoading extends CalorieState {}

class SaveCalorieSuccess extends CalorieState {}

class SaveCalorieError extends CalorieState {
  final String? message;

  const SaveCalorieError({required this.message});

  @override
  List<Object> get props => [message ?? ""];
}
