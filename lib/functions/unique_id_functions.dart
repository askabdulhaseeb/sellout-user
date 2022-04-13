import '../database/auth_methods.dart';
import 'time_date_functions.dart';

class UniqueIdFunctions {
  static String notificationID(String to) {
    return '${AuthMethods.uid}${TimeDateFunctions.timestamp}$to';
  }

  static String get postID =>
      '${AuthMethods.uid}${TimeDateFunctions.timestamp}';
}
