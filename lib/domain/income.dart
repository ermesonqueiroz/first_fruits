import 'dart:convert';

import 'package:intl/intl.dart';

class Income {
  final int? id;
  final double value;
  final String description;
  final DateTime? createdAt;

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  Income({
    this.id,
    required this.value,
    required this.description,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'description': description,
      'created_at': createdAt != null ? _formatter.format(createdAt!) : null,
    };
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id']?.toInt() ?? Null,
      value: map['value'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at']!)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Income.fromJson(String source) => Income.fromMap(json.decode(source));

  @override
  String toString() => 'Income(value: $value, description: $description)';
}
