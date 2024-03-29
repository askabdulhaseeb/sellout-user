import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/product_api.dart';
import '../../../enums/delivery_type.dart';
import '../../../enums/privacy_type.dart';
import '../../../enums/product_condition.dart';
import '../../../models/prod_category.dart';
import '../../../models/prod_sub_category.dart';
import '../../../models/product.dart';
import '../../../providers/main_bottom_nav_bar_provider.dart';
import '../../../providers/product_category_provider.dart';
import '../../../services/custom_services.dart';
import '../../../services/user_local_data.dart';
import '../../../utilities/custom_validators.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/assets_video_widget.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
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

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _quantity = TextEditingController(text: '1');
  final TextEditingController _deliveryFee = TextEditingController(text: '0');
  bool _acceptOffer = true;
  bool _isloading = false;
  final List<PlatformFile?> _files = <PlatformFile?>[
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  @override
  void initState() {
    CustomService.statusBar();
    super.initState();
  }

  void _reset() {
    _title.clear();
    _description.clear();
    _price.clear();
    _quantity.text = '1';
    _deliveryFee.text = '0';
    _condition = ProdConditionEnum.NEW;
    _privacy = ProdPrivacyTypeEnum.PUBLIC;
    _delivery = DeliveryTypeEnum.DELIVERY;
    _files.clear();
    for (int i = 0; i < 10; i++) {
      _files.add(null);
    }
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
                      file: _files,
                    ),
                    const SizedBox(height: 20),
                    _infoSection(category),
                    const SizedBox(height: 16),
                    _isloading
                        ? const ShowLoading()
                        : CustomElevatedButton(
                            title: 'Post',
                            onTap: () => _submitForm(category),
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

  void _submitForm(ProdCatProvider category) async {
    if (_key.currentState!.validate()) {
      if (_files[0] == null) {
        CustomToast.errorToast(message: 'Add Images of the product');
        return;
      }
      CustomService.dismissKeyboard();
      setState(() {
        _isloading = true;
      });
      String pid = DateTime.now().microsecondsSinceEpoch.toString();
      List<ProductURL> urls = <ProductURL>[];
      for (int i = 0; i < 10; i++) {
        if (_files[i] != null) {
          String? tempURL = await ProductAPI().uploadImage(
            pid: pid,
            file: File(_files[i]!.path!),
          );
          urls.add(
            ProductURL(
              url: tempURL ?? '',
              isVideo: Utilities.isVideo(extension: _files[i]!.extension!),
              index: i,
            ),
          );
        }
      }
      Product product = Product(
        pid: DateTime.now().microsecondsSinceEpoch.toString(),
        uid: UserLocalData.getUID,
        title: _title.text.trim(),
        prodURL: urls,
        thumbnail: '',
        condition: _condition,
        description: _description.text.trim(),
        categories: <String>[category.selectedCategroy!.catID],
        subCategories: <String>[category.selectedSubCategory!.catID],
        price: double.parse(_price.text),
        acceptOffers: _acceptOffer,
        privacy: _privacy,
        delivery: _delivery,
        deliveryFree: double.parse(_deliveryFee.text.trim()),
        quantity: int.parse(_quantity.text.trim()),
        isAvailable: true,
        timestamp: DateTime.now().microsecondsSinceEpoch,
      );
      final bool uploaded = await ProductAPI().addProduct(product);
      setState(() {
        _isloading = false;
      });
      if (uploaded) {
        if (!mounted) return;
        Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
        _reset();
        CustomToast.successToast(message: 'Uploaded Successfully');
      } else {
        CustomToast.errorToast(message: 'Error');
      }
    }
  }

  _fetchMedia() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (result == null) return;
    _files.clear();
    for (PlatformFile element in result.files) {
      // File mediaFile = File(element.path!);
      _files.add(element);
    }
    for (int i = result.files.length; i < 10; i++) {
      _files.add(null);
    }

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
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
        ),
        _titleText('Quantity'.toUpperCase()),
        _quantityTextFormField(),
        const SizedBox(height: 16),
        _additionalInformation('additional information'),
        const SizedBox(height: 10),
        FittedBox(
          child:
              _titleText('Select the Condition of your product'.toUpperCase()),
        ),
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
        CustomProfileImage(
          imageURL: UserLocalData.getImageURL,
          radius: 44,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: CustomTextFormField(
            controller: _title,
            hint: 'What are you selling ...?',
            validator: (String? value) => CustomValidator.isEmpty(value),
          ),
        )
      ],
    );
  }
}

class _GetProductImages extends StatefulWidget {
  const _GetProductImages({required this.file, required this.onTap, Key? key})
      : super(key: key);
  final List<PlatformFile?> file;
  final VoidCallback onTap;
  @override
  __GetProductImagesState createState() => __GetProductImagesState();
}

class __GetProductImagesState extends State<_GetProductImages> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 32 - 20;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            height: (width / 5) * 2,
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
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: width / 5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 5),
            itemBuilder: (BuildContext context, int index) => _ImageBox(
              index: index + 1,
              width: width / 5,
              file: widget.file[index],
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: width / 5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 5),
            itemBuilder: (BuildContext context, int index) => _ImageBox(
              index: index + 6,
              width: width / 5,
              file: widget.file[index + 5],
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.index,
    required double width,
    this.file,
    Key? key,
  })  : _width = width,
        super(key: key);

  final double _width;
  final int index;
  final PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _width,
      width: _width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: (file == null)
          ? Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[300],
              child: FittedBox(
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.08),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            )
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: (Utilities.isVideo(extension: file!.extension!))
                  ? AssetsVideoWidget(videoPath: file!.path!)
                  : Image.file(File(file!.path!)),
            ),
    );
  }
}
