import 'package:equatable/equatable.dart';
import 'package:fashora_app/app/constant/hive_table_constant.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';
@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phonenumber;
  @HiveField(4)
  final String password;


  UserHiveModel({
    String? userId,
    required this.fullName,
    required this.email,
    required this.phonenumber,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  const UserHiveModel.intial()
  : userId = '',
  fullName = '',
  email = '',
  phonenumber = '',
  password = '';

  factory UserHiveModel.fromEntity(UserEntity entity){
    return UserHiveModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      phonenumber: entity.phonenumber,
      password: entity.password,

    );
  }

  UserEntity toEntity(){
    return UserEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      phonenumber: phonenumber,
      password:  password,

    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [

    userId,
    fullName,
    email,
    phonenumber,
    password

  ] ;
}