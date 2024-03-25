// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Top3Model {
  int? id;
  int? userId;
  Top3Model({
    this.id,
    this.userId,
  });

  Top3Model copyWith({
    int? id,
    int? userId,
  }) {
    return Top3Model(
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
    };
  }

  factory Top3Model.fromMap(Map<String, dynamic> map) {
    return Top3Model(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Top3Model.fromJson(String source) => Top3Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Top3Model(id: $id, userId: $userId)';

  @override
  bool operator ==(covariant Top3Model other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode;
}
