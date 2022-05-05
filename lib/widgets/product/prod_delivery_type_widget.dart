import 'package:flutter/material.dart';
import '../../enums/delivery_type.dart';

class ProdDeliveryTypeWidget extends StatefulWidget {
  const ProdDeliveryTypeWidget({
    required this.onChanged,
    this.initialValue,
    Key? key,
  }) : super(key: key);
  final void Function(DeliveryTypeEnum?)? onChanged;
  final DeliveryTypeEnum? initialValue;
  @override
  State<ProdDeliveryTypeWidget> createState() => _ProdDeliveryTypeWidgetState();
}

class _ProdDeliveryTypeWidgetState extends State<ProdDeliveryTypeWidget> {
  DeliveryTypeEnum _enum = DeliveryTypeEnum.DELIVERY;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            widget.onChanged!(DeliveryTypeEnum.DELIVERY);
            setState(() {
              _enum = DeliveryTypeEnum.DELIVERY;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<DeliveryTypeEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: DeliveryTypeEnum.DELIVERY,
                groupValue: _enum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (DeliveryTypeEnum? value) {
                  widget.onChanged!(value);
                  setState(() {
                    _enum = value!;
                  });
                },
              ),
              const Text('Delivery'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            widget.onChanged!(DeliveryTypeEnum.COLLOCATION);
            setState(() {
              _enum = DeliveryTypeEnum.COLLOCATION;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<DeliveryTypeEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: DeliveryTypeEnum.COLLOCATION,
                groupValue: _enum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (DeliveryTypeEnum? value) {
                  widget.onChanged!(value);
                  setState(() {
                    _enum = value!;
                  });
                },
              ),
              const Text('Collection'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            widget.onChanged!(DeliveryTypeEnum.BOTH);
            setState(() {
              _enum = DeliveryTypeEnum.BOTH;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<DeliveryTypeEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: DeliveryTypeEnum.BOTH,
                groupValue: _enum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (DeliveryTypeEnum? value) {
                  widget.onChanged!(value);
                  setState(() {
                    _enum = value!;
                  });
                },
              ),
              const Text('Both'),
            ],
          ),
        ),
      ],
    );
  }
}
