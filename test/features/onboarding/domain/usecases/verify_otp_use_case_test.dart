import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/usecases/verify_otp_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/test_models.dart';
import 'request_otp_use_case_test.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository mockOnboardingRepository;
  late VerifyOtpUseCase verifyOtpUseCase;

  setUp(() {
    mockOnboardingRepository = MockOnboardingRepository();
    verifyOtpUseCase = VerifyOtpUseCase(mockOnboardingRepository);
  });

  test('should invoke verifyOtp method of the onboarding repository', () async {
    // arrange
    when(() => mockOnboardingRepository.verifyOtp(any(), any()))
        .thenAnswer((_) async => Right(tVerificationResponseTrue));

    // act
    await verifyOtpUseCase(tPhoneNumber, tOtp);

    // assert
    verify(() => mockOnboardingRepository.verifyOtp(tPhoneNumber, tOtp)).called(1);
  });

  test('should get true success response if Otp was verified successfully', () async {
    // arrange
    when(() => mockOnboardingRepository.verifyOtp(any(), any()))
        .thenAnswer((_) async => Right(tVerificationResponseTrue));

    // act
    final result = await verifyOtpUseCase(tPhoneNumber, tOtp);

    // assert
    result.fold((left) => fail('test failed'), (right) {
      expect(right, equals(tVerificationResponseTrue));
      expect(right.success, equals(true));
    });
  });

  test('should get false success response if Otp was verification failed', () async {
    // arrange
    when(() => mockOnboardingRepository.verifyOtp(any(), any()))
        .thenAnswer((_) async => Right(tVerificationResponseFalse));

    // act
    final result = await verifyOtpUseCase(tPhoneNumber, tOtp);

    // assert
    result.fold((left) => fail('test failed'), (right) {
      expect(right, equals(tVerificationResponseFalse));
      expect(right.success, equals(false));
    });
  });
}