import 'package:intl/intl.dart';

String formattedDate(DateTime date) {
  return DateFormat("d MM, yyyy").format(date);
}
