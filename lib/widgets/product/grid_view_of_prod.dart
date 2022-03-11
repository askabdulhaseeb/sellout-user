import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/user_provider.dart';
import '../../screens/product_detail_screen/product_detail_screen.dart';
import '../video_widget.dart';

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
      primary: false,
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<ProductDetailScreen>(
              builder: (_) => ProductDetailScreen(
                product: posts[index],
                user: Provider.of<UserProvider>(context).user(
                  uid: posts[index].uid,
                ),
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
                child: posts[index].prodURL[0].isVideo
                    ? VideoWidget(
                        videoUrl: posts[index].prodURL[0].url,
                        isMute: true,
                        isPause: true,
                      )
                    : ExtendedImage.network(
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
