import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/models/prod_category.dart';
import 'package:sellout/models/prod_sub_category.dart';
import 'package:sellout/providers/product_category_provider.dart';
import 'package:sellout/utilities/custom_validators.dart';
import 'package:sellout/widgets/custom_elevated_button.dart';
import 'package:sellout/widgets/product/prod_accept_offer.dart';
import 'package:sellout/widgets/product/prod_cat_dropdown.dart';
import 'package:sellout/widgets/product/prod_delivery_type_widget.dart';
import 'package:sellout/widgets/product/prod_privacy_widget.dart';
import 'package:sellout/widgets/product/prod_sub_cat_dropdown.dart';

import '../../../enums/delivery_type.dart';
import '../../../enums/privacy_type.dart';
import '../../../enums/product_condition.dart';
import '../../../providers/prod_provider.dart';
import '../../../services/user_local_data.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/circular_profile_image.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/product/prod_confition_widget.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  ProdConditionEnum _condition = ProdConditionEnum.NEW;
  ProdPrivacyTypeEnum _privacy = ProdPrivacyTypeEnum.PUBLIC;
  DeliveryTypeEnum _delivery = DeliveryTypeEnum.DELIVERY;

  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _quantity = TextEditingController(text: '1');
  final TextEditingController _deliveryFee = TextEditingController(text: '0');
  bool _acceptOffer = true;

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
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Consumer<ProdCatProvider>(
              builder: (
                BuildContext context,
                ProdCatProvider category,
                _,
              ) =>
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _headerSection(),
                  _infoSection(category),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    title: 'Post',
                    onTap: () {
                      if (_key.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _infoSection(ProdCatProvider category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        Text(
          'Select the Condition of your product'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ProdConditionWidget(
          onChanged: (ProdConditionEnum? p0) => _condition = p0!,
        ),
        _titleText('Description'.toUpperCase()),
        CustomTextFormField(
          controller: _description,
          validator: (String? p0) => null,
        ),
        _titleText('Category'.toUpperCase()),
        ProdCatDropdown(
          items: category.category,
          borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
          color: Colors.grey[300],
          hintText: 'Select...',
          selectedItem: category.selectedCategroy,
          onChanged: (ProdCategory? update) {
            category.updateSelection(update!);
          },
        ),
        _titleText('Sub Category'.toUpperCase()),
        ProdSubCatDropdown(
          items: category.subCategory,
          color: Colors.grey[300],
          hintText: 'Select...',
          selectedItem: category.selectedSubCategory,
          onChanged: (ProdSubCategory? update) {},
        ),
        _titleText('Price'.toUpperCase()),
        CustomTextFormField(
          controller: _price,
          validator: (String? value) => CustomValidator.isEmpty(value),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        _titleText('Quantity'.toUpperCase()),
        _quantityTextFormField(),
        ProdAcceptOfferWidget(
          onChanged: (bool p0) => _acceptOffer = p0,
        ),
        _titleText('Privacy'.toUpperCase()),
        ProdPrivacyWidget(
          onChanged: (ProdPrivacyTypeEnum? p0) => _privacy = p0!,
        ),
        _titleText('Delivery Type'.toUpperCase()),
        ProdDeliveryTypeWidget(
          onChanged: (DeliveryTypeEnum? p0) {
            if (p0 == DeliveryTypeEnum.COLLOCATION) {
              _deliveryFee.text = '0';
            }
            _delivery = p0!;
          },
        ),
        Row(
          children: <Widget>[
            Text(
              'Delivery Fee'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: CustomTextFormField(
                controller: _deliveryFee,
                showPrefixIcon: false,
                validator: (String? value) => CustomValidator.isEmpty(value),
                readOnly: _delivery == DeliveryTypeEnum.COLLOCATION,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Please note that all delivery must be track and signed for. Please keep that in account when deciding delivery fee.\nThank you.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Row _quantityTextFormField() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            if (_quantity.text.isEmpty) {
              _quantity.text = '0';
              return;
            }
            int num = int.parse(_quantity.text);

            if (num > 0) {
              num--;
              _quantity.text = num.toString();
            }
          },
          splashRadius: Utilities.borderRadius,
          icon: Icon(
            Icons.remove_circle_outline,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextFormField(
            controller: _quantity,
            showPrefixIcon: false,
            validator: (String? value) => null,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            if (_quantity.text.isEmpty) {
              _quantity.text = '0';
            }
            int num = int.parse(_quantity.text);
            num++;
            _quantity.text = num.toString();
          },
          splashRadius: Utilities.borderRadius,
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Padding _titleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        ' $title',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
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
