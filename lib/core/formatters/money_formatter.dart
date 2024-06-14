import 'package:intl/intl.dart';

class MoneyFormatter {
  static final usDollarFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
  );
}