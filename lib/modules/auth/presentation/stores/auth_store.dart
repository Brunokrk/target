import 'package:mobx/mobx.dart';
import 'package:target/core/services/session_service.dart';
import 'package:target/modules/auth/domain/usecases/login_usecase.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final LoginUsecase _loginUsecase;
  final SessionService _sessionService;

  _AuthStore({
    required LoginUsecase loginUsecase,
    required SessionService sessionService,
  }) : _loginUsecase = loginUsecase,
       _sessionService = sessionService {
    // Verifica se há uma sessão ativa ao inicializar
    _checkActiveSession();
  }

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isLoggedIn = false;

  @action
  void setUsername(String value) {
    username = value;
    errorMessage = null;
  }

  @action
  void setPassword(String value) {
    password = value;
    errorMessage = null;
  }

  @action
  Future<void> login() async {
    isLoading = true;
    errorMessage = null;

    try {
      // Usa o usecase para realizar o login
      final user = await _loginUsecase.execute(username, password);

      // Salva a sessão
      _sessionService.setUser(user);
      isLoggedIn = true;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      if (errorMessage!.isEmpty) {
        errorMessage = 'Erro ao fazer login. Tente novamente.';
      }
    } finally {
      isLoading = false;
    }
  }

  @action
  void logout() {
    username = '';
    password = '';
    _sessionService.clearSession();
    isLoggedIn = false;
    errorMessage = null;
  }

  @action
  void _checkActiveSession() {
    if (_sessionService.hasActiveSession()) {
      isLoggedIn = true;
    }
  }

  @computed
  bool get canLogin => username.isNotEmpty && password.isNotEmpty && !isLoading;
}
