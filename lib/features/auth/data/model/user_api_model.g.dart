// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      userId: json['_id'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phonenumber: json['phonenumber'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'phonenumber': instance.phonenumber,
      'password': instance.password,
    };
