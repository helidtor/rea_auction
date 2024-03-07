// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:swp_project_web/models/response/property_type_model.dart';

class AuctionModel {
  int? id;
  int? auctionStatus;
  String? name;
  String? createdAt;
  String? openTime;
  String? modifiedAt;
  String? deletedAt;
  String? endTime;
  String? biddingStartTime;
  String? biddingEndTime;
  double? revervePrice;
  double? joiningFee;
  double? finalPrice;
  double? stepFee;
  double? deposit;
  String? method;
  int? propertyId;
  int? authorId;
  int? propertyTypeId;
  PropertyTypeModel? propertyType;
  List<String>? auctionImages;
  AuctionModel({
    this.id,
    this.auctionStatus,
    this.name,
    this.createdAt,
    this.openTime,
    this.modifiedAt,
    this.deletedAt,
    this.endTime,
    this.biddingStartTime,
    this.biddingEndTime,
    this.revervePrice,
    this.joiningFee,
    this.finalPrice,
    this.stepFee,
    this.deposit,
    this.method,
    this.propertyId,
    this.authorId,
    this.propertyTypeId,
    this.propertyType,
    this.auctionImages,
  });

  AuctionModel copyWith({
    int? id,
    int? auctionStatus,
    String? name,
    String? createdAt,
    String? openTime,
    String? modifiedAt,
    String? deletedAt,
    String? endTime,
    String? biddingStartTime,
    String? biddingEndTime,
    double? revervePrice,
    double? joiningFee,
    double? finalPrice,
    double? stepFee,
    double? deposit,
    String? method,
    int? propertyId,
    int? authorId,
    int? propertyTypeId,
    PropertyTypeModel? propertyType,
    List<String>? auctionImages,
  }) {
    return AuctionModel(
      id: id ?? this.id,
      auctionStatus: auctionStatus ?? this.auctionStatus,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      openTime: openTime ?? this.openTime,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      endTime: endTime ?? this.endTime,
      biddingStartTime: biddingStartTime ?? this.biddingStartTime,
      biddingEndTime: biddingEndTime ?? this.biddingEndTime,
      revervePrice: revervePrice ?? this.revervePrice,
      joiningFee: joiningFee ?? this.joiningFee,
      finalPrice: finalPrice ?? this.finalPrice,
      stepFee: stepFee ?? this.stepFee,
      deposit: deposit ?? this.deposit,
      method: method ?? this.method,
      propertyId: propertyId ?? this.propertyId,
      authorId: authorId ?? this.authorId,
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
      propertyType: propertyType ?? this.propertyType,
      auctionImages: auctionImages ?? this.auctionImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'auctionStatus': auctionStatus,
      'name': name,
      'createdAt': createdAt,
      'openTime': openTime,
      'modifiedAt': modifiedAt,
      'deletedAt': deletedAt,
      'endTime': endTime,
      'biddingStartTime': biddingStartTime,
      'biddingEndTime': biddingEndTime,
      'revervePrice': revervePrice,
      'joiningFee': joiningFee,
      'finalPrice': finalPrice,
      'stepFee': stepFee,
      'deposit': deposit,
      'method': method,
      'propertyId': propertyId,
      'authorId': authorId,
      'propertyTypeId': propertyTypeId,
      'propertyType': propertyType?.toMap(),
      'auctionImages': auctionImages,
    };
  }

  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      id: map['id'] != null ? map['id'] as int : null,
      auctionStatus:
          map['auctionStatus'] != null ? map['auctionStatus'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      openTime: map['openTime'] != null ? map['openTime'] as String : null,
      modifiedAt:
          map['modifiedAt'] != null ? map['modifiedAt'] as String : null,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      biddingStartTime: map['biddingStartTime'] != null
          ? map['biddingStartTime'] as String
          : null,
      biddingEndTime: map['biddingEndTime'] != null
          ? map['biddingEndTime'] as String
          : null,
      revervePrice:
          map['revervePrice'] != null ? map['revervePrice'] as double : null,
      joiningFee:
          map['joiningFee'] != null ? map['joiningFee'] as double : null,
      finalPrice:
          map['finalPrice'] != null ? map['finalPrice'] as double : null,
      stepFee: map['stepFee'] != null ? map['stepFee'] as double : null,
      deposit: map['deposit'] != null ? map['deposit'] as double : null,
      method: map['method'] != null ? map['method'] as String : null,
      propertyId: map['propertyId'] != null ? map['propertyId'] as int : null,
      authorId: map['authorId'] != null ? map['authorId'] as int : null,
      propertyTypeId:
          map['propertyTypeId'] != null ? map['propertyTypeId'] as int : null,
      propertyType: map['propertyType'] != null
          ? PropertyTypeModel.fromMap(
              map['propertyType'] as Map<String, dynamic>)
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
    return 'AuctionModel(id: $id, auctionStatus: $auctionStatus, name: $name, createdAt: $createdAt, openTime: $openTime, modifiedAt: $modifiedAt, deletedAt: $deletedAt, endTime: $endTime, biddingStartTime: $biddingStartTime, biddingEndTime: $biddingEndTime, revervePrice: $revervePrice, joiningFee: $joiningFee, finalPrice: $finalPrice, stepFee: $stepFee, deposit: $deposit, method: $method, propertyId: $propertyId, authorId: $authorId, propertyTypeId: $propertyTypeId, propertyType: $propertyType, auctionImages: $auctionImages)';
  }

  @override
  bool operator ==(covariant AuctionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.auctionStatus == auctionStatus &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.openTime == openTime &&
        other.modifiedAt == modifiedAt &&
        other.deletedAt == deletedAt &&
        other.endTime == endTime &&
        other.biddingStartTime == biddingStartTime &&
        other.biddingEndTime == biddingEndTime &&
        other.revervePrice == revervePrice &&
        other.joiningFee == joiningFee &&
        other.finalPrice == finalPrice &&
        other.stepFee == stepFee &&
        other.deposit == deposit &&
        other.method == method &&
        other.propertyId == propertyId &&
        other.authorId == authorId &&
        other.propertyTypeId == propertyTypeId &&
        other.propertyType == propertyType &&
        listEquals(other.auctionImages, auctionImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        auctionStatus.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        openTime.hashCode ^
        modifiedAt.hashCode ^
        deletedAt.hashCode ^
        endTime.hashCode ^
        biddingStartTime.hashCode ^
        biddingEndTime.hashCode ^
        revervePrice.hashCode ^
        joiningFee.hashCode ^
        finalPrice.hashCode ^
        stepFee.hashCode ^
        deposit.hashCode ^
        method.hashCode ^
        propertyId.hashCode ^
        authorId.hashCode ^
        propertyTypeId.hashCode ^
        propertyType.hashCode ^
        auctionImages.hashCode;
  }
}
