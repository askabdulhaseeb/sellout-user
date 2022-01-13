import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sellout/utilities/app_images.dart';

class CircularProfileImage extends StatelessWidget {
  const CircularProfileImage({
    required this.imageURL,
    this.radious = 30,
    Key? key,
  }) : super(key: key);
  final String imageURL;
  final double radious;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radious,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        radius: radious - 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: CircleAvatar(
          radius: radious - 4,
          backgroundColor: Theme.of(context).primaryColor,
          child: imageURL.isEmpty
              ? const FittedBox(
                  child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'No\nImage',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ))
              : ExtendedImage.network(
                  imageURL,
                  width: radious * 2,
                  height: radious * 2,
                  fit: BoxFit.cover,
                  cache: true,
                  shape: BoxShape.circle,
                ),
        ),
      ),
    );
  }
}
