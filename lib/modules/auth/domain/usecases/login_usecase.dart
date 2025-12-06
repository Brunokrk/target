import 'package:target/modules/auth/domain/entities/user.dart';
import 'package:target/modules/auth/domain/repositories/auth_repository.dart';

/// Caso de uso de login
///
/// Implementa a lógica de negócio para realizar o login do usuário.
/// Usa o repositório para acessar os dados.
class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  /// [username] e [password] são as credenciais do usuário.
  /// Retorna um [User] se o login for bem-sucedido.
  /// Lança uma exceção se as credenciais forem inválidas.
  Future<User> execute(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Por favor, preencha todos os campos');
    }

    try {
      return await _repository.login(username, password);
    } catch (e) {
        throw Exception('Usuário ou senha inválidos');
    }
  }
}
