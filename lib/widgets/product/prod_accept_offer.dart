import 'package:flutter/material.dart';

// ignore_for_file: constant_identifier_names
enum _AcceptOfferEnum { YES, NO }

class ProdAcceptOfferWidget extends StatefulWidget {
  const ProdAcceptOfferWidget({required this.onChanged, Key? key})
      : super(key: key);
  final void Function(bool)? onChanged;
  @override
  State<ProdAcceptOfferWidget> createState() => _ProdAcceptOfferWidgetState();
}

class _ProdAcceptOfferWidgetState extends State<ProdAcceptOfferWidget> {
  _AcceptOfferEnum _offerEnum = _AcceptOfferEnum.YES;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Accept Offer'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _offerEnum = _AcceptOfferEnum.YES;
            });
            widget.onChanged!(true);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<_AcceptOfferEnum>(
                value: _AcceptOfferEnum.YES,
                activeColor: Theme.of(context).primaryColor,
                groupValue: _offerEnum,
                onChanged: (_AcceptOfferEnum? value) {
                  setState(() {
                    _offerEnum = value!;
                  });
                  widget.onChanged!(true);
                },
              ),
              const Text('YES'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _offerEnum = _AcceptOfferEnum.NO;
            });
            widget.onChanged!(false);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<_AcceptOfferEnum>(
                value: _AcceptOfferEnum.NO,
                groupValue: _offerEnum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (_AcceptOfferEnum? value) {
                  setState(() {
                    _offerEnum = value!;
                  });
                  widget.onChanged!(false);
                },
              ),
              const Text('NO'),
            ],
          ),
        ),
      ],
    );
  }
}
