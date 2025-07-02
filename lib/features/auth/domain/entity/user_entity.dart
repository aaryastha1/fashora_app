
import 'package:equatable/equatable.dart';

class UserEntity  extends Equatable{
  final String? userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
 


  const UserEntity ({
    this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
  
  @override

  List<Object?> get props => [
    userId,
    name,
    email,
    phoneNumber,
    password
  ];
}