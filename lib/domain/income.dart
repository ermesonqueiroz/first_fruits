import 'dart:convert';

class Income {
  final int? id;
  final double value;
  final String description;

  Income({this.id, required this.value, required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'value': value, 'description': description};
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id']?.toInt() ?? Null,
      value: map['value'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Income.fromJson(String source) => Income.fromMap(json.decode(source));

  @override
  String toString() => 'Breed(value: $value, description: $description)';
}
