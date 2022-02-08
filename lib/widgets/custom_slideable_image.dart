import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import '../models/product.dart';

class CustomSlidableURLsTile extends StatelessWidget {
  const CustomSlidableURLsTile({
    required this.urls,
    this.aspectRatio = 4 / 3,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);
  final List<ProductURL> urls;
  final double aspectRatio;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Scaffold(
        body: SizedBox(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: urls.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  SizedBox(
                    width: width ?? MediaQuery.of(context).size.width,
                    height: height ?? double.infinity,
                    child: InteractiveViewer(
                      child: ExtendedImage.network(
                        urls[index].url,
                        fit: BoxFit.cover,
                        timeLimit: const Duration(days: 2),
                      ),
                    ),
                  ),
                  if (urls.length > 1)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black45,
                      ),
                      child: Text(
                        '${index + 1}/${urls.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
