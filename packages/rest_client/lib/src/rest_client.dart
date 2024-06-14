import 'package:dio/dio.dart';
import 'package:rest_client/src/models/rate_model.dart';

/// RestAPI client package
class RestClient {
  /// {@macro rest_client}
  RestClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.coincap.io',
        headers: {Headers.acceptHeader: 'application/json'},
      ),
    )..interceptors.addAll([
        LogInterceptor(
          request: false,
          requestHeader: false,
          responseHeader: false,
        ),
      ]);
  }

  late final Dio _dio;

  /// All prices on the CoinCap API are standardized in USD (United States Dollar).
  /// To make translating to other values easy, CoinCap now offers a Rates endpoint.
  /// We offer fiat and top cryptocurrency translated rates. Fiat rates are available through OpenExchangeRates.org.
  Future<List<RateModel>> getRates() async {
    final result = await _dio.get<Map<String, dynamic>>('/v2/rates');
    final data = result.data!['data'] as List<dynamic>;
    return data
        .map((r) => RateModel.fromJson(r as Map<String, dynamic>))
        .toList();
  }
}
