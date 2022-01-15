import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../models/prod_sub_category.dart';
import '../../utilities/utilities.dart';

class ProdSubCatDropdown extends StatelessWidget {
  const ProdSubCatDropdown({
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.borderRadius,
    this.color,
    this.hintText = 'Sub Category',
    this.margin,
    Key? key,
  }) : super(key: key);
  final List<ProdSubCategory> items;
  final ProdSubCategory? selectedItem;
  final BorderRadiusGeometry? borderRadius;
  final void Function(ProdSubCategory?) onChanged;
  final Color? color;
  final String hintText;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor.withOpacity(0.9),
        borderRadius:
            borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 2),
      ),
      child: DropdownSearch<ProdSubCategory>(
        showSearchBox: true,
        dropdownSearchTextAlignVertical: TextAlignVertical.center,
        mode: Mode.MENU,
        selectedItem: selectedItem,
        items: items,
        dropdownSearchBaseStyle: const TextStyle(color: Colors.white),
        itemAsString: (ProdSubCategory? item) => item!.title,
        onChanged: (ProdSubCategory? value) => onChanged(value),
        validator: (ProdSubCategory? value) {
          if (value == null) return 'Sub Category Required';
          return null;
        },
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
