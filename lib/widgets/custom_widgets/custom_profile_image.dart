import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    required this.imageURL,
    this.radius = 40,
    Key? key,
  }) : super(key: key);
  final String imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? Container(
            height: radius,
            width: radius,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const FittedBox(
                child: Text(
              'No\nImage',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExtendedImage.network(
              imageURL,
              width: radius,
              height: radius,
              fit: BoxFit.cover,
              cache: true,
              timeLimit: const Duration(days: 1),
            ),
          );
  }
}
