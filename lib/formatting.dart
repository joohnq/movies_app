import 'package:intl/intl.dart';

class Formating {
  static String formatDate(String date) {
    return DateFormat('dd/MM/yyyy').format(
      DateTime.parse(date),
    );
  }
}

// String formatDolar(String inputDolar) {
//   return NumberFormat.currency(
//     locale: 'en_US',
//     symbol: '\$',
//   ).format(inputDolar);
// }
