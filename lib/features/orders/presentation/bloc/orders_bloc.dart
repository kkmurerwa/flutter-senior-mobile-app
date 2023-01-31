import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/create_order_use_case.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String DATABASE_FAILURE_MESSAGE = 'Database Failure';
const String UNEXPECTED_FAILURE_MESSAGE = 'Unexpected Failure';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final CreateOrderUseCase createOrdersUseCase;

  OrdersBloc({
    required this.getOrdersUseCase,
    required this.createOrdersUseCase,
  }) : super(OrdersEmptyState()) {
    on<OrdersEvent>(ordersEventObserver);
  }

  FutureOr<void> ordersEventObserver(event, emit) async {
    if (event is GetOrdersEvent) {
      emit(OrdersLoadingState());

      final result = await getOrdersUseCase.call();

      result.fold(
        (failure) => emit(OrdersErrorState(message: mapFailureToMessage(failure))),
        (orders) => emit(OrdersLoadedState(orders: orders)),
      );
    } else if (event is CreateOrderEvent) {
      emit(OrdersLoadingState());

      final result = await createOrdersUseCase.call(event.order);

      result.fold(
        (failure) => emit(OrdersErrorState(message: mapFailureToMessage(failure))),
        (isCreated) => emit(OrderCreatedState(isCreated: isCreated)),
      );
    } else {
      emit(OrdersErrorState(message: UNEXPECTED_FAILURE_MESSAGE));
    }
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure: return SERVER_FAILURE_MESSAGE;
      case DatabaseFailure: return DATABASE_FAILURE_MESSAGE;
      default: return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
