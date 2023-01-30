import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';

abstract class OrdersLocalDataSource {
  Future<List<OrderItemModel>> getOrders();
  Future<OrderItemModel> getOrderById(int id);
  Future<bool> createOrder(OrderItemModel orders);
  Future<bool> updateOrder(OrderItemModel orders);
  Future<bool> deleteOrder(int id);
}