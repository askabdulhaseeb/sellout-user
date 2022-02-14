import 'package:flutter/material.dart';
import '../../../database/product_api.dart';
import '../../../models/product.dart';
import '../../../services/custom_services.dart';
import '../../../widgets/product/prod_post_tile.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: ProductAPI().getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) {
            return const _ErrorWidget();
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShowLoading();
            } else {
              List<Product> _products = snapshot.data!;
              return ListView.separated(
                itemCount: _products.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey[200],
                  thickness: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProdPostTile(product: _products[index]);
                },
              );
            }
          }
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
