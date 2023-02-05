import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<Either<Failure, OtpResponse>> requestOtp(String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VerificationResponse>> verifyOtp(String phoneNumber, String otp) {
    throw UnimplementedError();
  }

}