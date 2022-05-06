import 'package:flutter/material.dart';
import '../../enums/product_condition.dart';

class ProdConditionWidget extends StatefulWidget {
  const ProdConditionWidget({required this.onChanged, Key? key})
      : super(key: key);
  final void Function(ProdConditionEnum?)? onChanged;
  @override
  State<ProdConditionWidget> createState() => _ProdConditionWidgetState();
}

class _ProdConditionWidgetState extends State<ProdConditionWidget> {
  ProdConditionEnum _condition = ProdConditionEnum.NEW;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _condition = ProdConditionEnum.NEW;
            });
            widget.onChanged!(ProdConditionEnum.NEW);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ProdConditionEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: ProdConditionEnum.NEW,
                groupValue: _condition,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (ProdConditionEnum? value) {
                  setState(() {
                    _condition = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('New'),
              const SizedBox(width: 16),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _condition = ProdConditionEnum.USED;
            });
            widget.onChanged!(ProdConditionEnum.USED);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ProdConditionEnum>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: ProdConditionEnum.USED,
                groupValue: _condition,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (ProdConditionEnum? value) {
                  setState(() {
                    _condition = value!;
                  });
                  widget.onChanged!(value);
                },
              ),
              const Text('Used'),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}
