import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrisee/core/firebase/models/myuser.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signIn(String email, String password);

  Future<void> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser user);

  Future<MyUser> getUserData(String userId);

  Future<void> logOut();
}
