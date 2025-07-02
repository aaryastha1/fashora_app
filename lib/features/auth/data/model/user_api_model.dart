import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';



part 'user_api_model.g.dart';


@JsonSerializable()
class UserApiModel  extends Equatable{
  @JsonKey(name: '_id')
  final String? userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? password;


  const UserApiModel({
    this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.password,

  });


   factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);


  factory UserApiModel.fromEntity(UserEntity entity){
    return UserApiModel(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      password: entity.password,

    );
  }

  UserEntity toEntity () {
    return UserEntity(
      userId: userId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password ?? '',
    );
  }

  @override
 
  List<Object?> get props => [
    userId,
    name,
    email,
    phoneNumber,
    password,
    
  ];

}