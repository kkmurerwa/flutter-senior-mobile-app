import 'package:flutter_senior_mobile_app/core/database/database.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/daos/orders_dao.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockDatabase extends Mock implements AppDatabase {}
class MockOrdersDao extends Mock implements OrdersDao {}

void main() {
  late MockOrdersDao mockOrdersDao;
  late MockDatabase mockDatabase;
  late OrdersLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabase = MockDatabase();
    mockOrdersDao = MockOrdersDao();
    dataSource = OrdersLocalDataSourceImpl(database: mockDatabase);

    when(() => mockDatabase.ordersDao).thenReturn(mockOrdersDao);
  });

  group('getOrders', () {
    test('should invoke getOrders method of dao when getOrders called', () async {
      // arrange
      final tCharactersDao = mockDatabase.ordersDao;

      when(() => tCharactersDao.getOrders())
          .thenAnswer((_) async => [tOrderItem]);

      // act
      await dataSource.getOrders();

      // assert
      verify(() => mockOrdersDao.getOrders()).called(1);
    });

    test('should return list of orders from the dao', () async {
      // arrange
      when(() => mockOrdersDao.getOrders())
          .thenAnswer((_) async => [tOrderItem]);

      // act
      final result = await dataSource.getOrders();

      // assert
      expect(result, [tOrderItem]);
    });
  });
}