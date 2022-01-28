import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../enums/messages/message_tabbar_enum.dart';
import '../../../../providers/message_page_provider.dart';
import '../../../../widgets/messages/message_person_search.dart';
import 'group/create_group_screen.dart';
import 'group/group_chat_dashboard.dart';
import 'personal/personal_chat_dashboard.dart';
import 'stories/stories_dashboard.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessagePageProvider _page = Provider.of<MessagePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                MessagesPersonSearch(
                  onChanged: (String? value) {},
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CreateChatGroupScreen.routeName);
                  },
                  splashRadius: 16,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.forum_rounded),
                ),
              ],
            ),
          ),
          _TabBar(page: _page),
          Expanded(
            child: (_page.currentTab == MessageTabBarEnum.CHATS)
                ? const PersonalChatDashboard()
                : (_page.currentTab == MessageTabBarEnum.GROUPS)
                    ? const GroupChatDashboaed()
                    : const StoriesDashboard(),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required MessagePageProvider page, Key? key})
      : _page = page,
        super(key: key);

  final MessagePageProvider _page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TabBarIconButton(
            icon: Icons.perm_contact_cal,
            title: 'Chats',
            isSelected: _page.currentTab == MessageTabBarEnum.CHATS,
            onTab: () {
              _page.updateTab(MessageTabBarEnum.CHATS);
            },
          ),
          TabBarIconButton(
            icon: Icons.groups_rounded,
            title: 'Groups',
            isSelected: _page.currentTab == MessageTabBarEnum.GROUPS,
            onTab: () {
              _page.updateTab(MessageTabBarEnum.GROUPS);
            },
          ),
          TabBarIconButton(
            icon: Icons.blur_circular_sharp,
            title: 'Stories',
            isSelected: _page.currentTab == MessageTabBarEnum.STORIES,
            onTab: () {
              _page.updateTab(MessageTabBarEnum.STORIES);
            },
          ),
        ],
      ),
    );
  }
}

class TabBarIconButton extends StatelessWidget {
  const TabBarIconButton({
    required this.onTab,
    required this.icon,
    required this.title,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);
  final bool isSelected;
  final IconData icon;
  final String title;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    final Color? _color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).iconTheme.color;
    return GestureDetector(
      onTap: onTab,
      child: Column(
        children: <Widget>[
          Icon(icon, color: _color),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: _color),
          ),
        ],
      ),
    );
  }
}
