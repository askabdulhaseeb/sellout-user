import 'package:flutter/material.dart';

class GoLivePage extends StatelessWidget {
  const GoLivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Go Live',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
