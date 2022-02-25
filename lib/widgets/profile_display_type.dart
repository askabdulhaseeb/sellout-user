import 'package:flutter/material.dart';

// ignore_for_file: constant_identifier_names
enum _ProfileDisplayEnum { PUBLIC, PRIVATE }

class ProfileDisplayTypeWidget extends StatefulWidget {
  const ProfileDisplayTypeWidget({
    required this.isPublic,
    required this.onChanged,
    Key? key,
  }) : super(key: key);
  final bool isPublic;
  final void Function(bool)? onChanged;
  @override
  State<ProfileDisplayTypeWidget> createState() =>
      _ProfileDisplayTypeWidgetState();
}

class _ProfileDisplayTypeWidgetState extends State<ProfileDisplayTypeWidget> {
  late _ProfileDisplayEnum _offerEnum;
  @override
  void initState() {
    _offerEnum = widget.isPublic
        ? _ProfileDisplayEnum.PUBLIC
        : _ProfileDisplayEnum.PRIVATE;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 16),
        const Text(
          'Profile Display',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _offerEnum = _ProfileDisplayEnum.PUBLIC;
            });
            widget.onChanged!(true);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<_ProfileDisplayEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: _ProfileDisplayEnum.PUBLIC,
                activeColor: Theme.of(context).primaryColor,
                groupValue: _offerEnum,
                onChanged: (_ProfileDisplayEnum? value) {
                  setState(() {
                    _offerEnum = value!;
                  });
                  widget.onChanged!(true);
                },
              ),
              const Text('PUBLIC', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _offerEnum = _ProfileDisplayEnum.PRIVATE;
            });
            widget.onChanged!(false);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<_ProfileDisplayEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: _ProfileDisplayEnum.PRIVATE,
                groupValue: _offerEnum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (_ProfileDisplayEnum? value) {
                  setState(() {
                    _offerEnum = value!;
                  });
                  widget.onChanged!(false);
                },
              ),
              const Text('PRIVATE', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
