import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrisee/core/data/model/user/user_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userid;

  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthLoggedIn());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        userid = firebaseUser.uid;
        emit(AuthLoggedIn());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError('The account already exists for that email.'));
      }
    }
  }

  Future<void> saveUserData({
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required int height,
    required int weight,
    required DateTime birthDate,
    required bool hasDiabetes,
    String? diabetesType,
  }) async {
    emit(AuthLoading());
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
        diabetesType: diabetesType,
      );

      await _firestore.collection('users').doc(userid).set(user.toMap());
      emit(AuthLoggedIn());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await _auth.signOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
