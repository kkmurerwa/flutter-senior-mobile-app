part of 'orders_bloc.dart';

@immutable
abstract class OrdersState extends Equatable {}

class OrdersEmptyState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoadingState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoadedState extends OrdersState {
  final List<OrderItem> orders;

  OrdersLoadedState({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class OrdersErrorState extends OrdersState {
  final String message;

  OrdersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}


