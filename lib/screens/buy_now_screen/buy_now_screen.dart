import 'package:flutter/material.dart';

import '../../enums/delivery_type.dart';
import '../../models/product.dart';
import '../../utilities/app_images.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_slideable_image.dart';

class BuyNowScreen extends StatelessWidget {
  const BuyNowScreen({required this.product, Key? key}) : super(key: key);
  static const String routeName = '/BuyNowScreen';
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Product_Info(product: product),
            const SizedBox(height: 16),
            const Text(
              'Select a payment method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _ImageIconButton(
                  imagePath: AppImages.paypal,
                  title: 'PayPal',
                  onTap: () {},
                ),
                _ImageIconButton(
                  imagePath: AppImages.strip,
                  title: 'Strip',
                  onTap: () {},
                ),
                _ImageIconButton(
                  imagePath: AppImages.applePay,
                  title: 'Apple Pay',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageIconButton extends StatelessWidget {
  const _ImageIconButton({
    required this.imagePath,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _Product_Info extends StatelessWidget {
  const _Product_Info({required this.product, Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    const double _imageSize = 140;
    return SizedBox(
      height: _imageSize + 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: _imageSize,
            height: _imageSize,
            child: Hero(
              tag: product.pid,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomSlidableURLsTile(
                  urls: product.prodURL,
                  width: _imageSize,
                  height: _imageSize,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SelectableText(
                    product.title,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Type: ${DeliveryTypeEnumConvertor.enumToString(
                      delivery: product.delivery,
                    )}',
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        product.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
