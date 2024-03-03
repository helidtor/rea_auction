// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PropertyType {
  int? id;
  DateTime? createdAt;
  DateTime? modifiedAt;
  DateTime? deletedAt;
  PropertyType({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
  });

  PropertyType copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    DateTime? deletedAt,
  }) {
    return PropertyType(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'modifiedAt': modifiedAt?.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
  }

  factory PropertyType.fromMap(Map<String, dynamic> map) {
    return PropertyType(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      modifiedAt: map['modifiedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['modifiedAt'] as int)
          : null,
      deletedAt: map['deletedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyType.fromJson(String source) =>
      PropertyType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PropertyType(id: $id, createdAt: $createdAt, modifiedAt: $modifiedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant PropertyType other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode ^
        deletedAt.hashCode;
  }

  String? name;
}
