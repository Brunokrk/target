import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:target/core/theme/app_theme.dart';

class PrivacyPolicyFooter extends StatelessWidget {

  final String? route;
  final String? text;

  final Color? textColor;

  final EdgeInsetsGeometry? padding;

  const PrivacyPolicyFooter({
    super.key,
    required this.route,
    this.text,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: TextButton(
        onPressed: () {
          context.push(route ?? '/privacy-policy');
        },
        child: Text(
          text ?? 'Política de Privacidade',
          style: TextStyle(
            color: textColor ?? AppTheme.textSecondaryOnDark,
          ),
        ),
      ),
    );
  }
}

