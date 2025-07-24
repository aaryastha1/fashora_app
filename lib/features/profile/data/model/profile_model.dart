import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    String? userId,
    required String name,
    required String email,
    required String phoneNumber,
    String? profileImageUrl,
    String? address,
  }) : super(
          userId: userId,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          profileImageUrl: profileImageUrl,
          address: address,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      if (profileImageUrl != null) "profileImageUrl": profileImageUrl,
      if (address != null) "address": address,
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      profileImageUrl: entity.profileImageUrl,
      address: entity.address,
    );
  }
}
