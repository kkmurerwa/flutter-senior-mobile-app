import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, OtpResponse>> requestOtp(String phoneNumber);
  Future<Either<Failure, VerificationResponse>> verifyOtp(String phoneNumber, String otp);
}