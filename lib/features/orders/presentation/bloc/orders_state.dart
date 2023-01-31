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

class OrderCreatedState extends OrdersState {
  final bool isCreated;

  OrderCreatedState({required this.isCreated});

  @override
  List<Object?> get props => [isCreated];
}

class OrdersErrorState extends OrdersState {
  final String message;

  OrdersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}


