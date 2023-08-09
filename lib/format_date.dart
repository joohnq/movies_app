import 'package:intl/intl.dart';

String formatDate(String inputDate) {
  DateTime date = DateTime.parse(inputDate);
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  String formattedDate = formatter.format(date);
  return formattedDate;
}