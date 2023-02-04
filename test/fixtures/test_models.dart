import 'package:flutter_senior_mobile_app/features/onboarding/data/models/otp_response_model.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/models/verification_response_model.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

final tHasConnectionFuture = Future.value(true);
final tHasNoConnectionFuture = Future.value(false);

final tOrderItem = OrderItem(
    id: 1,
    pickUpPoint: "pickUpPoint",
    dropOffPoint: "dropOffPoint",
    weight: 1.0,
    instructions: "instructions",
    createdAt: DateTime(2023,1, 30).microsecondsSinceEpoch,
    createdBy: "createdBy"
);

final tOrderItemModel = OrderItemModel(
    id: 1,
    pickUpPoint: "pickUpPoint",
    dropOffPoint: "dropOffPoint",
    weight: 1.0,
    instructions: "instructions",
    createdAt: DateTime(2023,1, 30).microsecondsSinceEpoch,
    createdBy: "createdBy"
);

const tPhoneNumber = "0705352411";
const tOtp = "1234";

final tOtpResponseTrue = OtpResponse(
    message: 'test message',
    status: 'test status',
    sent: true
);

final tOtpResponseFalse = OtpResponse(
    message: 'test message',
    status: 'test status',
    sent: false
);

final tVerificationResponseTrue = VerificationResponse(
    message: '',
    success: true,
    token: 'token'
);

final tVerificationResponseFalse = VerificationResponse(
    message: '',
    success: false,
    token: null
);

final tOtpResponseModel = OtpResponseModel(
    message: 'test message',
    status: 'test status',
    sent: true
);

final tVerificationResponseModel = VerificationResponseModel(
    success: true,
    message: 'test message',
    token: 'test token'
);
