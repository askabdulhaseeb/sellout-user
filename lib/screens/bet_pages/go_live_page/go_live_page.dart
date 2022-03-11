import 'package:flutter/material.dart';

import '../../../enums/privacy_type.dart';
import '../../../services/custom_services.dart';
import '../../../utilities/custom_validators.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../../widgets/product/prod_privacy_widget.dart';

class GoLivePage extends StatefulWidget {
  const GoLivePage({Key? key}) : super(key: key);
  @override
  State<GoLivePage> createState() => _GoLivePageState();
}

class _GoLivePageState extends State<GoLivePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _decription = TextEditingController();
  final TextEditingController _price = TextEditingController();
  ProdPrivacyTypeEnum? _privacy;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => CustomService.dismissKeyboard(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Go Live',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              _title('Bit Name'),
              CustomTextFormField(
                controller: _name,
                validator: (String? value) => CustomValidator.lessThen3(value),
                maxLength: 30,
              ),
              _title('Item Decription'),
              CustomTextFormField(
                controller: _decription,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              _title('Starting Price'),
              CustomTextFormField(
                controller: _price,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              _title('Privacy'),
              ProdPrivacyWidget(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onChanged: (ProdPrivacyTypeEnum? newPrivacy) {
                  _privacy = newPrivacy;
                },
              ),
              const SizedBox(height: 10),
              CustomElevatedButton(
                title: 'Go Live',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _title(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    );
  }
}
