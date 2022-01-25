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
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: radius - 8,
        width: radius - 8,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: imageURL.isEmpty
            ? const FittedBox(
                child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'No\nImage',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ))
            : ExtendedImage.network(
                imageURL,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                cache: true,
                shape: BoxShape.circle,
              ),
      ),
    );
  }
}
