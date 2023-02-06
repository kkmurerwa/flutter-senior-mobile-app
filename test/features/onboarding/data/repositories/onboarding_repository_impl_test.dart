import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/core/network/network_info.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/datasources/onboarding_remote_data_source.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockOnboardingRemoteDataSource extends Mock implements OnboardingRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockOnboardingRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo networkInfo;
  late OnboardingRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockOnboardingRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = OnboardingRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: networkInfo
    );
  });

  test('OnboardingRepositoryImpl should be a subclass of OnboardingRepository', () {
    expect(repository, isA<OnboardingRepository>());
  });

  group('requestOtp', () {
    test('should invoke requestOtp method of the data source when requestOtp invoked', () async {
      // arrange
      when(() => mockRemoteDataSource.requestOtp(any()))
          .thenAnswer((_) async => Right(tOtpResponseModel));

      // act
      final result = await repository.requestOtp('');

      // assert
      verify(() => mockRemoteDataSource.requestOtp(''));
    });

    test('should return data when requestOtp invoked successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.requestOtp(any()))
          .thenAnswer((_) async => Right(tOtpResponseModel));

      // act
      final result = await repository.requestOtp('');

      // assert
      expect(result, Right(tOtpResponseModel));
    });

    test('should return failure when requestOtp invoked unsuccessfully', () async {
      // arrange
      when(() => mockRemoteDataSource.requestOtp(any()))
          .thenAnswer((_) async => const Left(ServerFailure("")));

      // act
      final result = await repository.requestOtp('');

      // assert
      expect(result, const Left(ServerFailure("")));
    });
  });

  group('verifyOtp', () {
    test('should invoke verifyOtp method of the data source when verifyOtp invoked', () async {
      // arrange
      when(() => mockRemoteDataSource.verifyOtp(any(), any()))
          .thenAnswer((_) async => Right(tVerificationResponseModel));

      // act
      final result = await repository.verifyOtp('', '');

      // assert
      verify(() => mockRemoteDataSource.verifyOtp('', ''));
    });

    test('should return data when verifyOtp invoked successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.verifyOtp(any(), any()))
          .thenAnswer((_) async => Right(tVerificationResponseModel));

      // act
      final result = await repository.verifyOtp('', '');

      // assert
      expect(result, Right(tVerificationResponseModel));
    });

    test('should return failure when verifyOtp invoked unsuccessfully', () async {
      // arrange
      when(() => mockRemoteDataSource.verifyOtp(any(), any()))
          .thenAnswer((_) async => const Left(ServerFailure("")));

      // act
      final result = await repository.verifyOtp('', '');

      // assert
      expect(result, const Left(ServerFailure("")));
    });
  });

}