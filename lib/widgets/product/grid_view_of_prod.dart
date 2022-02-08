import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../models/app_user.dart';
import '../../models/product.dart';
import '../../screens/product_detail_screen/product_detail_screen.dart';

class GridViewOfProducts extends StatelessWidget {
  const GridViewOfProducts({required this.posts, required this.user, Key? key})
      : super(key: key);
  final List<Product> posts;
  final AppUser user;

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
          Navigator.of(context).push(
            MaterialPageRoute<ProductDetailScreen>(
              builder: (_) => ProductDetailScreen(
                product: posts[index],
                user: user,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: posts[index].pid,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ExtendedImage.network(
                  posts[index].prodURL[0].url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
              child: Text(
                ' ${posts[index].price} - ${posts[index].title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
