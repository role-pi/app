class ApiResponse {
  final int code;
  final String response;

  ApiResponse({required this.code, required this.response});
}

class ApiError implements Exception {
  final int code;
  final String message;

  ApiError({required this.code, required this.message});
}
