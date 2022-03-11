import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/auth_methods.dart';
import '../../../database/bet_api.dart';
import '../../../enums/privacy_type.dart';
import '../../../functions/time_date_functions.dart';
import '../../../models/auction.dart';
import '../../../models/bet.dart';
import '../../../providers/main_bottom_nav_bar_provider.dart';
import '../../../services/custom_services.dart';
import '../../../utilities/custom_validators.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _key,
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
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                  maxLength: 30,
                  readOnly: _isLoading,
                ),
                _title('Item Decription'),
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
                  validator: (String? value) => CustomValidator.isEmpty(value),
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
                          if (_key.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            final int _time = TimeDateFunctions.timestamp;
                            final Auction _auction = Auction(
                              id: '${AuthMethods.uid}$_time',
                              name: _name.text,
                              decription: _decription.text,
                              startingPrice: double.parse(_price.text),
                              bets: <Bet>[],
                              timestamp: _time,
                              privacy: _privacy ?? ProdPrivacyTypeEnum.PUBLIC,
                            );
                            final bool _started =
                                await AuctionAPI().startAuction(_auction);
                            setState(() {
                              _isLoading = false;
                            });
                            if (_started) {
                              CustomToast.successSnackBar(
                                context: context,
                                text: 'Auction started successfully',
                              );
                              Provider.of<AppProvider>(context, listen: false)
                                  .onTabTapped(0);
                            }
                          }
                        },
                      ),
              ],
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
