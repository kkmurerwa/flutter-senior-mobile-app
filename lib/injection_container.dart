import 'package:flutter_senior_mobile_app/core/database/database.dart';
import 'package:flutter_senior_mobile_app/core/network/network_info.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/create_order_use_case.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/orders/data/repositories/orders_repository_impl.dart';

// Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  initFeatures();

  initCore();

  await initExternal();
}

void initFeatures() {
  // Bloc
  sl.registerFactory(() =>
    OrdersBloc(
      getOrdersUseCase: sl(),
      createOrdersUseCase: sl()
    )
  );

  // Use cases
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));

  // Repository
  sl.registerLazySingleton<OrdersRepository>(() =>
    OrdersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl()
    )
  );

  // Data source
  sl.registerLazySingleton<OrdersLocalDataSource>(
    () => OrdersLocalDataSourceImpl(database: sl())
  );

  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(client: sl())
  );
}

void initCore() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl())
  );

}

Future<void> initExternal() async {
  // Http client
  sl.registerLazySingleton(() => http.Client());

  // Network info
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Database
  final appDatabase = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
  sl.registerFactory(() => appDatabase);
}