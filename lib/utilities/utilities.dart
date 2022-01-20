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
}
