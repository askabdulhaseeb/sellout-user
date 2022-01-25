import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/database/product_api.dart';
import 'package:sellout/models/product.dart';
import 'package:sellout/widgets/product/grid_view_of_prod.dart';
import '../../../database/auth_methods.dart';
import '../../../models/prod_category.dart';
import '../../../providers/product_category_provider.dart';
import '../../../services/custom_services.dart';
import '../../../services/user_local_data.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_profile_image.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_rating_stars.dart';
import '../../../widgets/custom_score_button.dart';
import '../../../widgets/product/prod_cat_dropdown.dart';
import '../../../widgets/show_info_dialog.dart';
import '../../auth/login_screen.dart';

class MyProdilePage extends StatelessWidget {
  const MyProdilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: CustomService.systemUIOverlayStyle(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                (Route<dynamic> route) => false,
              );
            },
            splashRadius: 20,
            // icon: const Icon(Icons.more_vert_rounded),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headerSection(context),
          _scoreSection(context),
          _selectionSection(context),
          const Divider(),
          _footer(),
        ],
      ),
    );
  }

  Widget _footer() {
    return Expanded(
      child: FutureBuilder<List<Product>>(
        future: ProductAPI().getPersonalProducts(uid: UserLocalData.getUID),
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
                    return const Text('NO DIGILOGS POSTED');
                  }
                } else {
                  return const Text('NO DIGILOGS POSTED');
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
    final double _boxWidth = (_totalWidth / 4) - 16;
    return Padding(
      padding: EdgeInsets.all(Utilities.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomIconButton(
            height: _boxWidth - 20,
            width: _boxWidth,
            icon: Icons.wallet_membership,
            onTap: () {
              // TODO: on wallet click
            },
          ),
          CustomScoreButton(
            score: UserLocalData.getPost.length.toString(),
            title: 'Posts',
            height: _boxWidth - 20,
            width: _boxWidth,
            onTap: () {
              // TODO: on Posts click
            },
          ),
          CustomScoreButton(
            score: UserLocalData.getSupporting.length.toString(),
            title: 'Supporting',
            height: _boxWidth - 20,
            width: _boxWidth,
            onTap: () {
              // TODO: on Supporting click
            },
          ),
          CustomScoreButton(
            score: UserLocalData.getSupporters.length.toString(),
            title: 'Supporters',
            height: _boxWidth - 20,
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
    const double _imageRadius = 40;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomProfileImage(
            imageURL: UserLocalData.getImageURL,
            radius: _imageRadius,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width:
                _totalWidth - (_imageRadius * 2) - (Utilities.padding * 2) - 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 2),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        UserLocalData.getDisplayName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        //TODO: Navigate to Edit profile
                        showInfoDialog(
                          context,
                          title: 'Next Milestone',
                          message: 'This is a part of next milestone',
                        );
                      },
                      child: Text(
                        '- Edit',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                CustomRatingStars(rating: UserLocalData.getRating),
                SizedBox(
                  width: _totalWidth / 1.6,
                  child: UserLocalData.getBio == ''
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
