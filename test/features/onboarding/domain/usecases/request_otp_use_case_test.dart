import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/usecases/request_otp_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository mockOnboardingRepository;
  late RequestOtpUseCase requestOtpUseCase;

  setUp(() {
    mockOnboardingRepository = MockOnboardingRepository();
    requestOtpUseCase = RequestOtpUseCase(mockOnboardingRepository);
  });

  test('should invoke requestOtp method of the onboarding repository', () async {
    // arrange
    when(() => mockOnboardingRepository.requestOtp(any()))
        .thenAnswer((_) async => Right(tOtpResponseTrue));

    // act
    await requestOtpUseCase(tPhoneNumber);
    
    // assert
    verify(() => mockOnboardingRepository.requestOtp(tPhoneNumber)).called(1);
  });

  test('should get true sent response if Otp request was successful', () async {
    // arrange
    when(() => mockOnboardingRepository.requestOtp(any()))
        .thenAnswer((_) async => Right(tOtpResponseTrue));

    // act
    final result = await requestOtpUseCase(tPhoneNumber);

    // assert
    result.fold((left) => fail('test failed'), (right) {
      expect(right, equals(tOtpResponseTrue));
      expect(right.sent, equals(true));
    });
  });

  test('should return false sent response if Otp request failed', () async {
    // arrange
    // arrange
    when(() => mockOnboardingRepository.requestOtp(any()))
        .thenAnswer((_) async => Right(tOtpResponseFalse));

    // act
    final result = await requestOtpUseCase(tPhoneNumber);

    // assert
    result.fold((left) => fail('test failed'), (right) {
      expect(right, equals(tOtpResponseFalse));
      expect(right.sent, equals(false));
    });
  });

}