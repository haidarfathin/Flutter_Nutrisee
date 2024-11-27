import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/data/model/firestore/user_data.dart';
import 'package:nutrisee/core/utils/session.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final session = Session();
  var userid;

  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    try {
      emit(AuthLoading());
      UserCredential response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await session.save(Config.getUser, response.user!.uid);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void signup(String email, String password) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        userid = firebaseUser.uid;
        await session.save(Config.getUser, userid);
        emit(RegisterSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError(
          message: 'The password provided is too weak.',
        ));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError(
          message: 'The account already exists for that email.',
        ));
      }
    }
  }

  void saveUserData({
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required int height,
    required int weight,
    required DateTime birthDate,
    required bool hasDiabetes,
    bool hasHipertensi = false,
    String? diabetesType,
    double? bmr,
    double? tdee,
    Map<String, dynamic>? dataTensi,
  }) async {
    emit(SaveDataLoading());
    try {
      final user = UserData(
        uid: userid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        height: height,
        weight: weight,
        birthDate: birthDate,
        hasDiabetes: hasDiabetes,
        hasHipertensi: hasHipertensi,
        diabetesType: diabetesType,
        bmr: bmr,
        tdee: tdee,
        dataTensi: dataTensi,
      );
      log(user.toString());
      await _firestore.collection('users').doc(userid).set(user.toMap());
      emit(SaveDataSuccess());
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
      ));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await _auth.signOut();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
