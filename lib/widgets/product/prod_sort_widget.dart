import 'package:flutter/material.dart';

import '../../enums/prod_sort_enum.dart';

class ProdSortWidget extends StatelessWidget {
  const ProdSortWidget({this.onChanged, this.initialValue, Key? key})
      : super(key: key);

  final void Function(ProdSortEnum?)? onChanged;
  final ProdSortEnum? initialValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<ProdSortEnum>(
          value: ProdSortEnum.bestMatch,
          title: const Text('Best Match'),
          groupValue: initialValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (ProdSortEnum? value) {
            onChanged!(value);
          },
        ),
        RadioListTile<ProdSortEnum>(
          value: ProdSortEnum.lowestPriceAndPostage,
          title: const Text('Lowest Price + Postage'),
          groupValue: initialValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (ProdSortEnum? value) {
            onChanged!(value);
          },
        ),
        RadioListTile<ProdSortEnum>(
          value: ProdSortEnum.highestPriceAndPostage,
          title: const Text('Highest Price + Postage'),
          groupValue: initialValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (ProdSortEnum? value) {
            onChanged!(value);
          },
        ),
        RadioListTile<ProdSortEnum>(
          value: ProdSortEnum.newlyList,
          title: const Text('Newly List'),
          groupValue: initialValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (ProdSortEnum? value) {
            onChanged!(value);
          },
        ),
      ],
    );
  }
}
