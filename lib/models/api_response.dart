class ApiResponse<T> {
  ApiResponse({this.code, this.message, this.data});

  /// 返回码，不为null则为错误返回，为null则返回正确
  final int? code;
  // 错误消息信息
  final String? message;
  // 返回数据
  final T? data;
}

typedef FutureResponse<T> = Future<ApiResponse<T>>;