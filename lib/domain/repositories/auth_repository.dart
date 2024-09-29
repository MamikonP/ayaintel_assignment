abstract interface class AuthRepository {
  Future<String> signInWithEmailPassword(String email, String password);
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<void> resetPassword(String email);
}
