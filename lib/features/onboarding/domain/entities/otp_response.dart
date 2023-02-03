class OtpResponse {
  final String message;
  final String status;
  final bool sent;

  OtpResponse({
    required this.message,
    required this.status,
    required this.sent
  });
}