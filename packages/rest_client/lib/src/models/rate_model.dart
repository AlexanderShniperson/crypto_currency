import 'package:json_annotation/json_annotation.dart';

part 'rate_model.g.dart';

/// All prices on the CoinCap API are standardized in USD (United States Dollar).
/// To make translating to other values easy, CoinCap now offers a Rates endpoint.
/// We offer fiat and top cryptocurrency translated rates. Fiat rates are available through OpenExchangeRates.org.
@JsonSerializable()
class RateModel {
  /// constructor
  const RateModel({
    required this.id,
    required this.symbol,
    required this.currencySymbol,
    required this.rateUsd,
    required this.type,
  });

  /// unique identifier for asset or fiat
  @JsonKey(name: 'id')
  final String id;

  /// most common symbol used to identify asset or fiat
  @JsonKey(name: 'symbol')
  final String symbol;

  /// currency symbol used to identify asset or fiat
  @JsonKey(name: 'currencySymbol')
  final String? currencySymbol;

  /// rate conversion to USD
  @JsonKey(name: 'rateUsd', fromJson: _stringToDouble)
  final double rateUsd;

  /// type of currency - fiat or crypto
  @JsonKey(name: 'type')
  final String type;

  static RateModel fromJson(Map<String, dynamic> json) {
    return _$RateModelFromJson(json);
  }

  static double _stringToDouble(String value) {
    return double.tryParse(value) ?? 0;
  }
}
