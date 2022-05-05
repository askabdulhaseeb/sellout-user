import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/prod_provider.dart';
import '../../../services/user_local_data.dart';
import '../../../widgets/product/grid_view_of_prod.dart';
import 'prod_filter_screen.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProdProvider _prodProvider = Provider.of<ProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Sellout Market',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          CupertinoSearchTextField(
            onChanged: (String? value) => _prodProvider.onSearch(value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ProdFilterScreen.routeName);
                },
                child: const Text('Apply Filter'),
              ),
            ],
          ),
          Flexible(
            child: _prodProvider.filterdProducts().isEmpty
                ? const Center(
                    child: Text('No Product found'),
                  )
                : GridViewOfProducts(
                    posts: _prodProvider.filterdProducts(),
                  ),
          ),
        ],
      ),
    );
  }
}
