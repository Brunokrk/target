import 'package:target/modules/auth/data/models/login_request.dart';
import 'package:target/modules/auth/data/models/login_response.dart';

abstract class AuthDatasource {
  /// Retorna um [LoginResponse] com os dados do usuário e token de autenticação.
  /// Lança uma exceção se as credenciais forem inválidas.
  Future<LoginResponse> login(LoginRequest request);
}
