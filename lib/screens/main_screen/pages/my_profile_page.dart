import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/auth_methods.dart';
import '../../../database/product_api.dart';
import '../../../functions/user_bottom_sheets.dart';
import '../../../models/prod_category.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/product_category_provider.dart';
import '../../../services/custom_services.dart';
import '../../../services/user_local_data.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_icon_button.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/custom_rating_stars.dart';
import '../../../widgets/custom_widgets/custom_score_button.dart';
import '../../../widgets/product/grid_view_of_prod.dart';
import '../../../widgets/product/prod_cat_dropdown.dart';
import '../../auth/login_screen.dart';
import '../../edit_profile/edit_profile_screen.dart';

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
              Provider.of<UserProvider>(context, listen: false).reset();
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
        future: ProductAPI().getProductsByUID(uid: AuthMethods.uid),
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
                return const Center(
                  child: Text('Facing some issues while feching posts'),
                );
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return GridViewOfProducts(
                      posts: snapshot.data!,
                    );
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
            icon: Icons.festival_rounded,
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
                height: 38,
                child: ProdCatDropdown(
                  items: cat.category,
                  selectedItem: cat.selectedCategroy,
                  padding: const EdgeInsets.only(bottom: 14, left: 8, right: 8),
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  borderRadius: BorderRadius.circular(10),
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
    final double totalWidth = MediaQuery.of(context).size.width;
    final double boxWidth = (totalWidth / 4) - 14;
    UserProvider provider = Provider.of<UserProvider>(context);
    return Builder(
      builder: (BuildContext context) => Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomIconButton(
              height: boxWidth - 10,
              width: boxWidth,
              icon: Icons.account_balance,
              onTap: () {
                // TODO: on wallet click
              },
            ),
            CustomScoreButton(
              score: UserLocalData.getPost.length.toString(),
              title: 'Posts',
              height: boxWidth - 10,
              width: boxWidth,
              onTap: () {
                // TODO: on Posts click
              },
            ),
            CustomScoreButton(
              score: UserLocalData.getSupporting.length.toString(),
              title: 'Supporting',
              height: boxWidth - 10,
              width: boxWidth,
              onTap: () {
                UserBottomSheets().showUsersBottomSheet(
                  context: context,
                  title: 'Supporting',
                  showBackButton: false,
                  users: provider.supportings(uid: AuthMethods.uid),
                );
              },
            ),
            CustomScoreButton(
              score: UserLocalData.getSupporters.length.toString(),
              title: 'Supporters',
              height: boxWidth - 10,
              width: boxWidth,
              onTap: () {
                UserBottomSheets().showUsersBottomSheet(
                  context: context,
                  title: 'Supporters',
                  showBackButton: false,
                  users: provider.supporters(uid: AuthMethods.uid),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final double totalWidth = MediaQuery.of(context).size.width;
    const double imageRadius = 60;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomProfileImage(
            imageURL: UserLocalData.getImageURL,
            radius: imageRadius,
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: totalWidth - (imageRadius) - (Utilities.padding * 2) - 56,
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
                        Navigator.of(context)
                            .pushNamed(EditProfileScreen.routeName);
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
                  width: totalWidth / 1.6,
                  child: UserLocalData.getBio == ''
                      ? const Text('No Bio')
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
