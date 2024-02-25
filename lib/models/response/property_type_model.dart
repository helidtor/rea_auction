// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PropertyTypeModel {
  int? id;
  String? name;
  PropertyTypeModel({
    this.id,
    this.name,
  });

  PropertyTypeModel copyWith({
    int? id,
    String? name,
  }) {
    return PropertyTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PropertyTypeModel.fromMap(Map<String, dynamic> map) {
    return PropertyTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyTypeModel.fromJson(String source) =>
      PropertyTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PropertyTypeModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant PropertyTypeModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
