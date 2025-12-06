import 'package:target/modules/auth/data/datasources/auth_datasource.dart';
import 'package:target/modules/auth/data/datasources/auth_datasource_mock.dart';
import 'package:target/modules/auth/data/models/login_request.dart';
import 'package:target/modules/auth/domain/entities/user.dart';
import 'package:target/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : _datasource = datasource ?? AuthDatasourceMock();

  @override
  Future<User> login(String username, String password) async {
    try {
      final request = LoginRequest(
        username: username,
        password: password,
      );

      final response = await _datasource.login(request);

      if (!response.success) {
        throw Exception('Falha no login');
      }
      return response.user;
    } catch (e) {
     
      throw Exception('Usuário ou senha inválidos');
    
    }
  }
}

