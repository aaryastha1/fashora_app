import 'package:fashora_app/core/network/hive_service.dart';
import 'package:fashora_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:fashora_app/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initAuthModule();
  
}


Future _initAuthModule() async{

  //Data Source
  serviceLocator.registerFactory(() => UserLocalDatasource(
    hiveService: serviceLocator<HiveService>()),
    );

    //Repository
    serviceLocator.registerFactory(
      () => UserLocalRepository(
        userLocalDatasource: serviceLocator<UserLocalDatasource>(),
        ),
    );

    //useCase

    serviceLocator.registerFactory(
      () => UserRegisterUsecase(
        userReposiotry: serviceLocator<UserLocalRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => UserLoginUsecase(
        userRepository: serviceLocator<UserLocalRepository>(),
      ),
    );

    serviceLocator.registerLazySingleton(
      () => RegisterViewModel(
        registerUsecase: serviceLocator<UserRegisterUsecase>(),
        ),
    );

}