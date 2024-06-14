import 'package:crypto_currency/core/core.dart';
import 'package:flutter/material.dart';
import 'package:rest_client/rest_client.dart';

class RateListItem extends StatelessWidget {
  const RateListItem({
    required this.color,
    required this.rateModel,
    super.key,
  });

  final Color color;
  final RateModel rateModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            color: color,
          ),
          const SizedBox(width: 16),
          Text(
            rateModel.symbol,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 17 / 24,
            ),
          ),
          const Spacer(),
          Text(
            MoneyFormatter.usDollarFormat.format(rateModel.rateUsd),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 17 / 24,
            ),
          ),
        ],
      ),
    );
  }
}
