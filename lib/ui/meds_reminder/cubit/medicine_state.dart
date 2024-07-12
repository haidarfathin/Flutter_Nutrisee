part of 'medicine_cubit.dart';

abstract class MedicineState extends Equatable {
  const MedicineState();

  @override
  List<Object> get props => [];
}

class MedicineInitial extends MedicineState {}

class AddReminderLoading extends MedicineState {}

class AddReminderSuccess extends MedicineState {
  final ReminderData data;

  AddReminderSuccess({required this.data});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AddReminderError extends MedicineState {
  final String message;

  AddReminderError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
