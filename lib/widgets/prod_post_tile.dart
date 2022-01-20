import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utilities/utilities.dart';
import 'custom_elevated_button.dart';
import 'show_info_dialog.dart';
import 'circular_profile_image.dart';

class ProdPostTile extends StatelessWidget {
  const ProdPostTile({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _headerSection(context),
          _imageSection(_width),
          SizedBox(
            width: _width - (Utilities.padding * 2),
            child: _infoCard(),
          ),
          _buttonSection(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Padding _buttonSection(BuildContext context) {
    const EdgeInsetsGeometry _padding = EdgeInsets.symmetric(vertical: 8);
    const EdgeInsetsGeometry _margin = EdgeInsets.symmetric(vertical: 3);
    const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
      child: Column(
        children: <Widget>[
          CustomElevatedButton(
            padding: _padding,
            margin: _margin,
            textStyle: _textStyle,
            title: 'Buy Now',
            onTap: () {
              // TODO: Buy Now Button click
              showInfoDialog(
                context,
                title: 'Next Milestone',
                message: 'This is a part of next milestone',
              );
            },
          ),
          product.acceptOffers
              ? CustomElevatedButton(
                  padding: _padding,
                  margin: _margin,
                  textStyle: _textStyle,
                  title: 'Make Offer',
                  onTap: () {
                    // TODO: Make Offer Button click
                    showInfoDialog(
                      context,
                      title: 'Next Milestone',
                      message: 'This is a part of next milestone',
                    );
                  },
                )
              : const SizedBox(),
          CustomElevatedButton(
            padding: _padding,
            margin: _margin,
            bgColor: Colors.transparent,
            border: Border.all(color: Theme.of(context).primaryColor),
            textStyle: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
            title: 'Message Seller',
            onTap: () {
              // TODO: Message Seller Button click
              showInfoDialog(
                context,
                title: 'Next Milestone',
                message: 'This is a part of next milestone',
              );
            },
          ),
        ],
      ),
    );
  }

  Card _infoCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  product.price.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 12,
                ),
                SizedBox(width: 4),
                Text(
                  'Location here',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  AspectRatio _imageSection(double width) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.prodURL.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width,
            child: ExtendedImage.network(
              product.prodURL[index].url,
            ),
          );
        },
      ),
    );
  }

  Padding _headerSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Utilities.padding / 2, horizontal: Utilities.padding),
      child: Row(
        children: <Widget>[
          const CircularProfileImage(imageURL: ''),
          const SizedBox(width: 10),
          const Text(
            'Username',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: Notification Seller Button click
              showInfoDialog(
                context,
                title: 'Next Milestone',
                message: 'This is a part of next milestone',
              );
            },
            icon: const Icon(Icons.more_vert_outlined),
          )
        ],
      ),
    );
  }
}
