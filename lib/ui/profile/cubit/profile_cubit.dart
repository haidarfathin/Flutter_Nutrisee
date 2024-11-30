import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/data/model/firestore/user_data.dart';
import 'package:nutrisee/core/utils/session.dart';
import 'package:nutrisee/core/utils/status.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final session = Session();

  void fetchProfile() async {
    emit(GetProfileLoading());
    try {
      final userId = await session.read(Config.getUser);
      log("userid $userId");
      if (userId != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection("users").doc(userId).get();
        UserData userData =
            UserData.fromMap(userDoc.data() as Map<String, dynamic>);
        log(userData.toString());

        emit(GetProfileSuccess(data: userData));
        if (userDoc.exists) {}
      }
    } catch (e) {
      emit(GetProfileError(message: "An error occurred: ${e.toString()}"));
    }
  }

  void changeMedicalIssue(String choose) async {
    emit(ChangeSickLoading());
    try {
      final userId = await session.read(Config.getUser);

      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      Map<String, dynamic> updateData = {};

      // Menentukan field berdasarkan pilihan user
      switch (choose) {
        case "1":
          updateData = {
            "hasHipertensi": true,
            "hasDiabetes": false,
          };
          break;
        case "2":
          updateData = {
            "hasHipertensi": false,
            "hasDiabetes": true,
            "diabetesType": "1",
          };
          break;
        case "3":
          updateData = {
            "hasHipertensi": false,
            "hasDiabetes": true,
            "diabetesType": "2",
          };
          break;
        case "4":
          updateData = {
            "hasHipertensi": false,
            "hasDiabetes": false,
            "diabetesType": null,
          };
          break;
        default:
          throw Exception("Pilihan tidak valid");
      }

      // Update data pada Firestore
      await userDoc.update(updateData);
      log("SUKSES");
      emit(ChangeSickSuccess());
    } catch (e) {
      emit(ChangeSickError(message: "Gagal mengubah data: ${e.toString()}"));
    }
  }
}
