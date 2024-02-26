// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:swp_project_web/models/response/property_type_model.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

class PostModel {
  int? id;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  String? title;
  String? content;
  String? reason;
  int? postStatus;
  String? propertyName;
  String? propertyStreet;
  String? propertyWard;
  String? propertyDistrict;
  String? propertyCity;
  double? propertyArea;
  double? propertyRevervePrice;
  int? authorId;
  UserProfileModel? author;
  int? approverId;
  UserProfileModel? approver;
  int? propertyTypeId;
  PropertyTypeModel? propertyType;
  List<String>? propertyImages;
  PostModel({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
    this.title,
    this.content,
    this.reason,
    this.postStatus,
    this.propertyName,
    this.propertyStreet,
    this.propertyWard,
    this.propertyDistrict,
    this.propertyCity,
    this.propertyArea,
    this.propertyRevervePrice,
    this.authorId,
    this.author,
    this.approverId,
    this.approver,
    this.propertyTypeId,
    this.propertyType,
    this.propertyImages,
  });

  PostModel copyWith({
    int? id,
    String? createdAt,
    String? modifiedAt,
    String? deletedAt,
    String? title,
    String? content,
    String? reason,
    int? postStatus,
    String? propertyName,
    String? propertyStreet,
    String? propertyWard,
    String? propertyDistrict,
    String? propertyCity,
    double? propertyArea,
    double? propertyRevervePrice,
    int? authorId,
    UserProfileModel? author,
    int? approverId,
    UserProfileModel? approver,
    int? propertyTypeId,
    PropertyTypeModel? propertyType,
    List<String>? propertyImages,
  }) {
    return PostModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      content: content ?? this.content,
      reason: reason ?? this.reason,
      postStatus: postStatus ?? this.postStatus,
      propertyName: propertyName ?? this.propertyName,
      propertyStreet: propertyStreet ?? this.propertyStreet,
      propertyWard: propertyWard ?? this.propertyWard,
      propertyDistrict: propertyDistrict ?? this.propertyDistrict,
      propertyCity: propertyCity ?? this.propertyCity,
      propertyArea: propertyArea ?? this.propertyArea,
      propertyRevervePrice: propertyRevervePrice ?? this.propertyRevervePrice,
      authorId: authorId ?? this.authorId,
      author: author ?? this.author,
      approverId: approverId ?? this.approverId,
      approver: approver ?? this.approver,
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
      propertyType: propertyType ?? this.propertyType,
      propertyImages: propertyImages ?? this.propertyImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'deletedAt': deletedAt,
      'title': title,
      'content': content,
      'reason': reason,
      'postStatus': postStatus,
      'propertyName': propertyName,
      'propertyStreet': propertyStreet,
      'propertyWard': propertyWard,
      'propertyDistrict': propertyDistrict,
      'propertyCity': propertyCity,
      'propertyArea': propertyArea,
      'propertyRevervePrice': propertyRevervePrice,
      'authorId': authorId,
      'author': author?.toMap(),
      'approverId': approverId,
      'approver': approver?.toMap(),
      'propertyTypeId': propertyTypeId,
      'propertyType': propertyType?.toMap(),
      'propertyImages': propertyImages,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      modifiedAt:
          map['modifiedAt'] != null ? map['modifiedAt'] as String : null,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
      postStatus: map['postStatus'] != null ? map['postStatus'] as int : null,
      propertyName:
          map['propertyName'] != null ? map['propertyName'] as String : null,
      propertyStreet: map['propertyStreet'] != null
          ? map['propertyStreet'] as String
          : null,
      propertyWard:
          map['propertyWard'] != null ? map['propertyWard'] as String : null,
      propertyDistrict: map['propertyDistrict'] != null
          ? map['propertyDistrict'] as String
          : null,
      propertyCity:
          map['propertyCity'] != null ? map['propertyCity'] as String : null,
      propertyArea:
          map['propertyArea'] != null ? map['propertyArea'] as double : null,
      propertyRevervePrice: map['propertyRevervePrice'] != null
          ? map['propertyRevervePrice'] as double
          : null,
      authorId: map['authorId'] != null ? map['authorId'] as int : null,
      author: map['author'] != null
          ? UserProfileModel.fromMap(map['author'] as Map<String, dynamic>)
          : null,
      approverId: map['approverId'] != null ? map['approverId'] as int : null,
      approver: map['approver'] != null
          ? UserProfileModel.fromMap(map['approver'] as Map<String, dynamic>)
          : null,
      propertyTypeId:
          map['propertyTypeId'] != null ? map['propertyTypeId'] as int : null,
      propertyType: map['propertyType'] != null
          ? PropertyTypeModel.fromMap(
              map['propertyType'] as Map<String, dynamic>)
          : null,
      propertyImages: map['propertyImages'] != null
          ? List<String>.from((map['propertyImages']))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, createdAt: $createdAt, modifiedAt: $modifiedAt, deletedAt: $deletedAt, title: $title, content: $content, reason: $reason, postStatus: $postStatus, propertyName: $propertyName, propertyStreet: $propertyStreet, propertyWard: $propertyWard, propertyDistrict: $propertyDistrict, propertyCity: $propertyCity, propertyArea: $propertyArea, propertyRevervePrice: $propertyRevervePrice, authorId: $authorId, author: $author, approverId: $approverId, approver: $approver, propertyTypeId: $propertyTypeId, propertyType: $propertyType, propertyImages: $propertyImages)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt &&
        other.deletedAt == deletedAt &&
        other.title == title &&
        other.content == content &&
        other.reason == reason &&
        other.postStatus == postStatus &&
        other.propertyName == propertyName &&
        other.propertyStreet == propertyStreet &&
        other.propertyWard == propertyWard &&
        other.propertyDistrict == propertyDistrict &&
        other.propertyCity == propertyCity &&
        other.propertyArea == propertyArea &&
        other.propertyRevervePrice == propertyRevervePrice &&
        other.authorId == authorId &&
        other.author == author &&
        other.approverId == approverId &&
        other.approver == approver &&
        other.propertyTypeId == propertyTypeId &&
        other.propertyType == propertyType &&
        listEquals(other.propertyImages, propertyImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode ^
        deletedAt.hashCode ^
        title.hashCode ^
        content.hashCode ^
        reason.hashCode ^
        postStatus.hashCode ^
        propertyName.hashCode ^
        propertyStreet.hashCode ^
        propertyWard.hashCode ^
        propertyDistrict.hashCode ^
        propertyCity.hashCode ^
        propertyArea.hashCode ^
        propertyRevervePrice.hashCode ^
        authorId.hashCode ^
        author.hashCode ^
        approverId.hashCode ^
        approver.hashCode ^
        propertyTypeId.hashCode ^
        propertyType.hashCode ^
        propertyImages.hashCode;
  }
}
