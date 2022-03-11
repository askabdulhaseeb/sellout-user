import 'package:flutter/material.dart';
import '../../enums/privacy_type.dart';

class ProdPrivacyWidget extends StatefulWidget {
  const ProdPrivacyWidget({
    required this.onChanged,
    this.initialValue,
    this.mainAxisAlignment = MainAxisAlignment.start,
    Key? key,
  }) : super(key: key);
  final void Function(ProdPrivacyTypeEnum?)? onChanged;
  final ProdPrivacyTypeEnum? initialValue;
  final MainAxisAlignment mainAxisAlignment;
  @override
  State<ProdPrivacyWidget> createState() => _ProdPrivacyWidgetState();
}

class _ProdPrivacyWidgetState extends State<ProdPrivacyWidget> {
  ProdPrivacyTypeEnum _privacy = ProdPrivacyTypeEnum.PUBLIC;
  @override
  void initState() {
    _privacy = widget.initialValue ?? ProdPrivacyTypeEnum.PUBLIC;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
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
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
