import 'package:target/modules/auth/data/datasources/auth_datasource.dart';
import 'package:target/modules/auth/data/models/login_request.dart';
import 'package:target/modules/auth/data/models/login_response.dart';

/// Implementação mock do datasource de autenticação
///
/// Simula chamadas de API com dados mockados.
/// Em uma aplicação real, isso seria substituído por uma implementação
/// que faz chamadas HTTP reais.
class AuthDatasourceMock implements AuthDatasource {
  // Usuários mockados para simulação
  static const Map<String, Map<String, dynamic>> _mockUsers = {
    'admin': {'password': '123456', 'email': 'admin@target.com'},
    'user': {'password': 'password', 'email': 'user@target.com'},
    'teste': {'password': 'teste123', 'email': 'teste@target.com'},
  };

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // Delay de rede
    await Future.delayed(const Duration(seconds: 2));

    // Verifica se o usuário existe
    final userData = _mockUsers[request.username.toLowerCase()];

    if (userData == null || userData['password'] != request.password) {
      throw Exception('Usuário ou senha inválidos');
    }

    final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
    return LoginResponse.fromJson({
      'user': {'username': request.username, 'email': userData['email']},
      'token': token,
      'success': true,
    });
  }
}
