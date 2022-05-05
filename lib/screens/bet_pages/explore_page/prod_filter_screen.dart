import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/delivery_type.dart';
import '../../../enums/prod_sort_enum.dart';
import '../../../enums/product_condition.dart';
import '../../../models/prod_category.dart';
import '../../../models/prod_sub_category.dart';
import '../../../providers/prod_provider.dart';
import '../../../providers/product_category_provider.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/product/prod_cat_dropdown.dart';
import '../../../widgets/product/prod_confition_widget.dart';
import '../../../widgets/product/prod_delivery_type_widget.dart';
import '../../../widgets/product/prod_sort_widget.dart';
import '../../../widgets/product/prod_sub_cat_dropdown.dart';

class ProdFilterScreen extends StatefulWidget {
  const ProdFilterScreen({Key? key}) : super(key: key);
  static const String routeName = '/ProdFilterScreen';
  @override
  State<ProdFilterScreen> createState() => _ProdFilterScreenState();
}

class _ProdFilterScreenState extends State<ProdFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Appling filter can help you to get your requried product in less time.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Consumer2<ProdProvider, ProdCatProvider>(
              builder: (
                BuildContext context,
                ProdProvider prodPro,
                ProdCatProvider catPro,
                _,
              ) {
                return ExpansionPanelList.radio(
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  children: <ExpansionPanel>[
                    ExpansionPanelRadio(
                      value: UniqueKey(),
                      headerBuilder: (BuildContext context, bool inExpanded) =>
                          const _TileHeader(
                        icon: Icons.sort_outlined,
                        title: 'Sort',
                        subtitle: 'Sort the products by your choice',
                      ),
                      body: ProdSortWidget(
                        initialValue: prodPro.prodSort,
                        onChanged: (ProdSortEnum? value) =>
                            prodPro.onSortUpdate(value),
                      ),
                    ),
                    ExpansionPanelRadio(
                      value: UniqueKey(),
                      headerBuilder: (BuildContext context, bool inExpanded) =>
                          const _TileHeader(
                        icon: Icons.category_outlined,
                        title: 'Category',
                        subtitle: 'Choose your required Category',
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            ProdCatDropdown(
                              items: catPro.category,
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                              hintText: 'Category',
                              selectedItem: catPro.selectedCategroy,
                              onChanged: (ProdCategory? update) {
                                catPro.updateCatSelection(update!);
                              },
                            ),
                            ProdSubCatDropdown(
                              items: catPro.subCategory,
                              color: Colors.grey[300],
                              hintText: 'Sub Category',
                              selectedItem: catPro.selectedSubCategory,
                              onChanged: (ProdSubCategory? update) {
                                catPro.updateSubCategorySection(update!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ExpansionPanelRadio(
                      value: UniqueKey(),
                      headerBuilder: (BuildContext context, bool inExpanded) =>
                          const _TileHeader(
                        icon: Icons.price_change_outlined,
                        title: 'Price',
                        subtitle: 'Select the price range',
                      ),
                      body: const _PriceRangeWidget(),
                    ),
                    ExpansionPanelRadio(
                      value: UniqueKey(),
                      headerBuilder: (BuildContext context, bool inExpanded) =>
                          const _TileHeader(
                        icon: Icons.format_shapes_rounded,
                        title: 'Condition',
                        subtitle: 'Choose the condition',
                      ),
                      body: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  prodPro.onConditionUpdate(null);
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                          _ProdConditionWidget(
                            condition: prodPro.condition,
                            onChanged: (ProdConditionEnum? value) {
                              prodPro.onConditionUpdate(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    ExpansionPanelRadio(
                      value: UniqueKey(),
                      headerBuilder: (BuildContext context, bool inExpanded) =>
                          const _TileHeader(
                        icon: Icons.location_on_outlined,
                        title: 'Location',
                        subtitle: 'Select the area range',
                      ),
                      body: const Text('Location Body'),
                    ),
                    ExpansionPanelRadio(
                      value: UniqueKey(),
                      headerBuilder: (BuildContext context, bool inExpanded) =>
                          const _TileHeader(
                        icon: Icons.delivery_dining,
                        title: 'Delivery & Collection',
                        subtitle: 'Select the Delivery Type',
                      ),
                      body: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  prodPro.onDeliveryUpdate(null);
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                          _ProdDeliveryWidget(
                            condition: prodPro.deliveryType,
                            onChanged: (DeliveryTypeEnum? value) {
                              prodPro.onDeliveryUpdate(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRangeWidget extends StatefulWidget {
  const _PriceRangeWidget({Key? key}) : super(key: key);

  @override
  State<_PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<_PriceRangeWidget> {
  late TextEditingController _minPrice;
  late TextEditingController _maxPrice;

  @override
  void initState() {
    final ProdProvider _pro = Provider.of<ProdProvider>(context, listen: false);
    final double _min = _pro.minPrice;
    double _max = _pro.maxPrice;
    if (_max < 0) _max = 0;
    _minPrice = TextEditingController(text: _min.toString());
    _maxPrice = TextEditingController(text: _max.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Consumer<ProdProvider>(
        builder: (BuildContext context, ProdProvider prodPro, _) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Choose your Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => prodPro.resetPrice(),
                    child: const Text('Reset'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: CustomTextFormField(
                      controller: _minPrice,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      hint: 'Min Price',
                      validator: (String? value) => null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: CustomTextFormField(
                      controller: _maxPrice,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      hint: 'Max Price',
                      validator: (String? value) => null,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('  Min.'),
                  Text('Max. '),
                ],
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                title: 'Save',
                onTap: () {
                  prodPro.onMinPriceUpdate(_minPrice.text);
                  prodPro.onMaxPriceUpdate(_maxPrice.text);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProdConditionWidget extends StatelessWidget {
  const _ProdConditionWidget({
    this.onChanged,
    this.condition,
    Key? key,
  }) : super(key: key);
  final void Function(ProdConditionEnum?)? onChanged;
  final ProdConditionEnum? condition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<ProdConditionEnum>(
          value: ProdConditionEnum.NEW,
          activeColor: Theme.of(context).primaryColor,
          title: const Text('New'),
          groupValue: condition,
          onChanged: onChanged,
        ),
        RadioListTile<ProdConditionEnum>(
          value: ProdConditionEnum.USED,
          activeColor: Theme.of(context).primaryColor,
          title: const Text('Used'),
          groupValue: condition,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _ProdDeliveryWidget extends StatelessWidget {
  const _ProdDeliveryWidget({
    this.onChanged,
    this.condition,
    Key? key,
  }) : super(key: key);
  final void Function(DeliveryTypeEnum?)? onChanged;
  final DeliveryTypeEnum? condition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<DeliveryTypeEnum>(
          value: DeliveryTypeEnum.DELIVERY,
          activeColor: Theme.of(context).primaryColor,
          title: const Text('Delivery'),
          groupValue: condition,
          onChanged: onChanged,
        ),
        RadioListTile<DeliveryTypeEnum>(
          value: DeliveryTypeEnum.COLLOCATION,
          activeColor: Theme.of(context).primaryColor,
          title: const Text('Collecation'),
          groupValue: condition,
          onChanged: onChanged,
        ),
        RadioListTile<DeliveryTypeEnum>(
          value: DeliveryTypeEnum.BOTH,
          activeColor: Theme.of(context).primaryColor,
          title: const Text('Both'),
          groupValue: condition,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _TileHeader extends StatelessWidget {
  const _TileHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 10,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
