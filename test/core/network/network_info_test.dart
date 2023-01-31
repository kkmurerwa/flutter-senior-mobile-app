import 'package:flutter_senior_mobile_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/test_models.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection', () async {
      // arrange
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      // act
      await networkInfo.isConnected;

      // assert
      verify(() => mockInternetConnectionChecker.hasConnection);
    });

    test('should return true when InternetConnectionChecker.hasConnection returns true', () async {
      // arrange
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, equals(true));
    });

    test('should return false when InternetConnectionChecker.hasConnection returns false', () async {
      // arrange
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasNoConnectionFuture);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, equals(false));
    });
  });
}
