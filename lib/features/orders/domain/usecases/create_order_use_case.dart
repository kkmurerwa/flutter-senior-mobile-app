import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import '../repositories/orders_repository.dart';

class CreateOrderUseCase {
  final OrdersRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, bool>> call(OrderItem orderItem) async {
    return await repository.createOrder(orderItem);
  }
}