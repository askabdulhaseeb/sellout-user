import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../functions/time_date_functions.dart';
import '../../models/app_user.dart';
import '../../models/my_notification.dart';
import '../../providers/prod_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const String routeName = '/NotificationScreen';
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _tabs = <Widget>[
    const Text(
      'REQUEST',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    ),
    const Text(
      'MENTIONS',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
    ),
    const Text(
      'SHARED',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    ),
  ];
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          labelColor: Theme.of(context).primaryColor,
          indicatorColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: _tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          _Request(),
          _Mention(),
          _Share(),
        ],
      ),
    );
  }
}

class _Request extends StatelessWidget {
  const _Request({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext context, int index) {
        return NotificationTile(
          trailing: SizedBox(
            width: 130,
            height: 40,
            child: CustomElevatedButton(
              onTap: () {},
              title: 'Support back',
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          notification: MyNotification(
            id: index.toString(),
            title: 'Title $index',
            subtitle: 'subtitle of $index',
            postID: '',
            by: AuthMethods.uid,
            to: AuthMethods.uid,
            timestamp: TimeDateFunctions.timestamp,
          ),
        );
      },
    );
  }
}

class _Mention extends StatelessWidget {
  const _Mention({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext context, int index) {
        return NotificationTile(
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: Consumer<ProdProvider>(
              builder: (BuildContext context, ProdProvider prodPro, _) {
                return CustomProfileImage(
                  imageURL: prodPro.product('1642719050404486').thumbnail,
                );
              },
            ),
          ),
          notification: MyNotification(
            id: index.toString(),
            title: 'Title $index',
            subtitle: 'subtitle of $index',
            postID: '1642719050404486',
            by: AuthMethods.uid,
            to: AuthMethods.uid,
            timestamp: TimeDateFunctions.timestamp,
          ),
        );
      },
    );
  }
}

class _Share extends StatelessWidget {
  const _Share({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext context, int index) {
        return NotificationTile(
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: Consumer<ProdProvider>(
              builder: (BuildContext context, ProdProvider prodPro, _) {
                return CustomProfileImage(
                  imageURL: prodPro.product('1642719050404486').thumbnail,
                );
              },
            ),
          ),
          notification: MyNotification(
            id: index.toString(),
            title: 'Title $index',
            subtitle: 'subtitle of $index',
            postID: '',
            by: AuthMethods.uid,
            to: AuthMethods.uid,
            timestamp: TimeDateFunctions.timestamp,
          ),
        );
      },
    );
  }
}
