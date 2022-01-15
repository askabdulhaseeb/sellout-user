import 'package:flutter/material.dart';
import '../../../services/user_local_data.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/circular_profile_image.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start Selling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _headerSection(),
            ],
          ),
        ),
      ),
    );
  }

  Row _headerSection() {
    return Row(
      children: <Widget>[
        CircularProfileImage(
          imageURL: UserLocalData.getImageURL,
          radius: 24,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Container(
            // width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: Utilities.padding / 2, horizontal: Utilities.padding),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(Utilities.borderRadius),
            ),
            child: const Text('What are you selling...?'),
          ),
        )
      ],
    );
  }
}
