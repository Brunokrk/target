import 'package:flutter/material.dart';
import 'package:target/core/theme/app_theme.dart';

/// Componente de background com degradê padronizado
///
/// Widget reutilizável que aplica o degradê verde/azul padrão do app.
/// Pode ser usado em qualquer página para manter a consistência visual.
class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final bool useSafeArea;

  const GradientBackground({
    super.key,
    required this.child,
    this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.useSafeArea = true,
  });

  List<Color> get defaultColors => AppTheme.gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors ?? AppTheme.gradientColors,
        ),
      ),
      child: useSafeArea ? SafeArea(child: child) : child,
    );
  }
}
