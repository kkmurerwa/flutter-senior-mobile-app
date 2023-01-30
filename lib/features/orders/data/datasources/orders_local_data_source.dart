import 'package:flutter_senior_mobile_app/core/database/database.dart';
import 'package:flutter_senior_mobile_app/core/errors/exceptions.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
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
  Future<OrderItem> getOrderById(int id) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }

  @override
  Future<bool> createOrder(OrderItem orders) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<bool> updateOrder(OrderItem orders) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteOrder(int id) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }
}