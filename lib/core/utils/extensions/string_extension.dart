import 'package:intl/intl.dart';

extension StringExtension on String {
  String toDateTime() {
    DateTime temp = DateFormat("yyyy-MM-dd hh:mm:ss").parse(this);
    String date = DateFormat("dd/MM/yyyy hh:mm:ss").format(temp);
    return date;
  }
}
