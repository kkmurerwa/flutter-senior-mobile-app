import 'package:floor/floor.dart';
import 'package:flutter_senior_mobile_app/core/database/database.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/daos/orders_dao.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/test_models.dart';

void main() {
  late AppDatabase database;
  late OrdersDao ordersDao;

  setUp(() async {
    final migration1to2 = Migration(1, 2, (database) async {
      await database.execute('ALTER TABLE dog ADD COLUMN nick_name TEXT');
    });
    final allMigrations = [migration1to2];

    database = await $FloorAppDatabase
        .inMemoryDatabaseBuilder()
        .addMigrations(allMigrations)
        .build();

    ordersDao = database.ordersDao;
  });

  tearDown(() async {
    await database.close();
  });

  test('database is initially empty', () async {
    // act
    final result = await ordersDao.getOrders();

    // assert
    expect(result, isEmpty);
  });

  group('getOrders', () {
    test('should get all orders and return empty list on initialization', () async {
      // act
      final result = await ordersDao.getOrders();

      // assert
      expect(result, isEmpty);
    });

    test('should get all orders and return list of orders', () async {
      // act
      await ordersDao.createOrder(tOrderItem);
      final result = await ordersDao.getOrders();

      // assert
      expect(result, hasLength(1));
      expect(result, [tOrderItem]);
    });
  });

  group('createOrder', () {
    test('should create order item', () async {
      // act
      await ordersDao.createOrder(tOrderItem);
      final result = await ordersDao.getOrders();

      // assert
      expect(result, hasLength(1));
      expect(result, [tOrderItem]);
    });
  });

  group('updateOrder', () {
    test('should update order item', () async {
      // arrange
      final modifiedOrderItem = OrderItem(
          id: tOrderItem.id,
          pickUpPoint: tOrderItem.pickUpPoint,
          dropOffPoint: tOrderItem.dropOffPoint,
          weight: 2,
          instructions: tOrderItem.instructions,
          createdAt: tOrderItem.createdAt,
          createdBy: tOrderItem.createdBy
      );

      // act
      await ordersDao.createOrder(tOrderItem);
      await ordersDao.updateOrder(modifiedOrderItem);

      final result = await ordersDao.getOrders();
      final resultOrderItem = result.first;

      // assert
      expect(result, hasLength(1));
      expect(resultOrderItem, modifiedOrderItem);
      expect(resultOrderItem.weight, modifiedOrderItem.weight);
    });
  });

  group('deleteOrder', () {
    test('should delete order item', () async {
      // act
      await ordersDao.createOrder(tOrderItem);
      await ordersDao.deleteOrder(tOrderItem.id!);
      final result = await ordersDao.getOrders();

      // assert
      expect(result, isEmpty);
    });
  });

}