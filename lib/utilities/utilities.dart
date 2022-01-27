class Utilities {
  static double get padding => 16;
  static double get borderRadius => 24;
  static List<String> get videosAndImages => <String>[
        'heic',
        'jpeg',
        'jpg',
        'png',
        'pjp',
        'pjpeg',
        'jfif',
        'gif',
        'mp4',
        'mov',
        'mkv',
        'qt',
        'm4p',
        'm4v',
        'mpg',
        'mpeg',
        'mpv',
        'm2v',
        '3gp',
        '3g2',
        'svi',
      ];
  static final List<String> _listOfVideoExtensions = <String>[
    'gif',
    'mp4',
    'mov',
    'mkv',
    'qt',
    'm4p',
    'm4v',
    'mpg',
    'mpeg',
    'mpv',
    'm2v',
    '3gp',
    '3g2',
    'svi',
  ];
  static bool isVideo({required String extension}) {
    if (_listOfVideoExtensions.contains(extension.toLowerCase())) {
      return true;
    }
    return false;
  }

  static String time(int timestamp) {
    DateTime now = DateTime.now();
    // DateFormat format = DateFormat('HH:mm a');
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
        time = _inMints.toStringAsFixed(0).toString() + ' minute ago';
      } else {
        time = _inMints.toStringAsFixed(0).toString() + ' minutes ago';
      }
      //
    } else if (_inHour > 0 && _inDays == 0) {
      //
      if (_inHour < 1.5) {
        time = _inHour.toStringAsFixed(0).toString() + ' hour ago';
      } else {
        time = _inHour.toStringAsFixed(0).toString() + ' hours ago';
      }
      //
    } else if (_inDays > 0 && _inDays < 7 && _inDays < 31) {
      //
      if (_inDays < 1.5) {
        time = _inDays.toStringAsFixed(0).toString() + ' day ago';
      } else {
        time = _inDays.toStringAsFixed(0).toString() + ' days ago';
      }
      //
    } else if (diff.inDays.abs() > 30 && diff.inDays.abs() < 365) {
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
