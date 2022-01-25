import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/widgets/custom_widgets/custom_elevated_button.dart';
import '../../database/product_api.dart';
import '../../models/app_user.dart';
import '../../models/prod_category.dart';
import '../../models/product.dart';
import '../../providers/product_category_provider.dart';
import '../../services/custom_services.dart';
import '../../services/user_local_data.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_widgets/custom_icon_button.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/custom_widgets/custom_rating_stars.dart';
import '../../widgets/custom_widgets/custom_score_button.dart';
import '../../widgets/private_account_widhet.dart';
import '../../widgets/product/grid_view_of_prod.dart';
import '../../widgets/product/prod_cat_dropdown.dart';

class OthersProfile extends StatelessWidget {
  const OthersProfile({required this.user, Key? key}) : super(key: key);
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: CustomService.systemUIOverlayStyle(),
        title: Text(
          user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          _headerSection(context),
          _scoreSection(context),
          _SuppoertAndMessageButton(user: user),
          (user.isPublicProfile == true)
              ? _selectionSection(context)
              : (user.uid == UserLocalData.getUID ||
                      user.supporters!.contains(UserLocalData.getUID))
                  ? _selectionSection(context)
                  : const SizedBox(),
          const Divider(),
          (user.isPublicProfile == true)
              ? _footer()
              : (user.uid == UserLocalData.getUID ||
                      user.supporters!.contains(UserLocalData.getUID))
                  ? _footer()
                  : const PrivateAccountWidget(),
        ],
      ),
    );
  }

  Widget _footer() {
    return Expanded(
      child: FutureBuilder<List<Product>>(
        future: ProductAPI().getProductsByUID(uid: user.uid),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CircularProgressIndicator.adaptive(),
              );
            default:
              if ((snapshot.hasError)) {
                return const Text('Error');
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return GridViewOfProducts(posts: snapshot.data!);
                  } else {
                    return const Center(
                      child: Text(
                        'No product posted yet!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text(
                      'No product posted yet!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }

  Widget _selectionSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomIconButton(
            icon: Icons.card_travel,
            height: 50,
            width: 80,
            onTap: () {
              //TODO: on bag click
            },
          ),
          const SizedBox(width: 8),
          Consumer<ProdCatProvider>(
            builder: (BuildContext context, ProdCatProvider cat, _) => Flexible(
              child: SizedBox(
                height: 34,
                child: ProdCatDropdown(
                  items: cat.category,
                  selectedItem: cat.selectedCategroy,
                  padding: const EdgeInsets.only(bottom: 14, left: 8, right: 8),
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  onChanged: (ProdCategory? update) =>
                      cat.updateCatSelection(update!),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              // TODO: on cart click
            },
            padding: const EdgeInsets.all(0),
            splashRadius: 24,
            icon: const Icon(CupertinoIcons.shopping_cart, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _scoreSection(BuildContext context) {
    final double _totalWidth = MediaQuery.of(context).size.width;
    final double _boxWidth = (_totalWidth / 4) - 14;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: Utilities.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomIconButton(
            height: _boxWidth - 10,
            width: _boxWidth,
            icon: Icons.wallet_membership,
            onTap: () {
              // TODO: on wallet click
            },
          ),
          CustomScoreButton(
            score: user.posts?.length.toString() ?? '-',
            title: 'Posts',
            height: _boxWidth - 10,
            width: _boxWidth,
            onTap: () {
              // TODO: on Posts click
            },
          ),
          CustomScoreButton(
            score: user.supporting?.length.toString() ?? '-',
            title: 'Supporting',
            height: _boxWidth - 10,
            width: _boxWidth,
            onTap: () {
              // TODO: on Supporting click
            },
          ),
          CustomScoreButton(
            score: user.supporters?.length.toString() ?? '-',
            title: 'Supporters',
            height: _boxWidth - 10,
            width: _boxWidth,
            onTap: () {
              // TODO: on Supporters click
            },
          ),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final double _totalWidth = MediaQuery.of(context).size.width;
    const double _imageRadius = 50;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomProfileImage(
            imageURL: user.imageURL!,
            radius: _imageRadius,
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: _totalWidth - (_imageRadius) - (Utilities.padding * 2) - 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 2),
                Text(
                  user.displayName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomRatingStars(rating: UserLocalData.getRating),
                SizedBox(
                  width: _totalWidth / 1.6,
                  child: user.bio == ''
                      ? const Text(
                          'No Bio',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          UserLocalData.getBio,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SuppoertAndMessageButton extends StatefulWidget {
  const _SuppoertAndMessageButton({required this.user, Key? key})
      : super(key: key);

  final AppUser user;

  @override
  State<_SuppoertAndMessageButton> createState() =>
      _SuppoertAndMessageButtonState();
}

class _SuppoertAndMessageButtonState extends State<_SuppoertAndMessageButton> {
  static const double _height = 32;
  final BorderRadius _borderRadius = BorderRadius.circular(4);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: Utilities.padding),
      child: Row(
        children: <Widget>[
          Flexible(
            child: _supportButton(),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: InkWell(
              onTap: () async {},
              child: Container(
                height: _height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('Message'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _supportButton() {
    return (widget.user.supporters?.contains(UserLocalData.getUID) ?? false)
        ? CustomElevatedButton(
            title: 'Supporting',
            onTap: () {},
            bgColor: Colors.grey[300],
            borderRadius: _borderRadius,
          )
        : (widget.user.supporting?.contains(UserLocalData.getUID) ?? false)
            ? CustomElevatedButton(
                title: 'Support Back',
                onTap: () {},
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(7.5),
                textStyle: const TextStyle(color: Colors.white),
                borderRadius: _borderRadius,
              )
            : CustomElevatedButton(
                title: 'Support',
                onTap: () {},
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(7.5),
                textStyle: const TextStyle(color: Colors.white),
                borderRadius: _borderRadius,
              );
  }
}