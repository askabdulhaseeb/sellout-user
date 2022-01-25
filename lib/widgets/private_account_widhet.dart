import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivateAccountWidget extends StatelessWidget {
  const PrivateAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          const Icon(CupertinoIcons.eye_slash_fill, size: 38),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'This account is private',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Only Supprters can see their photos and videos',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
