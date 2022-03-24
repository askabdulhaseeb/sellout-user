import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../functions/time_date_functions.dart';
import '../../../providers/auction_provider.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import 'auction_detail_screen.dart';

class LiveBetPage extends StatelessWidget {
  const LiveBetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuctionProvider _provider = Provider.of<AuctionProvider>(context);
    _provider.init();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Live Bet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                itemCount: _provider.auctions.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<AuctionDetailScreen>(
                        builder: (_) => AuctionDetailScreen(
                          auction: _provider.auctions[index],
                        ),
                      ),
                    );
                  },
                  leading: CustomProfileImage(
                    imageURL: _provider.auctions[index].thumbnail,
                  ),
                  title: Text(_provider.auctions[index].name),
                  subtitle: Text(
                    TimeDateFunctions.timeInWords(
                        _provider.auctions[index].timestamp),
                  ),
                ),
              ),
              onRefresh: () => _provider.refresh(),
            ),
          ),
        ],
      ),
    );
  }
}
