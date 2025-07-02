import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';



part 'user_api_model.g.dart';


@JsonSerializable()
class UserApiModel  extends Equatable{
  @JsonKey(name: '_id')
  final String? userId;
  final String fullName;
  final String email;
  final String phonenumber;
  final String? password;


  const UserApiModel({
    this.userId,
    required this.fullName,
    required this.email,
    required this.phonenumber,
    this.password,

  });


   factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);


  factory UserApiModel.fromEntity(UserEntity entity){
    return UserApiModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      phonenumber: entity.phonenumber,
      password: entity.password,

    );
  }

  UserEntity toEntity () {
    return UserEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      phonenumber: phonenumber,
      password: password ?? '',
    );
  }

  @override
 
  List<Object?> get props => [
    userId,
    fullName,
    email,
    phonenumber,
    password,
    
  ];

}