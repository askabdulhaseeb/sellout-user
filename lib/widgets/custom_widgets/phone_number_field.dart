import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../utilities/utilities.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({required this.onChange, Key? key}) : super(key: key);
  final Function(PhoneNumber)? onChange;
  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.grey[300],
      ),
      child: IntlPhoneField(
        
        textInputAction: TextInputAction.done,
        showCountryFlag: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
          ),
          labelText: 'Mobile number',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
          ),
        ),
        initialCountryCode: 'UK',
        keyboardType: TextInputType.number,
        onChanged: (PhoneNumber phone) => widget.onChange!(phone),
      ),
    );
  }
}
