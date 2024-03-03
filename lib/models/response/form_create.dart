// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore: unused_import
import 'package:swp_project_web/models/response/property_type.dart';

class FormModel {
  String? title;
  String? content;
  String? propertyName;
  String? propertyStreet;
  String? propertyWard;
  String? propertyDistrict;
  String? propertyCity;
  double? propertyArea;
  double? propertyRevervePrice;
  List<String>? propertyImages;
  int? propertyTypeId;
  FormModel({
    this.title,
    this.content,
    this.propertyName,
    this.propertyStreet,
    this.propertyWard,
    this.propertyDistrict,
    this.propertyCity,
    this.propertyArea,
    this.propertyRevervePrice,
    this.propertyImages,
    this.propertyTypeId,
  });

  FormModel copyWith({
    String? title,
    String? content,
    String? propertyName,
    String? propertyStreet,
    String? propertyWard,
    String? propertyDistrict,
    String? propertyCity,
    double? propertyArea,
    double? propertyRevervePrice,
    List<String>? propertyImages,
    int? propertyTypeId,
  }) {
    return FormModel(
      title: title ?? this.title,
      content: content ?? this.content,
      propertyName: propertyName ?? this.propertyName,
      propertyStreet: propertyStreet ?? this.propertyStreet,
      propertyWard: propertyWard ?? this.propertyWard,
      propertyDistrict: propertyDistrict ?? this.propertyDistrict,
      propertyCity: propertyCity ?? this.propertyCity,
      propertyArea: propertyArea ?? this.propertyArea,
      propertyRevervePrice: propertyRevervePrice ?? this.propertyRevervePrice,
      propertyImages: propertyImages ?? this.propertyImages,
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'propertyName': propertyName,
      'propertyStreet': propertyStreet,
      'propertyWard': propertyWard,
      'propertyDistrict': propertyDistrict,
      'propertyCity': propertyCity,
      'propertyArea': propertyArea,
      'propertyRevervePrice': propertyRevervePrice,
      'propertyImages': propertyImages,
      'propertyTypeId': propertyTypeId,
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
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
      propertyImages: map['propertyImages'] != null
          ? List<String>.from((map['propertyImages'] as List<String>))
          : null,
      propertyTypeId:
          map['propertyTypeId'] != null ? map['propertyTypeId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormModel(title: $title, content: $content, propertyName: $propertyName, propertyStreet: $propertyStreet, propertyWard: $propertyWard, propertyDistrict: $propertyDistrict, propertyCity: $propertyCity, propertyArea: $propertyArea, propertyRevervePrice: $propertyRevervePrice, propertyImages: $propertyImages, propertyTypeId: $propertyTypeId)';
  }

  @override
  bool operator ==(covariant FormModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.propertyName == propertyName &&
        other.propertyStreet == propertyStreet &&
        other.propertyWard == propertyWard &&
        other.propertyDistrict == propertyDistrict &&
        other.propertyCity == propertyCity &&
        other.propertyArea == propertyArea &&
        other.propertyRevervePrice == propertyRevervePrice &&
        listEquals(other.propertyImages, propertyImages) &&
        other.propertyTypeId == propertyTypeId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        propertyName.hashCode ^
        propertyStreet.hashCode ^
        propertyWard.hashCode ^
        propertyDistrict.hashCode ^
        propertyCity.hashCode ^
        propertyArea.hashCode ^
        propertyRevervePrice.hashCode ^
        propertyImages.hashCode ^
        propertyTypeId.hashCode;
  }
}
