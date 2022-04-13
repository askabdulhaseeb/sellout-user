import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/main_bottom_nav_bar_provider.dart';
import 'custom_widgets/custom_network_image.dart';
import 'video_widget.dart';

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
    return CarouselSlider(
      items: urls
          .map((ProductURL proDetail) => _Attachment(
                url: proDetail,
                totalLength: urls.length,
              ))
          .toList(),
      options: CarouselOptions(
        aspectRatio: 4 / 3,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
    );
  }
}

class _Attachment extends StatelessWidget {
  const _Attachment({required this.url, required this.totalLength, Key? key})
      : super(key: key);
  final ProductURL url;
  final int totalLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: url.isVideo
                ? Consumer<AppProvider>(
                    builder: (_, AppProvider prvider, __) => VideoWidget(
                      videoUrl: url.url,
                      isMute: prvider.isMute,
                    ),
                  )
                : InteractiveViewer(
                    child: CustomNetworkImage(
                      imageURL: url.url,
                    ),
                  ),
          ),
          if (totalLength > 1)
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
                '${url.index + 1}/$totalLength',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
