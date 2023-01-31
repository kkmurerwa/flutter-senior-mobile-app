import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String DATABASE_FAILURE_MESSAGE = 'Database Failure';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersBloc({
    required this.getOrdersUseCase,
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
    }
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure: return SERVER_FAILURE_MESSAGE;
      case DatabaseFailure: return DATABASE_FAILURE_MESSAGE;
      default: return "Unexpected error";
    }
  }
}
