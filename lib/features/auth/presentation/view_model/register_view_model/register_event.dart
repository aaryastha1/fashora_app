import 'package:flutter/material.dart';

@immutable
sealed class RegisterEvent {}


class RegisterUserEvent extends RegisterEvent{
  final BuildContext context;
  final String name;
  final String email;
  final String phoneNumber;
  final String password;


  RegisterUserEvent({
    required this.context,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    
  });

}




