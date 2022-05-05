import 'package:flutter/material.dart';

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
            // Sort
            _Tile(
              icon: Icons.sort_outlined,
              title: 'Sort',
              subtitle: 'Sort the products by your choice',
              onTap: () {},
            ),
            // Category
            _Tile(
              icon: Icons.category_outlined,
              title: 'Category',
              subtitle: 'Choose your required Category',
              onTap: () {},
            ),
            // Price
            _Tile(
              icon: Icons.price_change_outlined,
              title: 'Price',
              subtitle: 'Select the price range',
              onTap: () {},
            ),
            // Condition
            _Tile(
              icon: Icons.format_shapes_rounded,
              title: 'Condition',
              subtitle: 'Choose the condition',
              onTap: () {},
            ),
            // Location
            _Tile(
              icon: Icons.location_on_outlined,
              title: 'Location',
              subtitle: 'Select the area range',
              onTap: () {},
            ),
            // Delivery& Collection
            _Tile(
              icon: Icons.delivery_dining,
              title: 'Delivery & Collection',
              subtitle: 'Select the Delivery Type',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 10,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
