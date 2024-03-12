// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FormAuction {
  String? name;
  String? biddingStartTime;
  String? biddingEndTime;
  double? revervePrice;
  int? propertyId;
  String? content;
  String? title;
  List<String>? auctionImages;
  FormAuction({
    this.name,
    this.biddingStartTime,
    this.biddingEndTime,
    this.revervePrice,
    this.propertyId,
    this.content,
    this.title,
    this.auctionImages,
  });

  FormAuction copyWith({
    String? name,
    String? biddingStartTime,
    String? biddingEndTime,
    double? revervePrice,
    int? propertyId,
    String? content,
    String? title,
    List<String>? auctionImages,
  }) {
    return FormAuction(
      name: name ?? this.name,
      biddingStartTime: biddingStartTime ?? this.biddingStartTime,
      biddingEndTime: biddingEndTime ?? this.biddingEndTime,
      revervePrice: revervePrice ?? this.revervePrice,
      propertyId: propertyId ?? this.propertyId,
      content: content ?? this.content,
      title: title ?? this.title,
      auctionImages: auctionImages ?? this.auctionImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'biddingStartTime': biddingStartTime,
      'biddingEndTime': biddingEndTime,
      'revervePrice': revervePrice,
      'propertyId': propertyId,
      'content': content,
      'title': title,
      'auctionImages': auctionImages,
    };
  }

  factory FormAuction.fromMap(Map<String, dynamic> map) {
    return FormAuction(
      name: map['name'] != null ? map['name'] as String : null,
      biddingStartTime: map['biddingStartTime'] != null
          ? map['biddingStartTime'] as String
          : null,
      biddingEndTime: map['biddingEndTime'] != null
          ? map['biddingEndTime'] as String
          : null,
      revervePrice:
          map['revervePrice'] != null ? map['revervePrice'] as double : null,
      propertyId: map['propertyId'] != null ? map['propertyId'] as int : null,
      content: map['content'] != null ? map['content'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      auctionImages: map['auctionImages'] != null
          ? List<String>.from((map['auctionImages']))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormAuction.fromJson(String source) =>
      FormAuction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormAuction(name: $name, biddingStartTime: $biddingStartTime, biddingEndTime: $biddingEndTime, revervePrice: $revervePrice, propertyId: $propertyId, content: $content, title: $title, auctionImages: $auctionImages)';
  }

  @override
  bool operator ==(covariant FormAuction other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.biddingStartTime == biddingStartTime &&
        other.biddingEndTime == biddingEndTime &&
        other.revervePrice == revervePrice &&
        other.propertyId == propertyId &&
        other.content == content &&
        other.title == title &&
        listEquals(other.auctionImages, auctionImages);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        biddingStartTime.hashCode ^
        biddingEndTime.hashCode ^
        revervePrice.hashCode ^
        propertyId.hashCode ^
        content.hashCode ^
        title.hashCode ^
        auctionImages.hashCode;
  }
}
