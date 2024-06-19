abstract class UserRepository {
  Future<void> signIn(String email, String password);

  Future<void> logOut();
}
