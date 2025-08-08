import '../services/firebase_auth_service.dart';

class AuthController {
  final FirebaseAuthService _service = FirebaseAuthService();

  Future<String?> signUp(String email, String password) async {
    try {
      await _service.signUp(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _service.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
