// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FormDoneModel {
  String? title;
  String? content;
  List<String>? transferImages;
  int? propertyId;
  FormDoneModel({
    this.title,
    this.content,
    this.transferImages,
    this.propertyId,
  });

  FormDoneModel copyWith({
    String? title,
    String? content,
    List<String>? transferImages,
    int? propertyId,
  }) {
    return FormDoneModel(
      title: title ?? this.title,
      content: content ?? this.content,
      transferImages: transferImages ?? this.transferImages,
      propertyId: propertyId ?? this.propertyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'transferImages': transferImages,
      'propertyId': propertyId,
    };
  }

  factory FormDoneModel.fromMap(Map<String, dynamic> map) {
    return FormDoneModel(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      transferImages: map['transferImages'] != null
          ? List<String>.from((map['transferImages']))
          : null,
      propertyId: map['propertyId'] != null ? map['propertyId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormDoneModel.fromJson(String source) =>
      FormDoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormDoneModel(title: $title, content: $content, transferImages: $transferImages, propertyId: $propertyId)';
  }

  @override
  bool operator ==(covariant FormDoneModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        listEquals(other.transferImages, transferImages) &&
        other.propertyId == propertyId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        transferImages.hashCode ^
        propertyId.hashCode;
  }
}
