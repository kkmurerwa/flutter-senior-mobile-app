import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockGetOrdersUseCase extends Mock implements GetOrdersUseCase {}
class MockUnexpectedFailure extends Mock implements Failure {}

void main() {
  late MockGetOrdersUseCase mockGetOrdersUseCase;
  late OrdersBloc bloc;

  setUp(() {
    mockGetOrdersUseCase = MockGetOrdersUseCase();
    bloc = OrdersBloc(getOrdersUseCase: mockGetOrdersUseCase);
  });

  test('initial state is OrdersEmptyState', () {
    expect(bloc.state, equals(OrdersEmptyState()));
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

    group('ifSuccess', () {
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

    group('ifFailure', () {
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
          OrdersErrorState(message: "Unexpected error"),
        ];

        // assert later
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetOrdersEvent());
      });
    });
  });
}