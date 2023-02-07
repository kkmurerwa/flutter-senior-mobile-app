import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/core/network/network_info.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/datasources/onboarding_remote_data_source.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OnboardingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OtpResponse>> requestOtp(String phoneNumber) async {
    try {
      final result = await remoteDataSource.requestOtp(phoneNumber);
      return result;
    } on Exception {
      return Left(ServerFailure("Server Failure"));
    }
  }

  @override
  Future<Either<Failure, VerificationResponse>> verifyOtp(String phoneNumber, String otp) {
    return remoteDataSource.verifyOtp(phoneNumber, otp);
  }

}