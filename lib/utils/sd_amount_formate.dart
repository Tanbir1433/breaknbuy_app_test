import 'package:intl/intl.dart';

String sdAmountFormatter(double number) {
  return '৳${NumberFormat('#,##0.00').format(number)}';
}
