import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/products")
  Future<List<Product>> getProducts();
}

class ApiService {
  final _dio = Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      followRedirects: false,
      validateStatus: (status) => (status ?? 0) <= 500,
      responseType: ResponseType.json,
    )
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

  late final ApiClient? client = ApiClient(_dio);

  static ApiService? _instance;

  static ApiService get instance => _instance ??= ApiService._();

  ApiService._();

  static String? errorText(dynamic e) {
    if (e is DioError) {
      if (e.response == null) {
        return 'Please check your internet connection and try again';
      }
    }
    return null;
  }
}
