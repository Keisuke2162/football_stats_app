import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateManager {

  // beginning date of this month
  DateTime firstDate() {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, now.month, 1);

    return firstDate;
  }

  // last date of this month
  DateTime lastDate() {
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year, now.month + 1, 0);

    return lastDate;
  }

  // DateTime to String
  String dateString(DateTime date) {
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String dateStr = outputFormat.format(date);

    return dateStr;
  }

  //
  String sentTimeFormat(String dateStr) {
    DateTime datetime = DateTime.parse(dateStr);
    var formatter = new DateFormat('HH:mm');
    var formattedStr = formatter.format(datetime);

    return formattedStr;
  }

  String sentDateFormat(String dateStr) {
    DateTime datetime = DateTime.parse(dateStr);
    var formatter = new DateFormat('yyyy/MM/dd E');
    var formattedStr = formatter.format(datetime);

    return formattedStr;
  }
}

