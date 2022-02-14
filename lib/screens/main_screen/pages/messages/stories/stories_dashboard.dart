import 'package:flutter/material.dart';

import '../../../../../services/user_local_data.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';

class StoriesDashboard extends StatelessWidget {
  const StoriesDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   'My Stories',
          //   style: TextStyle(
          //       color: Theme.of(context).primaryColor,
          //       fontWeight: FontWeight.w800),
          // ),
          const _MyStoryTile(),
          const SizedBox(height: 6),
          Text(
            'Others',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 10,
                leading: Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const CustomProfileImage(imageURL: ''),
                ),
                title: const Text('Name of user'),
                subtitle: Text(
                  Utilities.timeInWords(DateTime.now().microsecondsSinceEpoch),
                ),
                trailing: IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_outlined),
                ),
              ),
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: 100,
            ),
          )
        ],
      ),
    );
  }
}

class _MyStoryTile extends StatelessWidget {
  const _MyStoryTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomProfileImage(imageURL: UserLocalData.getImageURL),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'My Stories',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Share your stories here',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
        const Spacer(),
        IconButton(
          splashRadius: 24,
          onPressed: () {},
          icon: Icon(
            Icons.camera_alt_outlined,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
