class MyNotification {
  MyNotification({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.postID,
    required this.by,
    required this.to,
    required this.timestamp,
  });

  final String id;
  final String title;
  final String subtitle;
  final String postID;
  final String by;
  final String to;
  final int timestamp;
}
