// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? address;
  String? avatarUrl;
  int? role;
  String? phoneNumber;
  String? dateOfBirth;
  bool? isActive;
  String? identifyId;
  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.email,
    this.address,
    this.avatarUrl,
    this.role,
    this.phoneNumber,
    this.dateOfBirth,
    this.isActive,
    this.identifyId,
  });

  UserProfileModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? password,
    String? email,
    String? address,
    String? avatarUrl,
    int? role,
    String? phoneNumber,
    String? dateOfBirth,
    bool? isActive,
    String? identifyId,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isActive: isActive ?? this.isActive,
      identifyId: identifyId ?? this.identifyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'email': email,
      'address': address,
      'avatarUrl': avatarUrl,
      'role': role,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'isActive': isActive,
      'identifyId': identifyId,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      dateOfBirth: map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      identifyId: map['identifyId'] != null ? map['identifyId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) => UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, password: $password, email: $email, address: $address, avatarUrl: $avatarUrl, role: $role, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, isActive: $isActive, identifyId: $identifyId)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.username == username &&
      other.password == password &&
      other.email == email &&
      other.address == address &&
      other.avatarUrl == avatarUrl &&
      other.role == role &&
      other.phoneNumber == phoneNumber &&
      other.dateOfBirth == dateOfBirth &&
      other.isActive == isActive &&
      other.identifyId == identifyId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      username.hashCode ^
      password.hashCode ^
      email.hashCode ^
      address.hashCode ^
      avatarUrl.hashCode ^
      role.hashCode ^
      phoneNumber.hashCode ^
      dateOfBirth.hashCode ^
      isActive.hashCode ^
      identifyId.hashCode;
  }
}
