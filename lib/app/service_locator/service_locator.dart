


// import 'package:fashora_app/core/network/api_service.dart';
// import 'package:get_it/get_it.dart';
// import 'package:dio/dio.dart';


// import 'package:fashora_app/core/network/hive_service.dart';

// import 'package:fashora_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
// import 'package:fashora_app/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';

// import 'package:fashora_app/features/auth/data/repository/local_repository/user_local_repository.dart';
// import 'package:fashora_app/features/auth/data/repository/remote_repository/user_remote_repository.dart';

// import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:fashora_app/features/auth/domain/use_case/user_register_usecase.dart';

// import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

// final serviceLocator = GetIt.instance;

// Future<void> initDependencies() async {
 
//   serviceLocator.registerLazySingleton<Dio>(() => Dio());


//   serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

 
//   await serviceLocator<HiveService>().init();


//   serviceLocator.registerLazySingleton<ApiService>(
//     () => ApiService(serviceLocator<Dio>()),
//   );


//   await _initAuthModule();
// }

// Future<void> _initAuthModule() async {

//   serviceLocator.registerFactory(
//     () => UserLocalDatasource(hiveService: serviceLocator<HiveService>()),
//   );

//   serviceLocator.registerFactory(
//     () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
//   );


//   serviceLocator.registerFactory(
//     () => UserLocalRepository(
//       userLocalDatasource: serviceLocator<UserLocalDatasource>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () => UserRemoteRepository(
//       userRemoteDataSource: serviceLocator<UserRemoteDatasource>(),
//     ),
//   );


//   serviceLocator.registerFactory(
//     () => UserRegisterUsecase(
//       userReposiotry: serviceLocator<UserRemoteRepository>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () => UserLoginUsecase(
//       userRepository: serviceLocator<UserRemoteRepository>(),
//     ),
//   );

  
//   serviceLocator.registerLazySingleton(
//     () => RegisterViewModel(
//       registerUsecase: serviceLocator<UserRegisterUsecase>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () => LoginViewModel(
//       serviceLocator<UserLoginUsecase>(),
//     ),
//   );
// }
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:fashora_app/core/network/api_service.dart';
import 'package:fashora_app/core/network/hive_service.dart';

import 'package:fashora_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:fashora_app/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';

import 'package:fashora_app/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:fashora_app/features/auth/data/repository/remote_repository/user_remote_repository.dart';

import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_register_usecase.dart';

import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

import 'package:fashora_app/features/product/data/data_sorce/product_data_source.dart';
import 'package:fashora_app/features/product/data/data_sorce/remote_datasource/product_remote_datasource.dart';
import 'package:fashora_app/features/product/data/repository/remote_repository/product_remote_repository.dart';
import 'package:fashora_app/features/product/domain/repository/product_repository.dart' hide ProductRemoteRepository;
import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_event.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  serviceLocator.registerLazySingleton<Dio>(() => Dio());

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
  await serviceLocator<HiveService>().init();

  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );

  // Auth Module
  await _initAuthModule();

  // Product Module
  await _initProductModule();
}

Future<void> _initAuthModule() async {
  serviceLocator.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<UserLocalRepository>(
    () => UserLocalRepository(userLocalDatasource: serviceLocator<UserLocalDatasource>()),
  );

  serviceLocator.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(userRemoteDataSource: serviceLocator<UserRemoteDatasource>()),
  );

  serviceLocator.registerLazySingleton<UserRegisterUsecase>(
    () => UserRegisterUsecase(
      userReposiotry: serviceLocator<UserRemoteRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<UserLoginUsecase>(
    () => UserLoginUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<RegisterViewModel>(
    () => RegisterViewModel(
      registerUsecase: serviceLocator<UserRegisterUsecase>(),
    ),
  );

  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(
      serviceLocator<UserLoginUsecase>(),
    ),
  );
}

Future<void> _initProductModule() async {
  serviceLocator.registerLazySingleton<IProductDataSource>(
    () => ProductRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

 serviceLocator.registerLazySingleton<IProductRepository>(
  () => ProductRemoteRepository(dataSource: serviceLocator<IProductDataSource>()),
);


  serviceLocator.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(serviceLocator<IProductRepository>()),
  );

  serviceLocator.registerFactory<ProductViewModel>(
    () => ProductViewModel(serviceLocator<GetProductsByCategoryUseCase>()),
  );

  // If you use ProductViewModel (Cubit) instead of ProductBloc, register it like this:
  // serviceLocator.registerFactory<ProductViewModel>(
  //   () => ProductViewModel(serviceLocator<GetProductsByCategory>()),
  // );
}
