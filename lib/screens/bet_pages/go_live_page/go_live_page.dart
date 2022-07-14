import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sellout/screens/bet_pages/broadcast_page.dart';

import '../../../database/auction_api.dart';
import '../../../database/auth_methods.dart';
import '../../../enums/privacy_type.dart';
import '../../../functions/picker_functions.dart';
import '../../../functions/time_date_functions.dart';
import '../../../models/auction.dart';
import '../../../models/bet.dart';
import '../../../providers/auction_provider.dart';
import '../../../providers/main_bottom_nav_bar_provider.dart';
import '../../../services/custom_services.dart';
import '../../../utilities/custom_validators.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_file_image_box.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../../widgets/product/prod_privacy_widget.dart';

class GoLivePage extends StatefulWidget {
  const GoLivePage({Key? key}) : super(key: key);
  static const String routeName = '/GoLivePage';
  @override
  State<GoLivePage> createState() => _GoLivePageState();
}

class _GoLivePageState extends State<GoLivePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _decription = TextEditingController();
  final TextEditingController _price = TextEditingController();
  ProdPrivacyTypeEnum? _privacy;
  PlatformFile? _file;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Go Live',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => CustomService.dismissKeyboard(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomFileImageBox(
                    file: _file,
                    onTap: () async {
                      _file =
                          await PickerFunctions().pick(type: FileType.image);
                      if (_file == null) return;
                      setState(() {});
                    },
                    title: 'Thumbnail',
                  ),
                  _title('Bid Name'),
                  CustomTextFormField(
                    controller: _name,
                    border: InputBorder.none,
                    validator: (String? value) =>
                        CustomValidator.lessThen3(value),
                    maxLength: 30,
                    readOnly: _isLoading,
                  ),
                  _title('Item Description'),
                  CustomTextFormField(
                    controller: _decription,
                    maxLines: 4,
                    readOnly: _isLoading,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: (String? value) =>
                        CustomValidator.lessThen3(value),
                  ),
                  _title('Starting Price'),
                  CustomTextFormField(
                    controller: _price,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.done,
                    readOnly: _isLoading,
                    validator: (String? value) =>
                        CustomValidator.isEmpty(value),
                  ),
                  _title('Privacy'),
                  ProdPrivacyWidget(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onChanged: (ProdPrivacyTypeEnum? newPrivacy) {
                      _privacy = newPrivacy;
                    },
                  ),
                  const SizedBox(height: 10),
                  _isLoading
                      ? const ShowLoading()
                      : CustomElevatedButton(
                          title: 'Go Live',
                          onTap: () async {
                            if (_file == null) {
                              CustomToast.errorToast(
                                message: 'Image is required',
                              );
                              return;
                            }
                            if (_key.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              final String id = AuthMethods.uniqueID;
                              final int time = TimeDateFunctions.timestamp;
                              String? url = '';
                              url = await AuctionAPI().uploadImage(
                                  id: id, file: File(_file!.path!));
                              final Auction auction = Auction(
                                auctionID: id,
                                uid: AuthMethods.uid,
                                name: _name.text,
                                thumbnail: url ?? '',
                                decription: _decription.text,
                                startingPrice: double.parse(_price.text),
                                bets: <Bet>[],
                                timestamp: time,
                                privacy: _privacy ?? ProdPrivacyTypeEnum.PUBLIC,
                              );
                              final bool started =
                                  await AuctionAPI().startAuction(auction);
                              setState(() {
                                _isLoading = false;
                              });
                              if (started) {
                                CustomToast.successSnackBar(
                                  context: context,
                                  text: 'Auction started successfully',
                                );
                                if (!mounted) return;
                                Provider.of<AuctionProvider>(context,
                                        listen: false)
                                    .refresh();
                                Provider.of<AppProvider>(context, listen: false)
                                    .onTabTapped(0);
                                await <Permission>[
                                  Permission.camera,
                                  Permission.microphone
                                ].request();
                                print("Joing channel: $id");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => BroadcastPage(
                                      channelName: id,
                                      userName: _name.text,
                                      isBroadcaster: true,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                ],
              ),
            ),
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
