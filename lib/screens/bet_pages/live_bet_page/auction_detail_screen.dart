import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/auction_api.dart';
import '../../../database/auth_methods.dart';
import '../../../functions/time_date_functions.dart';
import '../../../models/app_user.dart';
import '../../../models/auction.dart';
import '../../../models/bet.dart';
import '../../../providers/user_provider.dart';
import '../../../services/custom_services.dart';
import '../../../utilities/app_images.dart';
import '../../../utilities/custom_validators.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_network_image.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/custom_score_button.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class AuctionDetailScreen extends StatefulWidget {
  const AuctionDetailScreen({
    required this.auction,
    Key? key,
  }) : super(key: key);
  final Auction auction;

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  final TextEditingController _offer = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    _offer.text = widget.auction.startingPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppUser _user =
        Provider.of<UserProvider>(context).user(uid: widget.auction.uid);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: Row(
          children: <Widget>[
            CustomProfileImage(imageURL: _user.imageURL ?? ''),
            const SizedBox(width: 10),
            Text(_user.displayName ?? 'name fetching issue'),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => CustomService.dismissKeyboard(),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CustomNetworkImage(imageURL: AppImages.doneURL),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream:
                          AuctionAPI().streamAuction(auction: widget.auction),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot,
                      ) {
                        if (snapshot.hasData) {
                          Auction _auctionStream =
                              Auction.fromDoc(snapshot.data!);
                          return Column(
                            children: <Widget>[
                              _AuctionInfo(auction: _auctionStream),
                              const SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    splashRadius: 20,
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller: _offer,
                                      readOnly: _isLoading,
                                      validator: (String? value) =>
                                          CustomValidator.greaterThen(
                                        value,
                                        _auctionStream.startingPrice,
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    splashRadius: 20,
                                    icon: const Icon(
                                      Icons.add_circle_outlined,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _isLoading
                                  ? const ShowLoading()
                                  : CustomElevatedButton(
                                      title: 'Bet Now',
                                      onTap: () async {
                                        if (_key.currentState!.validate()) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          final Bet _newBet = Bet(
                                            uid: AuthMethods.uid,
                                            amount: double.parse(_offer.text),
                                            timestamp:
                                                TimeDateFunctions.timestamp,
                                          );
                                          _auctionStream.bets!.add(_newBet);
                                          await AuctionAPI().updateBet(
                                              auction: _auctionStream);
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      },
                                    ),
                            ],
                          );
                        } else {
                          return (snapshot.hasError)
                              ? const Center(
                                  child: Text('Facing some error'),
                                )
                              : _AuctionInfo(auction: widget.auction);
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuctionInfo extends StatelessWidget {
  const _AuctionInfo({required this.auction, Key? key}) : super(key: key);
  final Auction auction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          auction.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomScoreButton(
              score: auction.bets!.length.toString(),
              title: 'No. of Bets',
              height: 60,
              width: 90,
              onTap: () {},
            ),
            CustomScoreButton(
              score: auction.startingPrice.toString(),
              title: 'Starting price',
              height: 60,
              width: 90,
              onTap: () {},
            ),
            CustomScoreButton(
              score: auction.bets!.length.toString(),
              title: 'New Price',
              height: 60,
              width: 90,
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
