import 'package:intl/intl.dart';

class TimeDateFunctions {
  static int get timestamp => DateTime.now().microsecondsSinceEpoch;

  static String timeInDigits(int timestamp) {
    DateFormat format = DateFormat('HH:mm a');
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    return format.format(date);
  }

  static String timeInWords(int timestamp) {
    DateTime now = DateTime.now();
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    Duration diff = date.difference(now);
    String time = '';

    int _inSec = diff.inSeconds.abs();
    int _inMints = diff.inMinutes.abs();
    int _inHour = diff.inHours.abs();
    int _inDays = diff.inDays.abs();

    if (_inSec <= 0 || _inSec > 0 && _inMints == 0) {
      time = 'few seconds ago';
      //
    } else if (_inMints > 0 && _inHour == 0) {
      //
      if (_inMints < 1.5) {
        time = _inMints.toStringAsFixed(0) + ' minute ago';
      } else {
        time = _inMints.toStringAsFixed(0) + ' minutes ago';
      }
      //
    } else if (_inHour > 0 && _inDays == 0) {
      //
      if (_inHour < 1.5) {
        time = _inHour.toStringAsFixed(0) + ' hour ago';
      } else {
        time = _inHour.toStringAsFixed(0) + ' hours ago';
      }
      //
    } else if (_inDays > 0 && _inDays < 7) {
      //
      if (_inDays < 1.5) {
        time = _inDays.toStringAsFixed(0) + ' day ago';
      } else {
        time = _inDays.toStringAsFixed(0) + ' days ago';
      }
      //
    } else if (_inDays >= 7 && _inDays < 30) {
      double _temp = (diff.inDays.abs() / 7);
      //
      if (_inDays < 14) {
        time = _temp.toStringAsFixed(0) + ' week ago';
      } else {
        time = _temp.toStringAsFixed(0) + ' weeks ago';
      }
      //
    } else if (diff.inDays.abs() >= 30 && diff.inDays.abs() < 365) {
      double _temp = (diff.inDays.abs() / 30);
      if (_temp < 1.5) {
        time = _temp.toStringAsFixed(0) + ' month ago';
      } else {
        time = _temp.toStringAsFixed(0) + ' months ago';
      }
    } else {
      double _temp = (diff.inDays.abs() / 365);
      if (_temp < 1.5) {
        time = _temp.toStringAsFixed(0) + ' year ago';
      } else {
        time = _temp.toStringAsFixed(0) + ' years ago';
      }
    }
    return time;
  }
}
