import 'package:target/modules/auth/domain/entities/user.dart';

/// Serviço mock para gerenciar a sessão do usuário
class SessionService {
  static final SessionService _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();

  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _isLoggedIn;

  void setUser(User user) {
    _currentUser = user;
    _isLoggedIn = true;
  }

  void clearSession() {
    _currentUser = null;
    _isLoggedIn = false;
  }

  bool hasActiveSession() {
    return _isLoggedIn && _currentUser != null;
  }
}

