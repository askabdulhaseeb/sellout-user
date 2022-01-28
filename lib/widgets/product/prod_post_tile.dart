import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/models/chat.dart';
import 'package:sellout/screens/main_screen/pages/messages/personal/product_chat_screen.dart';
import 'package:sellout/widgets/custom_widgets/show_loading.dart';

import '../../database/auth_methods.dart';
import '../../database/user_api.dart';
import '../../models/app_user.dart';
import '../../models/product.dart';
import '../../providers/main_bottom_nav_bar_provider.dart';
import '../../screens/others_profile/others_profile.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_profile_image.dart';
import '../custom_widgets/show_info_dialog.dart';

class ProdPostTile extends StatelessWidget {
  const ProdPostTile({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
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
                _imageSection(_width),
                SizedBox(
                  width: _width - (Utilities.padding * 2),
                  child: _infoCard(),
                ),
                _buttonSection(context, _user),
                const SizedBox(height: 10),
              ],
            );
          } else {
            return const Expanded(child: ShowLoading());
          }
        }
      },
    );
  }

  Widget _buttonSection(BuildContext context, AppUser user) {
    const EdgeInsetsGeometry _padding = EdgeInsets.symmetric(vertical: 8);
    const EdgeInsetsGeometry _margin = EdgeInsets.symmetric(vertical: 3);
    const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16);
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
                    if (user.displayName == null || user.displayName == '')
                      return;
                    int _time = DateTime.now().microsecondsSinceEpoch;
                    Navigator.of(context)
                        .push(MaterialPageRoute<ProductChatScreen>(
                      builder: (BuildContext context) => ProductChatScreen(
                        otherUser: user,
                        chatID: '${AuthMethods.uid}$_time',
                        product: product,
                      ),
                    ));
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
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: product.prodURL.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: width,
              child: ExtendedImage.network(
                product.prodURL[index].url,
                timeLimit: const Duration(days: 2),
              ),
            );
          },
        ),
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
