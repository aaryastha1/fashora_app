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
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final String password;


  UserHiveModel({
    String? userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  const UserHiveModel.intial()
  : userId = '',
  name = '',
  email = '',
  phoneNumber = '',
  password = '';

  factory UserHiveModel.fromEntity(UserEntity entity){
    return UserHiveModel(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      password: entity.password,

    );
  }

  UserEntity toEntity(){
    return UserEntity(
      userId: userId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password:  password,

    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [

    userId,
    name,
    email,
    phoneNumber,
    password

  ] ;
}