import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';

class VerificationResponseModel extends VerificationResponse {
  VerificationResponseModel({
    required bool success,
    required String message,
    required String token,
  }) : super(
    success: success,
    message: message,
    token: token,
  );

  factory VerificationResponseModel.fromJson(Map<String, dynamic> json) {
    return VerificationResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['token']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }
}