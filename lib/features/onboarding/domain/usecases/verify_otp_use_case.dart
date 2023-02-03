import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class VerifyOtpUseCase {
  final OnboardingRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, VerificationResponse>> call(String phoneNumber, String otp) async {
    return await repository.verifyOtp(phoneNumber, otp);
  }
}