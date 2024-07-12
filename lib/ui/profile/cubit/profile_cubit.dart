import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/data/model/firestore/user_data.dart';
import 'package:nutrisee/core/utils/session.dart';

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
}
