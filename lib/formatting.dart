import 'package:intl/intl.dart';

class Formating {
  static String formatDate(String date) {
    if (date.isEmpty) {
      return "";
    }
    return DateFormat('dd/MM/yyyy').format(
      DateTime.parse(date),
    );
  }

  static String formatCapitalize(String string) {
    if (string == null || string.isEmpty) {
      return "";
    }
    return string[0].toUpperCase() + string.substring(1);
  }
}

// String formatDolar(String inputDolar) {
//   return NumberFormat.currency(
//     locale: 'en_US',
//     symbol: '\$',
//   ).format(inputDolar);
// }
