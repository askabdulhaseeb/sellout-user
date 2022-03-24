import 'package:flutter/material.dart';
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
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Scaffold(
        body: SizedBox(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: urls.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  SizedBox(
                    width: width ?? MediaQuery.of(context).size.width,
                    height: height ?? double.infinity,
                    child: urls[index].isVideo
                        ? Consumer<AppProvider>(
                            builder: (_, AppProvider prvider, __) =>
                                VideoWidget(
                              videoUrl: urls[index].url,
                              isMute: prvider.isMute,
                            ),
                          )
                        : InteractiveViewer(
                            child: CustomNetworkImage(
                              imageURL: urls[index].url,
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
