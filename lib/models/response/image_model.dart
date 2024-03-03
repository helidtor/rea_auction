// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageModel {
  String? url;
  ImageModel({
    this.url,
  });
  

  ImageModel copyWith({
    String? url,
  }) {
    return ImageModel(
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageModel(url: $url)';

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
