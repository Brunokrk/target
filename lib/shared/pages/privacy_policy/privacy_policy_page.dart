import 'package:flutter/material.dart';
import 'package:target/core/theme/app_theme.dart';
import 'package:target/shared/widgets/widgets.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidade'),
        backgroundColor: AppTheme.appBarBackground,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction,
                  size: 80,
                  color: AppTheme.textSecondaryOnDark,
                ),
                Spacing.xxlVertical,
                Text(
                  'Em Desenvolvimento',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textOnDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacing.mdVertical,
                Text(
                  'Esta página está em desenvolvimento e estará disponível em breve.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondaryOnDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
