import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderItemModel>> getOrders();
  Future<bool> createOrder(OrderItemModel orders);
}