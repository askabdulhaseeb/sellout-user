import 'package:flutter/material.dart';

import '../bit_pages/explore_page/explore_page.dart';
import '../bit_pages/go_live_page/go_live_page.dart';
import '../bit_pages/live_bit_page/live_bit_page.dart';

class BitScreen extends StatelessWidget {
  const BitScreen({Key? key}) : super(key: key);
  static const String routeName = '/BitScreen';

  static const List<Widget> _tabs = <Widget>[
    Tab(icon: Icon(Icons.live_tv)),
    Tab(icon: Icon(Icons.explore)),
    Tab(icon: Icon(Icons.video_call_rounded)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            LiveBitPage(),
            ExplorePage(),
            GoLivePage(),
          ],
        ),
      ),
    );
  }
}
