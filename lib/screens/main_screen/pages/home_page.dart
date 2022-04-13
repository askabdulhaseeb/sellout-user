import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/product_api.dart';
import '../../../models/product.dart';
import '../../../providers/prod_provider.dart';
import '../../../services/custom_services.dart';
import '../../../widgets/product/prod_post_tile.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../notification_screen/notification_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: CustomService.systemUIOverlayStyle(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'SellOut',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            wordSpacing: 1,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: <Widget>[
          IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.routeName);
            },
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: Consumer<ProdProvider>(
        builder: (BuildContext context, ProdProvider prodProvider, _) {
          List<Product> _products = prodProvider.products;
          return RefreshIndicator(
            child: ListView.separated(
              itemCount: _products.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.grey[200],
                thickness: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ProdPostTile(product: _products[index]);
              },
            ),
            onRefresh: () => prodProvider.refresh(),
          );
        },
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Text(
            'Some thing goes wrong',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
