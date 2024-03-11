// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/models/response/property_type_model.dart';

class AuctionModel {
  int? id;
  int? auctionStatus;
  String? name;
  String? biddingStartTime;
  String? biddingEndTime;
  double? revervePrice;
  double? finalPrice;
  int? propertyId;
  int? authorId;
  int? propertyTypeId;
  PropertyModel? propertyModel;
  List<String>? auctionImages;
  AuctionModel({
    this.id,
    this.auctionStatus,
    this.name,
    this.biddingStartTime,
    this.biddingEndTime,
    this.revervePrice,
    this.finalPrice,
    this.propertyId,
    this.authorId,
    this.propertyTypeId,
    this.propertyModel,
    this.auctionImages,
  });

  AuctionModel copyWith({
    int? id,
    int? auctionStatus,
    String? name,
    String? biddingStartTime,
    String? biddingEndTime,
    double? revervePrice,
    double? finalPrice,
    int? propertyId,
    int? authorId,
    int? propertyTypeId,
    PropertyModel? propertyModel,
    List<String>? auctionImages,
  }) {
    return AuctionModel(
      id: id ?? this.id,
      auctionStatus: auctionStatus ?? this.auctionStatus,
      name: name ?? this.name,
      biddingStartTime: biddingStartTime ?? this.biddingStartTime,
      biddingEndTime: biddingEndTime ?? this.biddingEndTime,
      revervePrice: revervePrice ?? this.revervePrice,
      finalPrice: finalPrice ?? this.finalPrice,
      propertyId: propertyId ?? this.propertyId,
      authorId: authorId ?? this.authorId,
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
      propertyModel: propertyModel ?? this.propertyModel,
      auctionImages: auctionImages ?? this.auctionImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'auctionStatus': auctionStatus,
      'name': name,
      'biddingStartTime': biddingStartTime,
      'biddingEndTime': biddingEndTime,
      'revervePrice': revervePrice,
      'finalPrice': finalPrice,
      'propertyId': propertyId,
      'authorId': authorId,
      'propertyTypeId': propertyTypeId,
      'propertyModel': propertyModel?.toMap(),
      'auctionImages': auctionImages,
    };
  }

  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      id: map['id'] != null ? map['id'] as int : null,
      auctionStatus:
          map['auctionStatus'] != null ? map['auctionStatus'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
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
      propertyModel: map['propertyModel'] != null
          ? PropertyModel.fromMap(map['propertyModel'])
          : null,
      auctionImages: map['auctionImages'] != null
          ? List<String>.from((map['auctionImages']))
          : null,
    );
  }
  // factory AuctionModel.fromMap(Map<String, dynamic> map) {
  //   return AuctionModel(
  //     id: map['id'] != null ? map['id'] as int : null,
  //     auctionStatus:
  //         map['auctionStatus'] != null ? map['auctionStatus'] as int : null,
  //     name: map['name'] != null ? map['name'] as String : null,
  //     createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
  //     openTime: map['openTime'] != null ? map['openTime'] as String : null,
  //     modifiedAt:
  //         map['modifiedAt'] != null ? map['modifiedAt'] as String : null,
  //     deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
  //     endTime: map['endTime'] != null ? map['endTime'] as String : null,
  //     biddingStartTime: map['biddingStartTime'] != null
  //         ? map['biddingStartTime'] as String
  //         : null,
  //     biddingEndTime: map['biddingEndTime'] != null
  //         ? map['biddingEndTime'] as String
  //         : null,
  //     revervePrice:
  //         map['revervePrice'] != null ? map['revervePrice'] as double : null,
  //     joiningFee:
  //         map['joiningFee'] != null ? map['joiningFee'] as double : null,
  //     finalPrice:
  //         map['finalPrice'] != null ? map['finalPrice'] as double : null,
  //     stepFee: map['stepFee'] != null ? map['stepFee'] as double : null,
  //     deposit: map['deposit'] != null ? map['deposit'] as double : null,
  //     method: map['method'] != null ? map['method'] as String : null,
  //     propertyId: map['propertyId'] != null ? map['propertyId'] as int : null,
  //     authorId: map['authorId'] != null ? map['authorId'] as int : null,
  //     propertyTypeId:
  //         map['propertyTypeId'] != null ? map['propertyTypeId'] as int : null,
  //     propertyType: map['propertyType'] != null
  //         ? PropertyTypeModel.fromMap(
  //             map['propertyType'] as Map<String, dynamic>)
  //         : null,
  //     auctionImages: map['auctionImages'] != null
  //         ? List<String>.from((map['auctionImages']))
  //         : null,
  //   );
  // }
  String toJson() => json.encode(toMap());

  factory AuctionModel.fromJson(String source) =>
      AuctionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuctionModel(id: $id, auctionStatus: $auctionStatus, name: $name, biddingStartTime: $biddingStartTime, biddingEndTime: $biddingEndTime, revervePrice: $revervePrice, finalPrice: $finalPrice, propertyId: $propertyId, authorId: $authorId, propertyTypeId: $propertyTypeId, propertyModel: $propertyModel, auctionImages: $auctionImages)';
  }

  @override
  bool operator ==(covariant AuctionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.auctionStatus == auctionStatus &&
        other.name == name &&
        other.biddingStartTime == biddingStartTime &&
        other.biddingEndTime == biddingEndTime &&
        other.revervePrice == revervePrice &&
        other.finalPrice == finalPrice &&
        other.propertyId == propertyId &&
        other.authorId == authorId &&
        other.propertyTypeId == propertyTypeId &&
        other.propertyModel == propertyModel &&
        listEquals(other.auctionImages, auctionImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        auctionStatus.hashCode ^
        name.hashCode ^
        biddingStartTime.hashCode ^
        biddingEndTime.hashCode ^
        revervePrice.hashCode ^
        finalPrice.hashCode ^
        propertyId.hashCode ^
        authorId.hashCode ^
        propertyTypeId.hashCode ^
        propertyModel.hashCode ^
        auctionImages.hashCode;
  }
}
