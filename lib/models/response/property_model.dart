// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:swp_project_web/models/response/form_model.dart';

class PropertyModel {
  int? id;
  String? name;
  List<String>? images;
  String? street;
  String? ward;
  String? district;
  String? city;
  double? area;
  double? revervePrice;
  int? postId;
  FormsModel? post;
  PropertyModel({
    this.id,
    this.name,
    this.images,
    this.street,
    this.ward,
    this.district,
    this.city,
    this.area,
    this.revervePrice,
    this.postId,
    this.post,
  });

  PropertyModel copyWith({
    int? id,
    String? name,
    List<String>? images,
    String? street,
    String? ward,
    String? district,
    String? city,
    double? area,
    double? revervePrice,
    int? postId,
    FormsModel? post,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      street: street ?? this.street,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      city: city ?? this.city,
      area: area ?? this.area,
      revervePrice: revervePrice ?? this.revervePrice,
      postId: postId ?? this.postId,
      post: post ?? this.post,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'images': images,
      'street': street,
      'ward': ward,
      'district': district,
      'city': city,
      'area': area,
      'revervePrice': revervePrice,
      'postId': postId,
      'post': post?.toMap(),
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      images: map['images'] != null ? List<String>.from((map['images'])) : null,
      street: map['street'] != null ? map['street'] as String : null,
      ward: map['ward'] != null ? map['ward'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      area: map['area'] != null ? map['area'] as double : null,
      revervePrice:
          map['revervePrice'] != null ? map['revervePrice'] as double : null,
      postId: map['postId'] != null ? map['postId'] as int : null,
      post: map['post'] != null
          ? FormsModel.fromMap(map['post'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyModel.fromJson(String source) =>
      PropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PropertyModel(id: $id, name: $name, images: $images, street: $street, ward: $ward, district: $district, city: $city, area: $area, revervePrice: $revervePrice, postId: $postId, post: $post)';
  }

  @override
  bool operator ==(covariant PropertyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.images, images) &&
        other.street == street &&
        other.ward == ward &&
        other.district == district &&
        other.city == city &&
        other.area == area &&
        other.revervePrice == revervePrice &&
        other.postId == postId &&
        other.post == post;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        images.hashCode ^
        street.hashCode ^
        ward.hashCode ^
        district.hashCode ^
        city.hashCode ^
        area.hashCode ^
        revervePrice.hashCode ^
        postId.hashCode ^
        post.hashCode;
  }
}
