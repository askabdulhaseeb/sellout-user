import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sellout/screens/bet_pages/broadcast_page.dart';

import '../../../functions/time_date_functions.dart';
import '../../../providers/auction_provider.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../go_live_page/go_live_page.dart';

class LiveBetPage extends StatelessWidget {
  const LiveBetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuctionProvider provider = Provider.of<AuctionProvider>(context);
    provider.init();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Live Bid',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () {
                  Navigator.of(context).pushNamed(GoLivePage.routeName);
                },
                label: const Text('Go Live'),
              ),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              child: provider.auctions.isEmpty
                  ? const Center(child: Text('No Bit Available'))
                  : ListView.builder(
                      itemCount: provider.auctions.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        onTap: () async {
                          await <Permission>[
                            Permission.camera,
                            Permission.microphone
                          ].request();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BroadcastPage(
                                auction: provider.auctions[index],
                              ),
                            ),
                          );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute<AuctionDetailScreen>(
                          //     builder: (_) => AuctionDetailScreen(
                          //       auction: provider.auctions[index],
                          //     ),
                          //   ),
                          // );
                        },
                        leading: CustomProfileImage(
                          imageURL: provider.auctions[index].thumbnail,
                        ),
                        title: Text(provider.auctions[index].name),
                        subtitle: Text(
                          TimeDateFunctions.timeInWords(
                              provider.auctions[index].timestamp),
                        ),
                      ),
                    ),
              onRefresh: () => provider.refresh(),
            ),
          ),
        ],
      ),
    );
  }
}
