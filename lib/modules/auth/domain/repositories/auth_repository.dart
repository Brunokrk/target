import 'package:target/modules/auth/domain/entities/user.dart';

/// Contrato do repositório de autenticação
abstract class AuthRepository {

  /// [username] e [password] são as credenciais do usuário.
  /// Retorna um [User] se o login for bem-sucedido.
  /// Lança uma exceção se as credenciais forem inválidas.
  Future<User> login(String username, String password);
}

