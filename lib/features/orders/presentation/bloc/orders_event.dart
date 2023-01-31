part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent extends Equatable {}

class GetOrdersEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends OrdersEvent {
  final OrderItem order;

  CreateOrderEvent({required this.order});

  @override
  List<Object?> get props => [order];
}
