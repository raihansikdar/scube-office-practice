class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  //final dynamic body;
  final Map<String,dynamic>? body;

  NetworkResponse(
      {required this.isSuccess, required this.statusCode, required this.body});
}