import 'dart:math';

import 'package:flutter_senior_mobile_app/core/database/database.dart';
import 'package:flutter_senior_mobile_app/core/errors/exceptions.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/daos/orders_dao.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockDatabase extends Mock implements AppDatabase {}
class MockOrdersDao extends Mock implements OrdersDao {}

void main() {
  late MockOrdersDao mockOrdersDao;
  late MockDatabase mockDatabase;
  late OrdersLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabase = MockDatabase();
    mockOrdersDao = MockOrdersDao();
    dataSource = OrdersLocalDataSourceImpl(database: mockDatabase);

    when(() => mockDatabase.ordersDao).thenReturn(mockOrdersDao);
  });

  group('getOrders', () {
    test('should invoke getOrders method of dao when getOrders called', () async {
      // arrange
      when(() => mockOrdersDao.getOrders())
          .thenAnswer((_) async => [tOrderItem]);

      // act
      await dataSource.getOrders();

      // assert
      verify(() => mockOrdersDao.getOrders()).called(1);
    });

    test('should return list of orders from the dao', () async {
      // arrange
      when(() => mockOrdersDao.getOrders())
          .thenAnswer((_) async => [tOrderItem]);

      // act
      final result = await dataSource.getOrders();

      // assert
      expect(result, [tOrderItem]);
    });

    test('should throw CacheException if database contains no cache', () async {
      // arrange
      when(() => mockOrdersDao.getOrders())
          .thenThrow(Exception());

      // act
      final call = dataSource.getOrders;

      // assert
      expect(() => call(), throwsA(isA<DatabaseException>()));
    });
  });

  group('getOrderById', () {
    final orderId = tOrderItem.id;

    test('should invoke getOrderById method of dao when getOrderById called', () async {
      // arrange
      when(() => mockOrdersDao.getOrderById(orderId))
          .thenAnswer((_) async => tOrderItem);

      // act
      await dataSource.getOrderById(1);

      // assert
      verify(() => mockOrdersDao.getOrderById(orderId)).called(1);
    });

    test('should return order from the dao', () async {
      // arrange
      when(() => mockOrdersDao.getOrderById(orderId))
          .thenAnswer((_) async => tOrderItem);

      // act
      final result = await dataSource.getOrderById(orderId);

      // assert
      expect(result, tOrderItem);
    });

    test('should throw DatabaseException if getOrderById returns null', () {
      // arrange
      when(() => mockOrdersDao.getOrderById(orderId))
          .thenAnswer((_) async => null);

      // act
      final call = dataSource.getOrderById;

      // assert
      expect(() => call(orderId), throwsA(isA<DatabaseException>()));
    });

    test('should throw DatabaseException if database cannot return item with given id', () async {
      // arrange
      when(() => mockOrdersDao.getOrderById(orderId))
          .thenThrow(Exception());

      // act
      final call = dataSource.getOrderById;

      // assert
      expect(() => call(1), throwsA(isA<DatabaseException>()));
    });
  });

  group('createOrder', () {
    test('should invoke createOrder method of dao when called', () async {
      // arrange
      when(() => mockOrdersDao.createOrder(tOrderItem))
          .thenAnswer((_) async => true);

      // act
      await dataSource.createOrder(tOrderItem);

      // assert
      verify(() => mockOrdersDao.createOrder(tOrderItem)).called(1);
    });

    test('should return true if order created successfully', () async {
      // arrange
      when(() => mockOrdersDao.createOrder(tOrderItem))
          .thenAnswer((_) async => true);

      // act
      final result = await dataSource.createOrder(tOrderItem);

      // assert
      expect(result, true);
    });

    test('should throw DatabaseException if order creation failed', () async {
      // arrange
      when(() => mockOrdersDao.createOrder(tOrderItem))
          .thenThrow(Exception());

      // act
      final call = dataSource.createOrder;

      // assert
      expect(() => call(tOrderItem), throwsA(isA<DatabaseException>()));
    });
  });

  group('updateOrder', () {
    test('should invoke updateOrder method of dao when called', () async {
      // arrange
      when(() => mockOrdersDao.updateOrder(tOrderItem))
          .thenAnswer((_) async => true);

      // act
      await dataSource.updateOrder(tOrderItem);

      // assert
      verify(() => mockOrdersDao.updateOrder(tOrderItem)).called(1);
    });

    test('should return true if order updated successfully', () async {
      // arrange
      when(() => mockOrdersDao.updateOrder(tOrderItem))
          .thenAnswer((_) async => true);

      // act
      final result = await dataSource.updateOrder(tOrderItem);

      // assert
      expect(result, true);
    });

    test('should throw DatabaseException if order update failed', () async {
      // arrange
      when(() => mockOrdersDao.updateOrder(tOrderItem))
          .thenThrow(Exception());

      // act
      final call = dataSource.updateOrder;

      // assert
      expect(() => call(tOrderItem), throwsA(isA<DatabaseException>()));
    });
  });

  group('deleteOrder', () {
    final orderId = tOrderItem.id;

    test('should invoke deleteOrder method of dao when called', () async {
      // arrange
      when(() => mockOrdersDao.deleteOrder(orderId))
          .thenAnswer((_) async => true);

      // act
      await dataSource.deleteOrder(orderId);

      // assert
      verify(() => mockOrdersDao.deleteOrder(orderId)).called(1);
    });

    test('should return true if order deleted successfully', () async {
      // arrange
      when(() => mockOrdersDao.deleteOrder(orderId))
          .thenAnswer((_) async => true);

      // act
      final result = await dataSource.deleteOrder(orderId);

      // assert
      expect(result, true);
    });

    test('should throw DatabaseException if order deletion failed', () async {
      // arrange
      when(() => mockOrdersDao.deleteOrder(orderId))
          .thenThrow(Exception());

      // act
      final call = dataSource.deleteOrder;

      // assert
      expect(() => call(orderId), throwsA(isA<DatabaseException>()));
    });
  });
}