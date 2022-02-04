import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../database/product_api.dart';
import '../../database/user_api.dart';
import '../../models/app_user.dart';
import '../../models/chat.dart';
import '../../models/product.dart';
import '../../screens/main_screen/pages/messages/personal/product_chat_screen.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_profile_image.dart';
import '../custom_widgets/show_loading.dart';

class ProductChatDashboardTile extends StatelessWidget {
  const ProductChatDashboardTile({required this.chat, Key? key})
      : super(key: key);
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: UserAPI().getInfo(
          uid: chat.persons[chat.persons
              .indexWhere((String element) => element != AuthMethods.uid)]),
      builder: (_, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.hasError) {
          return const _ErrorWidget();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShowLoading();
          } else {
            final AppUser _user = snapshot.data!;
            return FutureBuilder<Product?>(
                future: ProductAPI().getProductByPID(pid: chat.pid!),
                builder: (_, AsyncSnapshot<Product?> snap) {
                  if (snap.hasError) {
                    return const _ErrorWidget();
                  } else {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const ShowLoading();
                    } else {
                      final Product _product = snap.data!;
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<ProductChatScreen>(
                              builder: (_) => ProductChatScreen(
                                otherUser: _user,
                                chatID: chat.chatID,
                                product: _product,
                              ),
                            ),
                          );
                        },
                        dense: true,
                        leading: Stack(
                          children: <Widget>[
                            CustomProfileImage(
                              imageURL: _product
                                  .prodURL[_product.prodURL.indexWhere(
                                      (ProductURL element) =>
                                          element.isVideo == false)]
                                  .url,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CustomProfileImage(
                                imageURL: _user.imageURL ?? '',
                                radius: 28,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          _user.displayName ?? 'issue',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          Utilities.timeInDigits(chat.timestamp),
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }
                  }
                });
          }
        }
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Text(
            'Some thing goes wrong',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
