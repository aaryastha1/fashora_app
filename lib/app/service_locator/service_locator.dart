import 'package:dio/dio.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';
import 'package:fashora_app/features/favorite/presentation/view_model/cart_view_model.dart';
import 'package:fashora_app/features/order/data/data_source/datasource.dart';
import 'package:fashora_app/features/order/domain/usecase/order_usecase.dart';

// Aliases to avoid import conflicts
import 'package:fashora_app/features/product/data/data_sorce/favorite_data_source.dart' as favoriteDataSource;
import 'package:fashora_app/features/product/data/data_sorce/remote_datasource/favorite_remote_datasource.dart' as favoriteRemoteDatasource;

import 'package:fashora_app/features/profile/data/data_source/profile_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:fashora_app/core/network/api_service.dart';
import 'package:fashora_app/core/network/hive_service.dart';
import 'package:fashora_app/app/shared_prefs/token_shared_prefs.dart';

// Auth
import 'package:fashora_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:fashora_app/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:fashora_app/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:fashora_app/features/auth/data/repository/remote_repository/user_remote_repository.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

// Product
import 'package:fashora_app/features/product/data/data_sorce/product_data_source.dart';
import 'package:fashora_app/features/product/data/data_sorce/remote_datasource/product_remote_datasource.dart';
import 'package:fashora_app/features/product/data/repository/remote_repository/product_remote_repository.dart' as data;
import 'package:fashora_app/features/product/domain/repository/product_repository.dart';
import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';
import 'package:fashora_app/features/product/domain/use_case/search_usecase.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';

// Favorite
import 'package:fashora_app/features/product/data/data_sorce/favorite_data_source.dart';
import 'package:fashora_app/features/product/data/data_sorce/remote_datasource/favorite_remote_datasource.dart';
import 'package:fashora_app/features/product/data/repository/remote_repository/favorite_remote_repository.dart';
import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';
import 'package:fashora_app/features/product/domain/use_case/get_favorite.dart';
import 'package:fashora_app/features/product/domain/use_case/toggle_favorite_usecase.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';

// Cart
import 'package:fashora_app/features/cart/data/data_source/remote_datasource/cart_remote_datasource.dart';
import 'package:fashora_app/features/cart/data/repository/remote_reposiotry/cart_remote_repository.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';
import 'package:fashora_app/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/remove_from_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/update_quantity_usecase.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';

// Order
import 'package:fashora_app/features/order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:fashora_app/features/order/data/repository/remote_repository/order_repository.dart';
import 'package:fashora_app/features/order/domain/repository/order_repository.dart';
import 'package:fashora_app/features/order/domain/usecase/place_order_usecase.dart';
import 'package:fashora_app/features/order/presentation/view_model/order_viewmodel.dart';

// Profile
import 'package:fashora_app/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:fashora_app/features/profile/data/repository/remote_repository/profile_remote_repository.dart';
import 'package:fashora_app/features/profile/domain/repository/profile_repository.dart';
import 'package:fashora_app/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:fashora_app/features/profile/domain/usecase/update_profile_usecase.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_viewmodel.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Core Services
  serviceLocator.registerLazySingleton<Dio>(() => Dio());

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
  await serviceLocator<HiveService>().init();

  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(serviceLocator()));

  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(sharedPreferences: sharedPrefs),
  );

  await _initAuthModule();
  await _initProductModule();
  await _initCartModule();
  await _initOrderModule();
  await _initProfileModule();
}

Future<void> _initAuthModule() async {
  serviceLocator.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasource(hiveService: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(apiService: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserLocalRepository>(
    () => UserLocalRepository(userLocalDatasource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(userRemoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<IuserRepository>(
    () => UserRemoteRepository(userRemoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => UserRegisterUsecase(userReposiotry: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UserLoginUsecase(userRepository: serviceLocator(), tokenSharedPrefs: serviceLocator()));

  serviceLocator.registerLazySingleton(() => RegisterViewModel(registerUsecase: serviceLocator()));
  serviceLocator.registerFactory(() => LoginViewModel(serviceLocator()));
}

Future<void> _initProductModule() async {
  serviceLocator.registerLazySingleton<IProductDataSource>(
    () => ProductRemoteDataSource(apiService: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<IProductRepository>(
    () => data.ProductRemoteRepository(dataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => GetProductsByCategoryUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SearchProductsUseCase(serviceLocator()));

  serviceLocator.registerFactory(() => ProductViewModel(
        getProductsByCategoryUseCase: serviceLocator(),
        searchProductsUseCase: serviceLocator(),
      ));

  // Favorite - FIXED TO USE ApiService!
  serviceLocator.registerLazySingleton<IFavoriteDataSource>(
    () => favoriteRemoteDatasource.FavoriteRemoteDataSource(serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<IFavoriteRepository>(
    () => FavoriteRemoteRepository(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => GetFavoritesUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => ToggleFavoriteUseCase(repository: serviceLocator()));

  serviceLocator.registerFactory(() => FavoriteBloc(
        serviceLocator<IFavoriteRepository>(),
      ));
}

Future<void> _initCartModule() async {
  serviceLocator.registerLazySingleton<ICartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(dio: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ICartRepository>(
    () => CartRepositoryImpl(apiService: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => GetCartUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddToCartUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RemoveFromCartUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateQuantityUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ClearCartUseCase(serviceLocator()));

  serviceLocator.registerFactory(() => CartBloc(
        getCartUseCase: serviceLocator(),
        addToCartUseCase: serviceLocator(),
        removeFromCartUseCase: serviceLocator(),
        updateQuantityUseCase: serviceLocator(),
        clearCartUseCase: serviceLocator(),
      ));

  serviceLocator.registerFactory(() => CartBlocFavorite(
        addToCartUseCase: serviceLocator(),
        getCartUseCase: serviceLocator(),
      ));
}

Future<void> _initOrderModule() async {
  serviceLocator.registerLazySingleton<IOrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(dio: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<IOrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<IPlaceOrderUseCase>(
    () => PlaceOrderUseCase(orderRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(() => OrderBloc(placeOrderUseCase: serviceLocator()));
}

Future<void> _initProfileModule() async {
  serviceLocator.registerLazySingleton<IProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<IProfileRepository>(
    () => ProfileRemoteRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => GetProfile(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateProfileUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => ProfileBloc(
        serviceLocator(),
        serviceLocator(),
      ));
}
