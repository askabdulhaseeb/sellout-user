import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/auth_methods.dart';
import '../../database/user_api.dart';
import '../../models/app_user.dart';
import '../../models/product.dart';
import '../../providers/main_bottom_nav_bar_provider.dart';
import '../../screens/buy_now_screen/buy_now_screen.dart';
import '../../screens/main_screen/pages/messages/personal/product_chat_screen.dart';
import '../../screens/make_offer_screen/make_offer_screen.dart';
import '../../screens/others_profile/others_profile.dart';
import '../../screens/product_detail_screen/product_detail_screen.dart';
import '../../utilities/utilities.dart';
import '../custom_slideable_image.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_profile_image.dart';
import '../custom_widgets/show_info_dialog.dart';
import '../custom_widgets/show_loading.dart';

class ProdPostTile extends StatelessWidget {
  const ProdPostTile({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: UserAPI().getInfo(uid: product.uid),
      builder: (BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else {
          if (snapshot.hasData) {
            final AppUser? _user = snapshot.data;
            return Column(
              children: <Widget>[
                _Header(product: product, user: _user!),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<ProductDetailScreen>(
                        builder: (_) =>
                            ProductDetailScreen(product: product, user: _user),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: product.pid,
                        child: CustomSlidableURLsTile(urls: product.prodURL),
                      ),
                      _InfoCard(product: product),
                    ],
                  ),
                ),
                _ButtonSection(user: _user, product: product),
                const SizedBox(height: 10),
              ],
            );
          } else {
            return const ShowLoading();
          }
        }
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
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
      ),
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({required this.user, required this.product, Key? key})
      : super(key: key);
  final AppUser user;
  final Product product;
  static const EdgeInsetsGeometry _padding = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsetsGeometry _margin = EdgeInsets.symmetric(vertical: 3);
  static const TextStyle _textStyle =
      TextStyle(color: Colors.white, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return user.uid == AuthMethods.uid
        ? const SizedBox()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
            child: Column(
              children: <Widget>[
                CustomElevatedButton(
                  padding: _padding,
                  margin: _margin,
                  textStyle: _textStyle,
                  title: 'Buy Now',
                  onTap: () {
                    if (user.displayName == null || user.displayName == '') {
                      return;
                    }
                    Navigator.of(context)
                        .push(MaterialPageRoute<ProductChatScreen>(
                      builder: (BuildContext context) => BuyNowScreen(
                        product: product,
                      ),
                    ));
                  },
                ),
                product.acceptOffers
                    ? CustomElevatedButton(
                        padding: _padding,
                        margin: _margin,
                        textStyle: _textStyle,
                        title: 'Make Offer',
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute<ProductChatScreen>(
                            builder: (BuildContext context) => MakeOfferScreen(
                              product: product,
                              user: user,
                            ),
                          ));
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
                    if (user.displayName == null || user.displayName == '') {
                      return;
                    }
                    Navigator.of(context)
                        .push(MaterialPageRoute<ProductChatScreen>(
                      builder: (BuildContext context) => ProductChatScreen(
                        otherUser: user,
                        chatID: '${AuthMethods.uid}${product.pid}',
                        product: product,
                      ),
                    ));
                  },
                ),
              ],
            ),
          );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.product, required this.user, Key? key})
      : super(key: key);
  final Product product;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Utilities.padding / 3,
        horizontal: Utilities.padding,
      ),
      child: GestureDetector(
        onTap: () {
          user.uid == AuthMethods.uid
              ? Provider.of<MainBottomNavBarProvider>(context, listen: false)
                  .onTabTapped(4)
              : Navigator.of(context).push(
                  MaterialPageRoute<OthersProfile>(
                    builder: (BuildContext context) =>
                        OthersProfile(user: user),
                  ),
                );
        },
        child: Row(
          children: <Widget>[
            CustomProfileImage(imageURL: user.imageURL ?? ''),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.displayName ?? 'Not Found',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  Utilities.timeInWords(product.timestamp ?? 0),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
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
      ),
    );
  }
}
