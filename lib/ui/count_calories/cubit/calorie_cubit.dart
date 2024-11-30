import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/utils/session.dart';

part 'calorie_state.dart';

class CalorieCubit extends Cubit<CalorieState> {
  CalorieCubit() : super(CalorieInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final session = Session();

  void saveUserCalories({
    required double bmr,
    required double tdee,
  }) async {
    emit(SaveCalorieLoading());
    try {
      final userId = await session.read(Config.getUser);
      if (userId == null) {
        throw Exception("User ID not found in session");
      }
      await _firestore.collection('users').doc(userId).update({
        'bmr': bmr,
        'tdee': tdee,
      });

      emit(SaveCalorieSuccess());
    } catch (e) {
      emit(SaveCalorieError(message: e.toString()));
    }
  }
}
