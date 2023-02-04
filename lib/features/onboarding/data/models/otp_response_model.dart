import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';

class OtpResponseModel extends OtpResponse {

  OtpResponseModel({
    required String status,
    required String message,
    required bool sent,
  }) : super(
    message: message,
    status: status,
    sent: sent
  );

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      message: json['message'],
      status: json['status'],
      sent: json['sent']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'sent': sent,
    };
  }
}