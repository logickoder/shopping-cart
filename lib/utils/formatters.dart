import 'package:intl/intl.dart';

final amountFormatter = NumberFormat.simpleCurrency(
  name: 'NGN',
  locale: 'en_NG',
);

String format(double amount) {
  return amountFormatter.format(amount * 100);
}
