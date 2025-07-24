



// import 'package:fashora_app/app/service_locator/service_locator.dart';
// import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
// import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
// import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';
// import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
// import 'package:fashora_app/theme/themedata.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<RegisterViewModel>.value(
//           value: serviceLocator<RegisterViewModel>(),
//         ),
//         BlocProvider<LoginViewModel>.value(
//           value: serviceLocator<LoginViewModel>(),
//         ),
//         BlocProvider<ProductViewModel>(
//           create: (_) => serviceLocator<ProductViewModel>(),
//         ),
//          BlocProvider<FavoriteViewModel>(
//           create: (_) => serviceLocator<FavoriteViewModel>(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: getApplicationTheme(),
//         home: RegisterView(), // Or LoginPage or FashoraHomeScreen
//       ),
//     );
//   }
// }


import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:fashora_app/features/favorite/presentation/view_model/cart_view_model.dart';
import 'package:fashora_app/features/order/presentation/view_model/order_viewmodel.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_viewmodel.dart';
import 'package:fashora_app/features/splash/presentation/view/splashscreen.dart';
import 'package:fashora_app/theme/themedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
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
        BlocProvider<ProductViewModel>(
          create: (_) => serviceLocator<ProductViewModel>(),
        ),
      BlocProvider<FavoriteBloc>(
  create: (_) => serviceLocator<FavoriteBloc>(),
),


        // Add CartBloc here
        BlocProvider<CartBloc>(
          create: (_) => serviceLocator<CartBloc>(),
        ),


            BlocProvider<CartBlocFavorite>(
      create: (_) => serviceLocator<CartBlocFavorite>(),
    ),


       BlocProvider<OrderBloc>( // ✅ Order Bloc
          create: (_) => serviceLocator<OrderBloc>(),
        ),


            // Add ProfileBloc here
        BlocProvider<ProfileBloc>(
          create: (_) => serviceLocator<ProfileBloc>(),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        home: SplashScreen(), 
        // Or your starting screen
      ),
    );
  }
}
