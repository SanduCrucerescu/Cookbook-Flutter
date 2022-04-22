import 'dart:convert';

class Tag {
  final int id;
  final String name;

  Tag({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  @override
  String toString() {
    return 'id: ' + id.toString() + 'name: ' + name;
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));
}
