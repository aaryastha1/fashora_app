import 'package:flutter/material.dart';

@immutable
sealed class RegisterEvent {}


class RegisterUserEvent extends RegisterEvent{
  final BuildContext context;
  final String fullName;
  final String email;
  final String phonenumber;
  final String password;


  RegisterUserEvent({
    required this.context,
    required this.fullName,
    required this.email,
    required this.phonenumber,
    required this.password,
    
  });

}




