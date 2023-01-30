import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/exceptions.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/core/network/network_info.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final OrdersRemoteDataSource remoteDataSource;
  final OrdersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<OrderItemModel>>> getOrders() async {
    if (await networkInfo.isConnected) {
      throw UnimplementedError();
    } else {
      try {
        final localOrders = await localDataSource.getOrders();
        return Right(localOrders);
      } on DatabaseException catch (exception) {
        return Left(DatabaseFailure(exception.message));
      }
    }
  }

  @override
  Future<Either<Failure, OrderItemModel>> getOrderById(int id) async {
    if (await networkInfo.isConnected) {
      throw UnimplementedError();
    } else {
      try {
        final localOrders = await localDataSource.getOrderById(id);

        return Right(localOrders);
      } on DatabaseException catch (exception) {
        return Left(DatabaseFailure(exception.message));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> createOrder(OrderItemModel order) async {
    if (await networkInfo.isConnected) {
      throw UnimplementedError();
    } else {
      try {
        final localOrders = await localDataSource.createOrder(order);

        return Right(localOrders);
      } on DatabaseException catch (exception) {
        return Left(DatabaseFailure(exception.message));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrder(OrderItemModel order) async {
    if (await networkInfo.isConnected) {
      throw UnimplementedError();
    } else {
      try {
        final localOrders = await localDataSource.updateOrder(order);

        return Right(localOrders);
      } on DatabaseException catch (exception) {
        return Left(DatabaseFailure(exception.message));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(int id) async {
    if (await networkInfo.isConnected) {
      throw UnimplementedError();
    } else {
      try {
        final localOrders = await localDataSource.deleteOrder(id);

        return Right(localOrders);
      } on DatabaseException catch (exception) {
        return Left(DatabaseFailure(exception.message));
      }
    }
  }
}