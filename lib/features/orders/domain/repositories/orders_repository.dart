import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import '../../../../core/errors/failures.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderItemModel>>> getOrders();
  Future<Either<Failure, OrderItemModel>> getOrderById(int id);
  Future<Either<Failure, bool>> createOrder(OrderItemModel order);
  Future<Either<Failure, bool>> updateOrder(OrderItemModel order);
  Future<Either<Failure, bool>> deleteOrder(int id);
}