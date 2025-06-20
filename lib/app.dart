import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:fashora_app/theme/themedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
   Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterViewModel>.value(
          value: serviceLocator<RegisterViewModel>(),
        ),
        BlocProvider<LoginViewModel>.value(
          value: serviceLocator<LoginViewModel>(),
        ),
      ],
      child: MaterialApp(
       
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        home: RegisterView(), // or your LoginPage
      ),
    );
  }
}