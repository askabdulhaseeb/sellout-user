import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sellout/models/product_category.dart';
import 'package:sellout/utilities/utilities.dart';

class ProdCatDropdown extends StatelessWidget {
  const ProdCatDropdown({
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.height = 40,
    Key? key,
  }) : super(key: key);
  final List<ProdCategory> items;
  final ProdCategory? selectedItem;
  final void Function(ProdCategory?) onChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Colors.grey);
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Utilities.borderRadius),
      ),
      child: DropdownButton<ProdCategory>(
        underline: const SizedBox(),
        hint: const Text(
          'Category',
          style: textStyle,
        ),
        value: selectedItem,
        style: const TextStyle(color: Colors.black),
        items: items
            .map(
              (ProdCategory e) => DropdownMenuItem<ProdCategory>(
                value: e,
                child: Text(
                  e.title,
                ),
              ),
            )
            .toList(),
        onChanged: (ProdCategory? value) => onChanged(value),
      ),
    );
  }
}
