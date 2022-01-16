import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../../enums/delivery_type.dart';
import '../../../enums/privacy_type.dart';
import '../../../enums/product_condition.dart';
import '../../../models/prod_category.dart';
import '../../../models/prod_sub_category.dart';
import '../../../providers/product_category_provider.dart';
import '../../../services/custom_services.dart';
import '../../../services/user_local_data.dart';
import '../../../utilities/custom_validators.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/circular_profile_image.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/product/prod_accept_offer.dart';
import '../../../widgets/product/prod_cat_dropdown.dart';
import '../../../widgets/product/prod_confition_widget.dart';
import '../../../widgets/product/prod_delivery_type_widget.dart';
import '../../../widgets/product/prod_privacy_widget.dart';
import '../../../widgets/product/prod_sub_cat_dropdown.dart';

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
  final List<PlatformFile> _files = <PlatformFile>[];

  @override
  void initState() {
    CustomService.statusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: CustomService.systemUIOverlayStyle(),
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
      body: GestureDetector(
        onTap: () {
          CustomService.dismissKeyboard();
        },
        child: Padding(
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
                    const SizedBox(height: 16),
                    _GetProductImages(
                      onTap: () => _fetchMedia(),
                    ),
                    const SizedBox(height: 20),
                    _infoSection(category),
                    const SizedBox(height: 16),
                    CustomElevatedButton(
                      title: 'Post',
                      onTap: () {
                        if (_key.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fetchMedia() async {
    final FilePickerResult? _result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (_result == null) return;
    _files.clear();
    _files.addAll(_result.files);
    setState(() {});
  }

  Column _infoSection(ProdCatProvider category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _additionalInformation('Basic information'),
        _titleText('Description'.toUpperCase()),
        CustomTextFormField(
          controller: _description,
          minLines: 1,
          maxLines: 5,
          hint: 'Write something about product',
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
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
            category.updateCatSelection(update!);
          },
        ),
        _titleText('Sub Category'.toUpperCase()),
        ProdSubCatDropdown(
          items: category.subCategory,
          color: Colors.grey[300],
          hintText: 'Select...',
          selectedItem: category.selectedSubCategory,
          onChanged: (ProdSubCategory? update) {
            category.updateSubCategorySection(update!);
          },
        ),
        _titleText('Price'.toUpperCase()),
        CustomTextFormField(
          controller: _price,
          hint: 'Select Price',
          validator: (String? value) => CustomValidator.isEmpty(value),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        _titleText('Quantity'.toUpperCase()),
        _quantityTextFormField(),
        const SizedBox(height: 16),
        _additionalInformation('additional information'),
        const SizedBox(height: 10),
        _titleText('Select the Condition of your product'.toUpperCase()),
        ProdConditionWidget(
          onChanged: (ProdConditionEnum? p0) => _condition = p0!,
        ),
        _titleText('Accept Offer'.toUpperCase()),
        ProdAcceptOfferWidget(onChanged: (bool p0) => _acceptOffer = p0),
        _titleText('Privacy'.toUpperCase()),
        ProdPrivacyWidget(
          onChanged: (ProdPrivacyTypeEnum? p0) {
            _privacy = p0!;
          },
        ),
        _titleText('Delivery Type'.toUpperCase()),
        ProdDeliveryTypeWidget(
          onChanged: (DeliveryTypeEnum? p0) {
            if (p0 == DeliveryTypeEnum.COLLOCATION) {
              _deliveryFee.text = '0';
            }
            _delivery = p0!;
            setState(() {});
          },
        ),
        Row(
          children: <Widget>[
            Text(
              'Delivery Fee'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: CustomTextFormField(
                controller: _deliveryFee,
                showPrefixIcon: false,
                contentPadding: const EdgeInsets.only(left: 40),
                validator: (String? value) => CustomValidator.isEmpty(value),
                readOnly: _delivery == DeliveryTypeEnum.COLLOCATION,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                color: Colors.transparent,
              ),
            ),
            const SizedBox(width: 30),
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

  Row _additionalInformation(String title) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Text(
          '  $title  '.toUpperCase(),
          style: TextStyle(color: Colors.grey[400]),
        ),
        Flexible(
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
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
        const SizedBox(width: 20),
        Expanded(
          child: CustomTextFormField(
            controller: _quantity,
            contentPadding: const EdgeInsets.only(left: 40),
            showPrefixIcon: false,
            validator: (String? value) => CustomValidator.isEmpty(value),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 20),
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
            padding: EdgeInsets.symmetric(
              vertical: Utilities.padding / 2,
              horizontal: Utilities.padding,
            ),
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

class _GetProductImages extends StatefulWidget {
  const _GetProductImages({required this.onTap, Key? key}) : super(key: key);
  final VoidCallback onTap;
  @override
  __GetProductImagesState createState() => __GetProductImagesState();
}

class __GetProductImagesState extends State<_GetProductImages> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width - 32 - 25;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            height: (_width / 5) * 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.grey[300],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(height: 16),
                Icon(Icons.add_circle_rounded),
                SizedBox(height: 6),
                Text('Add Images/Videos'),
                Text(
                  'Only 10 images/video are allowed',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _ImageBox(index: 1, width: _width / 5),
            _ImageBox(index: 2, width: _width / 5),
            _ImageBox(index: 3, width: _width / 5),
            _ImageBox(index: 4, width: _width / 5),
            _ImageBox(index: 5, width: _width / 5),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _ImageBox(index: 6, width: _width / 5),
            _ImageBox(index: 7, width: _width / 5),
            _ImageBox(index: 8, width: _width / 5),
            _ImageBox(index: 9, width: _width / 5),
            _ImageBox(index: 10, width: _width / 5),
          ],
        ),
      ],
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({required this.index, required double width, Key? key})
      : _width = width,
        super(key: key);

  final double _width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _width,
      width: _width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: Colors.grey[300],
        child: FittedBox(
          child: Text(
            index.toString(),
            style: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
