import 'package:flutter/material.dart';

class CustomNetworkChangeImageBox extends StatelessWidget {
  const CustomNetworkChangeImageBox({
    required this.onTap,
    this.url,
    this.title = 'Upload Image',
    this.size = 80,
    Key? key,
  }) : super(key: key);
  final String? url;
  final String title;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: size,
              width: size,
              color: Theme.of(context).primaryColor,
              child: url == null || url == ''
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'No\nImage',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.network(url!, fit: BoxFit.cover),
                    ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Text(title, style: const TextStyle(height: 1)),
          ),
        ],
      ),
    );
  }
}
