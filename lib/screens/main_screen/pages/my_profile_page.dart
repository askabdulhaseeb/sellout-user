import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/database/auth_methods.dart';
import 'package:sellout/models/product_category.dart';
import 'package:sellout/providers/product_category_provider.dart';
import 'package:sellout/screens/auth/login_screen.dart';
import 'package:sellout/services/user_local_data.dart';
import 'package:sellout/utilities/utilities.dart';
import 'package:sellout/widgets/circular_profile_image.dart';
import 'package:sellout/widgets/prod_cat_dropdown.dart';
import 'package:sellout/widgets/custom_icon_button.dart';
import 'package:sellout/widgets/custom_rating_stars.dart';
import 'package:sellout/widgets/custom_score_button.dart';

class MyProdilePage extends StatelessWidget {
  const MyProdilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          _footer(context),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Container();
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
            width: 100,
            onTap: () {
              //TODO: on bag click
            },
          ),
          Consumer<ProdCatProvider>(
            builder: (BuildContext context, ProdCatProvider cat, _) =>
                ProdCatDropdown(
              items: cat.category,
              selectedItem: cat.selectedCategroy,
              onChanged: (ProdCategory? update) => cat.updateSelection(update!),
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: on cart click
            },
            padding: const EdgeInsets.all(0),
            splashRadius: 24,
            icon: const Icon(CupertinoIcons.shopping_cart, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _scoreSection(BuildContext context) {
    final double _totalWidth = MediaQuery.of(context).size.width;
    final double _boxWidth = (_totalWidth / 4) - 30;
    return Padding(
      padding: EdgeInsets.all(Utilities.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CustomIconButton(
            height: _boxWidth,
            width: _boxWidth,
            icon: Icons.wallet_membership,
            onTap: () {
              // TODO: on wallet click
            },
          ),
          CustomScoreButton(
            score: UserLocalData.getPost.length.toString(),
            title: 'Posts',
            height: _boxWidth,
            width: _boxWidth,
            onTap: () {
              // TODO: on Posts click
            },
          ),
          CustomScoreButton(
            score: UserLocalData.getSupporting.length.toString(),
            title: 'Supporting',
            height: _boxWidth,
            width: _boxWidth,
            onTap: () {
              // TODO: on Supporting click
            },
          ),
          CustomScoreButton(
            score: UserLocalData.getSupporters.length.toString(),
            title: 'Supporters',
            height: _boxWidth,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircularProfileImage(
            imageURL: UserLocalData.getImageURL,
            radious: 34,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: _totalWidth / 2.5,
                    child: Text(
                      UserLocalData.getDisplayName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //TODO: Navigate to Edit profile
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              CustomRatingStars(rating: UserLocalData.getRating),
              SizedBox(
                width: _totalWidth / 1.8,
                child: Text(
                  UserLocalData.getBio + 'Bio',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
