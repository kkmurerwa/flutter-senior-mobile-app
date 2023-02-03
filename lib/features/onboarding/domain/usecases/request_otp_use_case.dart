import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class RequestOtpUseCase {
  final OnboardingRepository repository;

  RequestOtpUseCase(this.repository);

  Future<Either<Failure, OtpResponse>> call(String phoneNumber) async {
    return await repository.requestOtp(phoneNumber);
  }
}