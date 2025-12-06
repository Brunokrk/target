import 'package:flutter/material.dart';

class Spacing {

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  Spacing._();

  /// Espaçamento vertical (height)
  static Widget vertical(double height) {
    return SizedBox(height: height);
  }

  /// Espaçamento horizontal (width)
  static Widget horizontal(double width) {
    return SizedBox(width: width);
  }

  // Gettersss
  static Widget get xsVertical => vertical(xs);
  static Widget get smVertical => vertical(sm);
  static Widget get mdVertical => vertical(md);
  static Widget get lgVertical => vertical(lg);
  static Widget get xlVertical => vertical(xl);
  static Widget get xxlVertical => vertical(xxl);
  static Widget get xsHorizontal => horizontal(xs);
  static Widget get smHorizontal => horizontal(sm);
  static Widget get mdHorizontal => horizontal(md);
  static Widget get lgHorizontal => horizontal(lg);
  static Widget get xlHorizontal => horizontal(xl);
  static Widget get xxlHorizontal => horizontal(xxl);
}
