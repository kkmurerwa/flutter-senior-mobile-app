import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import '../../../../core/errors/failures.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderItem>>> getOrders();
  Future<Either<Failure, OrderItem>> getOrderById(int id);
  Future<Either<Failure, bool>> createOrder(OrderItem order);
  Future<Either<Failure, bool>> updateOrder(OrderItem order);
  Future<Either<Failure, bool>> deleteOrder(int id);
}