import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/create_order_use_case.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockGetOrdersUseCase extends Mock implements GetOrdersUseCase {}
class MockCreateOrderUseCase extends Mock implements CreateOrderUseCase {}
class MockUnexpectedFailure extends Mock implements Failure {}
class MockUnexpectedEvent extends Mock implements OrdersEvent {}

void main() {
  late MockGetOrdersUseCase mockGetOrdersUseCase;
  late MockCreateOrderUseCase mockCreateOrderUseCase;
  late OrdersBloc bloc;

  setUp(() {
    mockGetOrdersUseCase = MockGetOrdersUseCase();
    mockCreateOrderUseCase = MockCreateOrderUseCase();

    bloc = OrdersBloc(
      getOrdersUseCase: mockGetOrdersUseCase,
      createOrdersUseCase: mockCreateOrderUseCase,
    );

    registerFallbackValue(tOrderItem);
  });

  test('initial state is OrdersEmptyState', () {
    expect(bloc.state, equals(OrdersEmptyState()));
  });

  test('should return OrdersErrorState if unexpected event is called', () {
    // arrange
    final expected = [
      OrdersErrorState(message: UNEXPECTED_FAILURE_MESSAGE)
    ];

    // assert later
    expectLater(bloc.stream, emitsInOrder(expected));

    // act
    bloc.add(MockUnexpectedEvent());
  });

  group('getOrdersEvent', () {
    test('should emit a OrderLoadingState when invoked', () async {
      // arrange
      when(() => mockGetOrdersUseCase.call())
          .thenAnswer((_) async => const Right([]));
      final expected = [
        OrdersLoadingState(),
      ];

      // assert later
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(GetOrdersEvent());
    });

    test('should invoke the call method of the getOrdersUseCase', () async {
      when(() => mockGetOrdersUseCase.call())
          .thenAnswer((_) async => Right([tOrderItem]));

      bloc.add(GetOrdersEvent());
      await untilCalled(() => mockGetOrdersUseCase.call());

      verify(() => mockGetOrdersUseCase.call());
    });

    group('ifGetOrdersSuccess', () {
      test('should emit a OrderLoadedState when invoked', () async {
        // arrange
        when(() => mockGetOrdersUseCase.call())
            .thenAnswer((_) async => Right([tOrderItem]));
        final expected = [
          OrdersLoadingState(),
          OrdersLoadedState(orders: [tOrderItem]),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetOrdersEvent());
      });
    });

    group('ifGetOrdersFailure', () {
      test('should emit a OrderErrorState with DatabaseFailure message when database error received', () async {
        // arrange
        when(() => mockGetOrdersUseCase.call())
            .thenAnswer((_) async => const Left(DatabaseFailure("")));
        final expected = [
          OrdersLoadingState(),
          OrdersErrorState(message: DATABASE_FAILURE_MESSAGE),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetOrdersEvent());
      });

      test('should emit a OrderErrorState with ServerFailure message when server error received', () async {
        // arrange
        when(() => mockGetOrdersUseCase.call())
            .thenAnswer((_) async => const Left(ServerFailure("")));
        final expected = [
          OrdersLoadingState(),
          OrdersErrorState(message: SERVER_FAILURE_MESSAGE),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetOrdersEvent());
      });

      test('should return Unexpected error message if any other error received', () async {
        // arrange
        when(() => mockGetOrdersUseCase.call())
            .thenAnswer((_) async => Left(MockUnexpectedFailure()));
        final expected = [
          OrdersLoadingState(),
          OrdersErrorState(message: UNEXPECTED_FAILURE_MESSAGE),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetOrdersEvent());
      });
    });
  });

  group('createOrderEvent', () {
    test('should emit a OrderLoadingState when createOrderEvent invoked', () async {
      // arrange
      when(() => mockCreateOrderUseCase.call(any()))
          .thenAnswer((_) async => const Right(true));
      final expected = [
        OrdersLoadingState(),
      ];

      // assert later
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(CreateOrderEvent(order: tOrderItem));
    });

    test('should invoke the call method of the createOrderUseCase', () async {
      when(() => mockCreateOrderUseCase.call(any()))
          .thenAnswer((_) async => const Right(true));

      bloc.add(CreateOrderEvent(order: tOrderItem));
      await untilCalled(() => mockCreateOrderUseCase.call(any()));

      verify(() => mockCreateOrderUseCase.call(any()));
    });

    group('ifCreateOrderSuccess', () {
      test('should emit a OrderCreatedState when order created', () async {
        // arrange
        when(() => mockCreateOrderUseCase.call(any()))
            .thenAnswer((_) async => const Right(true));
        final expected = [
          OrdersLoadingState(),
          OrderCreatedState(isCreated: true),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CreateOrderEvent(order: tOrderItem));
      });
    });

    group('ifCreateOrderFailure', () {
      test(
          'should emit a OrderErrorState with DatabaseFailure message when database error received received when creating order', () async {
        // arrange
        when(() => mockCreateOrderUseCase.call(any()))
            .thenAnswer((_) async => const Left(DatabaseFailure("")));
        final expected = [
          OrdersLoadingState(),
          OrdersErrorState(message: DATABASE_FAILURE_MESSAGE),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CreateOrderEvent(order: tOrderItem));
      });

      test('should emit a OrderErrorState with ServerFailure message when server error received when creating order', () async {
        // arrange
        when(() => mockCreateOrderUseCase.call(any()))
            .thenAnswer((_) async => const Left(ServerFailure("")));
        final expected = [
          OrdersLoadingState(),
          OrdersErrorState(message: SERVER_FAILURE_MESSAGE),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CreateOrderEvent(order: tOrderItem));
      });

      test('should return Unexpected error message if any other error received when creating order', () async {
        // arrange
        when(() => mockGetOrdersUseCase.call())
            .thenAnswer((_) async => Left(MockUnexpectedFailure()));
        final expected = [
          OrdersLoadingState(),
          OrdersErrorState(message: UNEXPECTED_FAILURE_MESSAGE),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetOrdersEvent());
      });
    });
  });
}