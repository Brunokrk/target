import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:target/core/injection/injection_container.dart';
import 'package:target/core/theme/app_theme.dart';
import 'package:target/modules/auth/presentation/stores/auth_store.dart';
import 'package:target/shared/services/toast_service.dart';
import 'package:target/shared/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthStore _authStore;
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _authStore = getIt<AuthStore>();
    _usernameController.addListener(() {
      _authStore.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _authStore.setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await _authStore.login();

      // Verifica se houve erro após o login e exibe toast
      if (_authStore.errorMessage != null && mounted) {
        ToastService.showError(context, _authStore.errorMessage!);
      } else if (_authStore.isLoggedIn && mounted) {
        // Navega para a tela de listing após login bem-sucedido
        context.go('/listing-page');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(),
                          Spacing.xxlVertical,
                          _buildUsernameField(),
                          Spacing.mdVertical,
                          _buildPasswordField(),
                          Spacing.lgVertical,
                          _buildLoginButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildPrivacyPolicyFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Icon(Icons.list, size: 80, color: AppTheme.textOnDark),
        Spacing.lgVertical,
        const Text(
          'Teste Prático',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.textOnDark,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Usuário',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textOnDark,
          ),
        ),
        Spacing.smVertical,
        CustomTextField(
          controller: _usernameController,
          hintText: 'Digite seu usuário',
          prefixIcon: Icons.person_outline,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, digite seu usuário';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textOnDark,
          ),
        ),
        Spacing.smVertical,
        CustomTextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          hintText: 'Digite sua senha',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleLogin(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, digite sua senha';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Observer(
      builder:
          (_) => CustomButton(
            text: 'Entrar',
            isLoading: _authStore.isLoading,
            onPressed: _authStore.canLogin ? _handleLogin : null,
          ),
    );
  }

  Widget _buildPrivacyPolicyFooter() {
    return PrivacyPolicyFooter(route: '/privacy-policy');
  }
}
