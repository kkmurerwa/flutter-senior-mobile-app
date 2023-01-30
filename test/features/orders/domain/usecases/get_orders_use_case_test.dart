import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late MockOrdersRepository mockOrdersRepository;
  late GetOrdersUseCase getOrdersUseCase;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
    getOrdersUseCase = GetOrdersUseCase(mockOrdersRepository);
  });

  test('should invoke getOrders method of the OrdersRepository', () async {
    // arrange
    when(() => mockOrdersRepository.getOrders())
        .thenAnswer((_) async => Right([tOrderItem]));

    // act
    final result = await getOrdersUseCase();

    // assert
    verify(() => mockOrdersRepository.getOrders()).called(1);
  });

  test('should get orders from the repository', () async {
    // arrange
    when(() => mockOrdersRepository.getOrders())
        .thenAnswer((_) async => Right([tOrderItem]));

    // act
    final result = await getOrdersUseCase();

    // assert
    result.fold((left) => fail('test failed'), (right) {
      expect(right, equals([tOrderItem]));
    });
  });
}