// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      currencySymbol: json['currencySymbol'] as String?,
      rateUsd: RateModel._stringToDouble(json['rateUsd'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'currencySymbol': instance.currencySymbol,
      'rateUsd': instance.rateUsd,
      'type': instance.type,
    };
