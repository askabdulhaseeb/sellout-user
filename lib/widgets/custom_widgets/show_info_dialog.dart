import 'package:flutter/cupertino.dart';

void showInfoDialog(
  BuildContext context, {
  String message =
      'This fetcher will be added before publishing the app on on App Store and Play Store.',
  String title = 'Coming Soon',
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Go Back'),
      ),
      message: Text(message),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: CupertinoColors.black,
        ),
      ),
    ),
  );
}
