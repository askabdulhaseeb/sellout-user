import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sellout/models/product.dart';

class GridViewOfProducts extends StatelessWidget {
  const GridViewOfProducts({required this.posts, Key? key}) : super(key: key);
  final List<Product> posts;

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
          // _provider.onUpdatedigi(posts[index]);
          // Navigator.of(context).pushNamed(DigilogView.routeName);
        },
        child: ExtendedImage.network(
          posts[index].prodURL[0].url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
