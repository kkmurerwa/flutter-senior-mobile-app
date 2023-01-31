import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/exceptions.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/core/network/network_info.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockOrdersRemoteDataSource extends Mock implements OrdersRemoteDataSource {}
class MockOrdersLocalDataSource extends Mock implements OrdersLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockOrdersRemoteDataSource mockRemoteDataSource;
  late MockOrdersLocalDataSource mockLocalDataSource;
  late OrdersRepositoryImpl repository;
  late MockNetworkInfo networkInfo;

  setUp(() {
    mockRemoteDataSource = MockOrdersRemoteDataSource();
    mockLocalDataSource = MockOrdersLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = OrdersRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: networkInfo,
    );
  });

  group('noInternetConnection', ()
  {
    setUp(() {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      registerFallbackValue(tOrderItemModel);
    });

    group('getOrders', () {
      test('should invoke local data source for order operations if no internet', () async {
        // arrange
        when(() => mockLocalDataSource.getOrders())
            .thenAnswer((_) async => [tOrderItemModel]);

        // act
        final result = await repository.getOrders();

        // assert
        verify(() => mockLocalDataSource.getOrders());
      });

      test('should return data when getOrders invoked successfully', () async {
        // arrange
        when(() => mockLocalDataSource.getOrders())
            .thenAnswer((_) async => [tOrderItemModel]);

        // act
        final result = await repository.getOrders();

        // assert
        result.fold((failure) => "test failed", (orders) {
          expect(orders, [tOrderItemModel]);
        });
      });

      test('should return failure when getOrders failed', () async {
        // arrange
        when(() => mockLocalDataSource.getOrders())
            .thenThrow(DatabaseException("test"));

        // act
        final result = await repository.getOrders();

        // assert
        expect(result, const Left(DatabaseFailure("test")));
      });
    });

    group('getOrderById', () {
      test('should invoke the getOrderById method of local data source when getOrderById called', () async {
        // arrange
        when(() => mockLocalDataSource.getOrderById(any()))
            .thenAnswer((_) async => tOrderItemModel);

        // act
        final result = await repository.getOrderById(tOrderItemModel.id!);

        // assert
        verify(() => mockLocalDataSource.getOrderById(tOrderItemModel.id!));
      });

      test('should return data when getOrderById invoked successfully', () async {
        // arrange
        when(() => mockLocalDataSource.getOrderById(any()))
            .thenAnswer((_) async => tOrderItemModel);

        // act
        final result = await repository.getOrderById(tOrderItemModel.id!);

        // assert
        result.fold((failure) => "test failed", (order) {
          expect(order, tOrderItemModel);
        });
      });

      test('should return failure when getOrderById failed', () async {
        // arrange
        when(() => mockLocalDataSource.getOrderById(any()))
            .thenThrow(DatabaseException("test"));

        // act
        final result = await repository.getOrderById(tOrderItemModel.id!);

        // assert
        expect(result, const Left(DatabaseFailure("test")));
      });
    });

    group('createOrder', () {
      test('should invoke the create order method of local data source when createOrder called', () async {
        // arrange
        when(() => mockLocalDataSource.createOrder(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.createOrder(tOrderItemModel);

        // assert
        verify(() => mockLocalDataSource.createOrder(tOrderItemModel));
      });

      test('should return true when createOrder invoked successfully', () async {
        // arrange
        when(() => mockLocalDataSource.createOrder(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.createOrder(tOrderItemModel);

        // assert
        expect(result, const Right(true));
      });

      test('should return failure when createOrder failed', () async {
        // arrange
        when(() => mockLocalDataSource.createOrder(any()))
            .thenThrow(DatabaseException("test"));

        // act
        final result = await repository.createOrder(tOrderItemModel);

        // assert
        expect(result, const Left(DatabaseFailure("test")));
      });
    });

    group('updateOrder', () {
      test('should invoke the update order method of local data source when updateOrder called', () async {
        // arrange
        when(() => mockLocalDataSource.updateOrder(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.updateOrder(tOrderItemModel);

        // assert
        verify(() => mockLocalDataSource.updateOrder(tOrderItemModel));
      });

      test('should return true when updateOrder invoked successfully', () async {
        // arrange
        when(() => mockLocalDataSource.updateOrder(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.updateOrder(tOrderItemModel);

        // assert
        expect(result, const Right(true));
      });

      test('should return failure when updateOrder failed', () async {
        // arrange
        when(() => mockLocalDataSource.updateOrder(any()))
            .thenThrow(DatabaseException("test"));

        // act
        final result = await repository.updateOrder(tOrderItemModel);

        // assert
        expect(result, const Left(DatabaseFailure("test")));
      });
    });

    group('deleteOrder', () {
      test('should invoke the delete order method of local data source when deleteOrder called', () async {
        // arrange
        when(() => mockLocalDataSource.deleteOrder(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.deleteOrder(tOrderItemModel.id!);

        // assert
        verify(() => mockLocalDataSource.deleteOrder(tOrderItemModel.id!));
      });

      test('should return true when deleteOrder invoked successfully', () async {
        // arrange
        when(() => mockLocalDataSource.deleteOrder(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.deleteOrder(tOrderItemModel.id!);

        // assert
        expect(result, const Right(true));
      });

      test('should return failure when deleteOrder failed', () async {
        // arrange
        when(() => mockLocalDataSource.deleteOrder(any()))
            .thenThrow(DatabaseException("test"));

        // act
        final result = await repository.deleteOrder(tOrderItemModel.id!);

        // assert
        expect(result, const Left(DatabaseFailure("test")));
      });
    });
  });
}