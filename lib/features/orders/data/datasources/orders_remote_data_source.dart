import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import 'package:http/http.dart' as http;

abstract class OrdersRemoteDataSource {
  Future<List<OrderItemModel>> getOrders();
  Future<bool> createOrder(OrderItemModel orders);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final http.Client client;

  OrdersRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> createOrder(OrderItemModel orders) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<List<OrderItemModel>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }

}