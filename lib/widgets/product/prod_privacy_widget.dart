import 'package:flutter/material.dart';
import '../../enums/privacy_type.dart';

class ProdPrivacyWidget extends StatefulWidget {
  const ProdPrivacyWidget({required this.onChanged, Key? key})
      : super(key: key);
  final void Function(ProdPrivacyTypeEnum?)? onChanged;
  @override
  State<ProdPrivacyWidget> createState() => _ProdPrivacyWidgetState();
}

class _ProdPrivacyWidgetState extends State<ProdPrivacyWidget> {
  ProdPrivacyTypeEnum _privacy = ProdPrivacyTypeEnum.PUBLIC;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _privacy = ProdPrivacyTypeEnum.PUBLIC;
            });
            widget.onChanged!(ProdPrivacyTypeEnum.PUBLIC);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ProdPrivacyTypeEnum>(
                value: ProdPrivacyTypeEnum.PUBLIC,
                groupValue: _privacy,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (ProdPrivacyTypeEnum? value) {
                  setState(() {
                    _privacy = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('Public'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _privacy = ProdPrivacyTypeEnum.SUPPORTERS;
            });
            widget.onChanged!(ProdPrivacyTypeEnum.SUPPORTERS);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ProdPrivacyTypeEnum>(
                value: ProdPrivacyTypeEnum.SUPPORTERS,
                groupValue: _privacy,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (ProdPrivacyTypeEnum? value) {
                  setState(() {
                    _privacy = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('Supporters'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _privacy = ProdPrivacyTypeEnum.PRIVATE;
            });
            widget.onChanged!(ProdPrivacyTypeEnum.PRIVATE);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ProdPrivacyTypeEnum>(
                value: ProdPrivacyTypeEnum.PRIVATE,
                groupValue: _privacy,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (ProdPrivacyTypeEnum? value) {
                  setState(() {
                    _privacy = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('Private'),
            ],
          ),
        ),
      ],
    );
  }
}
