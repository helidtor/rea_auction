// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/models/response/property_type_model.dart';

class AuctionModel {
  int? id;
  int? auctionStatus;
  String? name;
  String? title;
  String? biddingStartTime;
  String? biddingEndTime;
  double? revervePrice;
  double? finalPrice;
  int? propertyId;
  int? authorId;
  int? propertyTypeId;
  String? content;
  PropertyModel? property;
  List<String>? auctionImages;
  AuctionModel({
    this.id,
    this.auctionStatus,
    this.name,
    this.title,
    this.biddingStartTime,
    this.biddingEndTime,
    this.revervePrice,
    this.finalPrice,
    this.propertyId,
    this.authorId,
    this.propertyTypeId,
    this.content,
    this.property,
    this.auctionImages,
  });

  AuctionModel copyWith({
    int? id,
    int? auctionStatus,
    String? name,
    String? title,
    String? biddingStartTime,
    String? biddingEndTime,
    double? revervePrice,
    double? finalPrice,
    int? propertyId,
    int? authorId,
    int? propertyTypeId,
    String? content,
    PropertyModel? property,
    List<String>? auctionImages,
  }) {
    return AuctionModel(
      id: id ?? this.id,
      auctionStatus: auctionStatus ?? this.auctionStatus,
      name: name ?? this.name,
      title: title ?? this.title,
      biddingStartTime: biddingStartTime ?? this.biddingStartTime,
      biddingEndTime: biddingEndTime ?? this.biddingEndTime,
      revervePrice: revervePrice ?? this.revervePrice,
      finalPrice: finalPrice ?? this.finalPrice,
      propertyId: propertyId ?? this.propertyId,
      authorId: authorId ?? this.authorId,
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
      content: content ?? this.content,
      property: property ?? this.property,
      auctionImages: auctionImages ?? this.auctionImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'auctionStatus': auctionStatus,
      'name': name,
      'title': title,
      'biddingStartTime': biddingStartTime,
      'biddingEndTime': biddingEndTime,
      'revervePrice': revervePrice,
      'finalPrice': finalPrice,
      'propertyId': propertyId,
      'authorId': authorId,
      'propertyTypeId': propertyTypeId,
      'content': content,
      'property': property?.toMap(),
      'auctionImages': auctionImages,
    };
  }

  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      id: map['id'] != null ? map['id'] as int : null,
      auctionStatus:
          map['auctionStatus'] != null ? map['auctionStatus'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      biddingStartTime: map['biddingStartTime'] != null
          ? map['biddingStartTime'] as String
          : null,
      biddingEndTime: map['biddingEndTime'] != null
          ? map['biddingEndTime'] as String
          : null,
      revervePrice:
          map['revervePrice'] != null ? map['revervePrice'] as double : null,
      finalPrice:
          map['finalPrice'] != null ? map['finalPrice'] as double : null,
      propertyId: map['propertyId'] != null ? map['propertyId'] as int : null,
      authorId: map['authorId'] != null ? map['authorId'] as int : null,
      propertyTypeId:
          map['propertyTypeId'] != null ? map['propertyTypeId'] as int : null,
      content: map['content'] != null ? map['content'] as String : null,
      property: map['property'] != null
          ? PropertyModel.fromMap(map['property'] as Map<String, dynamic>)
          : null,
      auctionImages: map['auctionImages'] != null
          ? List<String>.from((map['auctionImages']))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuctionModel.fromJson(String source) =>
      AuctionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuctionModel(id: $id, auctionStatus: $auctionStatus, name: $name, title: $title, biddingStartTime: $biddingStartTime, biddingEndTime: $biddingEndTime, revervePrice: $revervePrice, finalPrice: $finalPrice, propertyId: $propertyId, authorId: $authorId, propertyTypeId: $propertyTypeId, content: $content, property: $property, auctionImages: $auctionImages)';
  }

  @override
  bool operator ==(covariant AuctionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.auctionStatus == auctionStatus &&
        other.name == name &&
        other.title == title &&
        other.biddingStartTime == biddingStartTime &&
        other.biddingEndTime == biddingEndTime &&
        other.revervePrice == revervePrice &&
        other.finalPrice == finalPrice &&
        other.propertyId == propertyId &&
        other.authorId == authorId &&
        other.propertyTypeId == propertyTypeId &&
        other.content == content &&
        other.property == property &&
        listEquals(other.auctionImages, auctionImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        auctionStatus.hashCode ^
        name.hashCode ^
        title.hashCode ^
        biddingStartTime.hashCode ^
        biddingEndTime.hashCode ^
        revervePrice.hashCode ^
        finalPrice.hashCode ^
        propertyId.hashCode ^
        authorId.hashCode ^
        propertyTypeId.hashCode ^
        content.hashCode ^
        property.hashCode ^
        auctionImages.hashCode;
  }
}
