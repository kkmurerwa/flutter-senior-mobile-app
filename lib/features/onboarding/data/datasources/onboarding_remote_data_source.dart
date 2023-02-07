import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/core/errors/failures.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/models/otp_response_model.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';

abstract class OnboardingRemoteDataSource {
  Future<Either<Failure, OtpResponse>> requestOtp(String phoneNumber);
  Future<Either<Failure, VerificationResponse>> verifyOtp(String phoneNumber, String otp);
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  final http.Client client;

  OnboardingRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, OtpResponse>> requestOtp(String phoneNumber) async {
    try {
      return client.post(
        Uri.parse(""),
        body: {
          "phoneNumber": phoneNumber,
        },
      ).then((response) {
        if (response.statusCode == 200) {
          return Future.value(Right(
            OtpResponseModel(
              status: "success",
              message: "OTP sent successfully",
              sent: true
            )
          ));
        } else {
          return Future.value(Left(ServerFailure("Server Error")));
        }
      });
    } catch (e) {
      return Future.value(Left(ServerFailure("Server Error")));
    }
  }

  @override
  Future<Either<Failure, VerificationResponse>> verifyOtp(String phoneNumber, String otp) {
    try {
      return client.post(
        Uri.parse(""),
        body: {
          "phoneNumber": phoneNumber,
          "otp": otp
        },
      ).then((response) {
        if (response.statusCode == 200) {
          return Future.value(Right(
            VerificationResponse(
              message: "OTP verified successfully",
              success: true,
              token: 'token'
            )
          ));
        } else {
          return Future.value(Left(ServerFailure("Server Error")));
        }
      });
    } catch (e) {
      return Future.value(Left(ServerFailure("Server Error")));
    }
  }
}