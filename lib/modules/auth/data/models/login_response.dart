import 'package:target/modules/auth/domain/entities/user.dart';

/// Modelo de resposta do login
class LoginResponse {
  final User user;
  final String token;
  final bool success;

  const LoginResponse({
    required this.user,
    required this.token,
    required this.success,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User(
        username: json['user']['username'] as String,
        email: json['user']['email'] as String,
      ),
      token: json['token'] as String,
      success: json['success'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'username': user.username,
        'email': user.email,
      },
      'token': token,
      'success': success,
    };
  }
}

