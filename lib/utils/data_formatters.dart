import 'package:intl/intl.dart';

class DataFormatters {
  static String formatDate(DateTime date) {
    final strDate =
        DateFormat(date.year == DateTime.now().year ? 'dd/MM' : 'dd/MM/y')
            .format(date);
    final strTime = DateFormat('H:mm:ss').format(date);

    return '$strDate - $strTime';
  }
}
