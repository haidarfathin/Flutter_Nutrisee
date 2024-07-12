import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrisee/core/data/model/firestore/reminder_data.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addReminder(
    ReminderData reminderData,
  ) {
    try {
    
    } catch (e) {
      
    }
  }
}
