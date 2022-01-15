import 'package:flutter/material.dart';
import '../../enums/delivery_type.dart';

class ProdDeliveryTypeWidget extends StatefulWidget {
  const ProdDeliveryTypeWidget({required this.onChanged, Key? key})
      : super(key: key);
  final void Function(DeliveryTypeEnum?)? onChanged;
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
            setState(() {
              _enum = DeliveryTypeEnum.DELIVERY;
            });
            widget.onChanged!(DeliveryTypeEnum.DELIVERY);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<DeliveryTypeEnum>(
                value: DeliveryTypeEnum.DELIVERY,
                groupValue: _enum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (DeliveryTypeEnum? value) {
                  setState(() {
                    _enum = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('Delivery'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _enum = DeliveryTypeEnum.COLLOCATION;
            });
            widget.onChanged!(DeliveryTypeEnum.COLLOCATION);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<DeliveryTypeEnum>(
                value: DeliveryTypeEnum.COLLOCATION,
                groupValue: _enum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (DeliveryTypeEnum? value) {
                  setState(() {
                    _enum = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('Collection'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _enum = DeliveryTypeEnum.BOTH;
            });
            widget.onChanged!(DeliveryTypeEnum.BOTH);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<DeliveryTypeEnum>(
                value: DeliveryTypeEnum.BOTH,
                groupValue: _enum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (DeliveryTypeEnum? value) {
                  setState(() {
                    _enum = value!;
                  });
                  widget.onChanged!(value);
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
