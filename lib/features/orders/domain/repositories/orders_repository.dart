import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import '../../../../core/errors/failures.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderItem>>> getOrders();
  Future<Either<Failure, Order>> getOrderById(int id);
  Future<Either<Failure, bool>> createOrder(Order order);
  Future<Either<Failure, bool>> updateOrder(Order order);
  Future<Either<Failure, bool>> deleteOrder(int id);
}