import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_starter/common/config.dart';
import 'package:flutter_starter/common/global.dart';
import 'package:flutter_starter/models/api_response.dart';
export 'package:dio/dio.dart' show DioException;

class ApiCachedResult {
  ApiCachedResult(this.response)
    : timeStamp = DateTime.now().microsecondsSinceEpoch;

  /// 缓存的时间戳
  final int timeStamp;

  /// 缓存的接口结果
  final dynamic response;
}

class Request {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: Config.apiHost,
      contentType: "application/json",
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static void initToken() {
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.token;
  }

  /// 缓存的接口
  static final Map<String, ApiCachedResult> cachedApi = {};
}

FutureResponse<T> request<T, K>(
  String url, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  String? method,
  Map<String, dynamic>? headers,
  bool? notGoLogin, // 登录失效的话，不重定向登录页面
  T Function(K data)? resJsonParse,
  String? baseUrl,
  String? cacheKey,
}) async {
  try {
    // 命中缓存
    if (cacheKey != null &&
        Request.cachedApi[cacheKey] != null &&
        DateTime.now().microsecondsSinceEpoch -
                Request.cachedApi[cacheKey]!.timeStamp <
            Config.apiCacheTime) {
      return ApiResponse(data: Request.cachedApi[cacheKey]!.response);
    }
    final res = await Request.dio.request(
      baseUrl == null ? url : baseUrl + url,
      options:
          (headers != null && headers.isNotEmpty) ||
                  (method != null && method.toLowerCase() != 'get')
              ? Options(headers: headers, method: method)
              : null,
      data: data,
      queryParameters: queryParameters,
    );
    if (res.statusCode != 200) {
      return ApiResponse(
        code: res.statusCode ?? -1,
        message: res.statusMessage ?? "服务器出错了",
      );
    }
    if (res.data == null) return getResponseData(cacheKey, null);
    if (res.data is! Map) {
      return getResponseData(
        cacheKey,
        resJsonParse != null ? resJsonParse(res.data as K) : null,
      );
    }
    final Map responseData = res.data as Map;
    if (responseData['ret'] == null) {
      return getResponseData(
        cacheKey,
        resJsonParse != null ? resJsonParse(responseData as K) : null,
      );
    }
    if (responseData['ret'] == 0) {
      return getResponseData(
        cacheKey,
        responseData['data'] != null && resJsonParse != null
            ? resJsonParse(responseData['data'])
            : null,
      );
    }
    if (responseData['ret'] == 101010) {
      // TODO: 约定token失效的code
      Global.token = null;
      if (notGoLogin != true) {
        Global.navigatorKey.currentState?.pushNamed("login");
      }
      return ApiResponse(
        code: responseData['ret'],
        message: responseData['msg'] ?? '登录失效',
      );
    }
    return ApiResponse(
      code: responseData['ret'],
      message: responseData['msg'] ?? '出错了',
    );
  } on Exception catch (e) {
    log('request exception: ', error: e);
    return ApiResponse(code: -10, message: "请求出错了");
  }
}

ApiResponse<T> getResponseData<T>(String? cacheKey, T? data) {
  if (cacheKey != null) {
    Request.cachedApi[cacheKey] = ApiCachedResult(data);
  }
  return ApiResponse(data: data);
}
