import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/auth_methods.dart';
import '../../../database/chat_api.dart';
import '../../../enums/messages/message_tabbar_enum.dart';
import '../../../models/app_user.dart';
import '../../../providers/message_page_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/messages/message_person_search.dart';
import '../../message_screens/group/create_group_screen.dart';
import '../../message_screens/group/group_chat_dashboard.dart';
import '../../message_screens/personal/personal_chat_dashboard.dart';
import '../../message_screens/personal/personal_chat_screen.dart';
import '../../message_screens/stories/stories_dashboard.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessagePageProvider _page = Provider.of<MessagePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messenger',
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
                    (_page.currentTab == MessageTabBarEnum.CHATS)
                        ? _showSupporters(context)
                        : Navigator.of(context)
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

  PersistentBottomSheetController<dynamic> _showSupporters(
      BuildContext context) {
    return showBottomSheet(
      context: context,
      enableDrag: true,
      builder: (BuildContext context) => Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider provider, _) {
        final List<AppUser> _supporters =
            provider.supporters(uid: AuthMethods.uid);
        return Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                IconButton(
                  splashRadius: 20,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.adaptive.arrow_back_rounded),
                ),
                const Text(
                  'New Chat',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: _supporters.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute<PersonalChatScreen>(
                        builder: (_) => PersonalChatScreen(
                          otherUser: _supporters[index],
                          chatID: ChatAPI.getChatID(
                            othersUID: _supporters[index].uid,
                          ),
                        ),
                      ),
                    );
                  },
                  leading: CustomProfileImage(
                    imageURL: _supporters[index].imageURL ?? '',
                  ),
                  title: Text(
                    _supporters[index].displayName ?? 'Name fetching issue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    _supporters[index].bio ?? 'Bio fetching issue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
