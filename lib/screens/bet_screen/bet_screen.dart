import 'package:flutter/material.dart';
import '../bet_pages/explore_page/explore_page.dart';
import '../bet_pages/live_bet_page/live_bet_page.dart';

class BetScreen extends StatelessWidget {
  const BetScreen({Key? key}) : super(key: key);
  static const String routeName = '/BitScreen';

  static const List<Widget> _tabs = <Widget>[
    Tab(icon: Icon(Icons.live_tv)),
    Tab(icon: Icon(Icons.explore)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicatorColor: Theme.of(context).scaffoldBackgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            automaticIndicatorColorAdjustment: true,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).iconTheme.color,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            LiveBetPage(),
            ExplorePage(),
          ],
        ),
      ),
    );
  }
}
