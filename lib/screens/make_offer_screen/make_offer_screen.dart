import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../models/app_user.dart';
import '../../models/product.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../message_screens/personal/product_chat_screen.dart';

class MakeOfferScreen extends StatelessWidget {
  const MakeOfferScreen({required this.product, required this.user, Key? key})
      : super(key: key);
  static const String routeName = '/MakeOfferScreen';
  final Product product;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Make a offer',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _Header(product: product),
          Column(
            children: const <Widget>[
              Text(
                'Your offer',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
                child: FittedBox(child: Text('0')),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              _DigitalKeyboard(product: product, user: user),
            ],
          )
        ],
      ),
    );
  }
}

class _DigitalKeyboard extends StatelessWidget {
  const _DigitalKeyboard({required this.product, required this.user, Key? key})
      : super(key: key);
  final Product product;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Quantity: ${product.quantity}'),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute<ProductChatScreen>(
                    builder: (BuildContext context) => ProductChatScreen(
                      otherUser: user,
                      chatID: '${AuthMethods.uid}${product.pid}',
                      product: product,
                    ),
                  ));
                },
                child: const Text('Add Message'),
              )
            ],
          ),
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(context, number: '1', onTap: () {
              print('1');
            }),
            _divider(),
            _button(context, number: '2', onTap: () {
              print('2');
            }),
            _divider(),
            _button(context, number: '3', onTap: () {
              print('3');
            }),
          ],
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(context, number: '4', onTap: () {
              print('4');
            }),
            _divider(),
            _button(context, number: '5', onTap: () {
              print('5');
            }),
            _divider(),
            _button(context, number: '6', onTap: () {
              print('6');
            }),
          ],
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(context, number: '7', onTap: () {
              print('7');
            }),
            _divider(),
            _button(context, number: '8', onTap: () {
              print('8');
            }),
            _divider(),
            _button(context, number: '9', onTap: () {
              print('9');
            }),
          ],
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(context, number: '.', onTap: () {
              print('.');
            }),
            _divider(),
            _button(context, number: '0', onTap: () {
              print('0');
            }),
            _divider(),
            _remove(context, onTap: () {
              print('cancel');
            }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomElevatedButton(
            title: 'Send offer message',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<ProductChatScreen>(
                builder: (BuildContext context) => ProductChatScreen(
                  otherUser: user,
                  chatID: '${AuthMethods.uid}${product.pid}',
                  product: product,
                ),
              ));
            },
          ),
        )
      ],
    );
  }

  Container _divider() {
    return Container(
      height: 50,
      width: 1,
      color: Colors.grey[300],
    );
  }

  InkWell _button(
    BuildContext context, {
    required String number,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: (MediaQuery.of(context).size.width / 3) - 3,
        child: Center(
            child: Text(
          number,
          style: const TextStyle(fontSize: 18),
        )),
      ),
    );
  }

  InkWell _remove(
    BuildContext context, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: (MediaQuery.of(context).size.width / 3) - 3,
        child: const Center(
          child: Icon(Icons.cancel),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.product, Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Bye it now price: ${product.price}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '10 offers left',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
