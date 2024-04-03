// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:swp_project_web/models/response/user_profile_model.dart';

class AuctionHistory {
  double? biddingAmount;
  UserProfileModel? user;
  String? createdAt;
  AuctionHistory({
    this.biddingAmount,
    this.user,
    this.createdAt,
  });

  AuctionHistory copyWith({
    double? biddingAmount,
    UserProfileModel? user,
    String? createdAt,
  }) {
    return AuctionHistory(
      biddingAmount: biddingAmount ?? this.biddingAmount,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'biddingAmount': biddingAmount,
      'user': user?.toMap(),
      'createdAt': createdAt,
    };
  }

  factory AuctionHistory.fromMap(Map<String, dynamic> map) {
    return AuctionHistory(
      biddingAmount: map['biddingAmount'] != null ? map['biddingAmount'] as double : null,
      user: map['user'] != null ? UserProfileModel.fromMap(map['user'] as Map<String,dynamic>) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuctionHistory.fromJson(String source) => AuctionHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuctionHistory(biddingAmount: $biddingAmount, user: $user, createdAt: $createdAt)';

  @override
  bool operator ==(covariant AuctionHistory other) {
    if (identical(this, other)) return true;
  
    return 
      other.biddingAmount == biddingAmount &&
      other.user == user &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode => biddingAmount.hashCode ^ user.hashCode ^ createdAt.hashCode;
}
