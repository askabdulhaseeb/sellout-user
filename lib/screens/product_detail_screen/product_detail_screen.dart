import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../enums/delivery_type.dart';
import '../../enums/product_condition.dart';
import '../../models/app_user.dart';
import '../../models/product.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_slideable_image.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/custom_widgets/custom_rating_stars.dart';
import '../main_screen/pages/messages/personal/product_chat_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    required this.product,
    required this.user,
    Key? key,
  }) : super(key: key);
  final Product product;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    const TextStyle _boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: product.pid,
              child: CustomSlidableURLsTile(urls: product.prodURL),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _boldTextStyle,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        product.location!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: <Widget>[
                        CustomProfileImage(imageURL: user.imageURL ?? ''),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.displayName ?? 'null',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: _boldTextStyle,
                              ),
                              CustomRatingStars(rating: user.rating ?? 0),
                            ],
                          ),
                        ),
                        Text(
                          Utilities.timeInWords(product.timestamp ?? 0),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _TitleAndDetail(
                        title: 'Price',
                        subtitle: product.price.toString(),
                      ),
                      _TitleAndDetail(
                        title: 'Condition',
                        subtitle: ProdConditionEnumConvertor.enumToString(
                          condition: product.condition,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _TitleAndDetail(
                        title: 'Delivery Fee',
                        subtitle: product.deliveryFree.toString(),
                      ),
                      _TitleAndDetail(
                        title: 'Type',
                        subtitle: DeliveryTypeEnumConvertor.enumToString(
                          delivery: product.delivery,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${product.categories[0]}, ${product.subCategories[0]}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(),
                  if (product.description != '')
                    const Text(
                      'About Product',
                      style: _boldTextStyle,
                    ),
                  Text(product.description),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomElevatedButton(
              title: 'Make Offer',
              onTap: () {},
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<ProductChatScreen>(
                    builder: (BuildContext context) => ProductChatScreen(
                      otherUser: user,
                      chatID: '${AuthMethods.uid}${product.pid}',
                      product: product,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.message_outlined, color: Colors.white),
            ),
            CustomElevatedButton(
              title: 'Buy Now',
              onTap: () {},
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleAndDetail extends StatelessWidget {
  const _TitleAndDetail({required this.title, required this.subtitle, Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    TextStyle _boldTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.labelLarge!.color,
    );
    TextStyle _simpleTextStyle = TextStyle(
      color: Theme.of(context).textTheme.labelLarge!.color,
      fontWeight: FontWeight.w500,
    );
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: '$title: ', style: _boldTextStyle),
          TextSpan(
            text: subtitle,
          ),
        ],
        style: _simpleTextStyle,
      ),
    );
  }
}
