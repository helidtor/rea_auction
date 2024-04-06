// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FormDoneModel {
  String? title;
  String? content;
  List<String>? transferImages;
  List<String>? transactionImages;
  int? propertyId;
  String? reason;
  int? tranferFormStatus;
  String? createdAt;
  FormDoneModel({
    this.title,
    this.content,
    this.transferImages,
    this.transactionImages,
    this.propertyId,
    this.reason,
    this.tranferFormStatus,
    this.createdAt,
  });

  FormDoneModel copyWith({
    String? title,
    String? content,
    List<String>? transferImages,
    List<String>? transactionImages,
    int? propertyId,
    String? reason,
    int? tranferFormStatus,
    String? createdAt,
  }) {
    return FormDoneModel(
      title: title ?? this.title,
      content: content ?? this.content,
      transferImages: transferImages ?? this.transferImages,
      transactionImages: transactionImages ?? this.transactionImages,
      propertyId: propertyId ?? this.propertyId,
      reason: reason ?? this.reason,
      tranferFormStatus: tranferFormStatus ?? this.tranferFormStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'transferImages': transferImages,
      'transactionImages': transactionImages,
      'propertyId': propertyId,
      'reason': reason,
      'tranferFormStatus': tranferFormStatus,
      'createdAt': createdAt,
    };
  }

  factory FormDoneModel.fromMap(Map<String, dynamic> map) {
    return FormDoneModel(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      transferImages: map['transferImages'] != null
          ? List<String>.from((map['transferImages']))
          : null,
      transactionImages: map['transactionImages'] != null
          ? List<String>.from((map['transactionImages']))
          : null,
      propertyId: map['propertyId'] != null ? map['propertyId'] as int : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
      tranferFormStatus: map['tranferFormStatus'] != null
          ? map['tranferFormStatus'] as int
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormDoneModel.fromJson(String source) =>
      FormDoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormDoneModel(title: $title, content: $content, transferImages: $transferImages, transactionImages: $transactionImages, propertyId: $propertyId, reason: $reason, tranferFormStatus: $tranferFormStatus, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant FormDoneModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        listEquals(other.transferImages, transferImages) &&
        listEquals(other.transactionImages, transactionImages) &&
        other.propertyId == propertyId &&
        other.reason == reason &&
        other.tranferFormStatus == tranferFormStatus &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        transferImages.hashCode ^
        transactionImages.hashCode ^
        propertyId.hashCode ^
        reason.hashCode ^
        tranferFormStatus.hashCode ^
        createdAt.hashCode;
  }
}
