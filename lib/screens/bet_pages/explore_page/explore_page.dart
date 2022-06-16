import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/delivery_type.dart';
import '../../../enums/product_condition.dart';
import '../../../providers/prod_provider.dart';
import '../../../widgets/product/grid_view_of_prod.dart';
import 'prod_filter_screen.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProdProvider prodProvider = Provider.of<ProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'SellOut Market',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          CupertinoSearchTextField(
            onChanged: (String? value) => prodProvider.onSearch(value),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      if (prodProvider.maxPrice >= prodProvider.minPrice)
                        _FilterTile(
                          title:
                              'Price ${prodProvider.minPrice}-${prodProvider.maxPrice}',
                        ),
                      if (prodProvider.condition != null)
                        _FilterTile(
                          title:
                              'Condition: ${ProdConditionEnumConvertor.enumToString(condition: prodProvider.condition ?? ProdConditionEnum.NEW)}',
                        ),
                      if (prodProvider.deliveryType != null)
                        _FilterTile(
                          title:
                              'Delivery Type: ${DeliveryTypeEnumConvertor.enumToString(delivery: prodProvider.deliveryType ?? DeliveryTypeEnum.BOTH)}',
                        ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ProdFilterScreen.routeName);
                },
                child: const Text('Apply Filter'),
              ),
            ],
          ),
          Flexible(
            child: prodProvider.filterdProducts().isEmpty
                ? const Center(
                    child: Text('No Product found'),
                  )
                : GridViewOfProducts(
                    posts: prodProvider.filterdProducts(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterTile extends StatelessWidget {
  const _FilterTile({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
