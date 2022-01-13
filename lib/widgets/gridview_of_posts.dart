import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class GridViewOfPosts extends StatelessWidget {
  const GridViewOfPosts({required this.posts, Key? key}) : super(key: key);
  final List<String> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          // TODO: show details
        },
        child: ExtendedImage.network(
          'posts[index].experiences.first.mediaUrl', // TODO: show images
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
