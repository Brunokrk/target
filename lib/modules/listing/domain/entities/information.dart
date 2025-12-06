import 'package:flutter/material.dart';

class Information {
  final String id;
  final String text;
  final IconData icon;
  final DateTime createdAt;

  const Information({
    required this.id,
    required this.text,
    required this.icon,
    required this.createdAt,
  });

  Information copyWith({
    String? id,
    String? text,
    IconData? icon,
    DateTime? createdAt,
  }) {
    return Information(
      id: id ?? this.id,
      text: text ?? this.text,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

