part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent extends Equatable {}

class GetOrdersEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}
