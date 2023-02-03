class VerificationResponse {
  final String message;
  final bool success;
  final String? token;

  VerificationResponse({
    required this.message,
    required this.success,
    required this.token,
  });
}