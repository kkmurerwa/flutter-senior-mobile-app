import 'package:flutter_senior_mobile_app/core/database/database.dart';
import 'package:flutter_senior_mobile_app/core/errors/exceptions.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

abstract class OrdersLocalDataSource {
  Future<List<OrderItem>> getOrders();
  Future<OrderItem> getOrderById(int id);
  Future<bool> createOrder(OrderItem orders);
  Future<bool> updateOrder(OrderItem orders);
  Future<bool> deleteOrder(int id);
}

class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  final AppDatabase database;

  OrdersLocalDataSourceImpl({required this.database});

  @override
  Future<List<OrderItem>> getOrders() async {
    try {
      final ordersDao = database.ordersDao;
      return await ordersDao.getOrders();
    } catch (e) {
      throw DatabaseException("Can't get orders from database");
    }
  }

  @override
  Future<OrderItem> getOrderById(int id) async {
    try {
      final ordersDao = database.ordersDao;
      final orderItem = await ordersDao.getOrderById(id);

      if (orderItem != null) {
        return orderItem;
      } else {
        throw DatabaseException("Can't get order from database");
      }
    } catch (e) {
      throw DatabaseException("Can't get order from database");
    }
  }

  @override
  Future<bool> createOrder(OrderItem order) {
    try {
      final ordersDao = database.ordersDao;
      ordersDao.createOrder(order);

      return Future.value(true);
    } catch (e) {
      throw DatabaseException("Can't create order");
    }
  }

  @override
  Future<bool> updateOrder(OrderItem orders) {
    try {
      final ordersDao = database.ordersDao;
      ordersDao.updateOrder(orders);

      return Future.value(true);
    } catch (e) {
      throw DatabaseException("Can't update order");
    }
  }

  @override
  Future<bool> deleteOrder(int id) {
    try {
      final ordersDao = database.ordersDao;
      ordersDao.deleteOrder(id);

      return Future.value(true);
    } catch (e) {
      throw DatabaseException("Can't delete order");
    }
  }
}