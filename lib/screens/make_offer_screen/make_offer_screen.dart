import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../models/app_user.dart';
import '../../models/product.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../message_screens/personal/product_chat_screen.dart';

class MakeOfferScreen extends StatefulWidget {
  const MakeOfferScreen({required this.product, required this.user, Key? key})
      : super(key: key);
  static const String routeName = '/MakeOfferScreen';
  final Product product;
  final AppUser user;
  @override
  State<MakeOfferScreen> createState() => _MakeOfferScreenState();
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  String _offer = '0';
  void updateOffer(String newOffer) {
    print(newOffer);
    _offer = newOffer;
    setState(() {});
  }

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
          _Header(product: widget.product),
          Column(
            children: <Widget>[
              const Text(
                'Your offer',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
                child: FittedBox(child: Text(_offer)),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              _DigitalKeyboard(
                product: widget.product,
                user: widget.user,
                offer: _offer,
                updateOffer: (String? newoffer) => updateOffer(newoffer ?? '0'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _DigitalKeyboard extends StatelessWidget {
  const _DigitalKeyboard({
    required this.product,
    required this.user,
    required this.offer,
    required this.updateOffer,
    Key? key,
  }) : super(key: key);
  final Product product;
  final AppUser user;
  final String offer;
  final void Function(String) updateOffer;

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
            _button(context, number: '1', onTap: () => _addNumber('1')),
            _divider(),
            _button(context, number: '2', onTap: () => _addNumber('2')),
            _divider(),
            _button(context, number: '3', onTap: () => _addNumber('3')),
          ],
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(context, number: '4', onTap: () => _addNumber('4')),
            _divider(),
            _button(context, number: '5', onTap: () => _addNumber('5')),
            _divider(),
            _button(context, number: '6', onTap: () => _addNumber('6')),
          ],
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(context, number: '7', onTap: () => _addNumber('7')),
            _divider(),
            _button(context, number: '8', onTap: () => _addNumber('8')),
            _divider(),
            _button(context, number: '9', onTap: () => _addNumber('9')),
          ],
        ),
        const Divider(height: 0),
        Row(
          children: <Widget>[
            _button(
              context,
              number: '.',
              onTap: () => updateOffer((offer + '.')),
            ),
            _divider(),
            _button(context, number: '0', onTap: () => _addNumber('0')),
            _divider(),
            _remove(context, onTap: () {
              if (offer.length == 1) {
                updateOffer('0');
              } else if (offer.isNotEmpty) {
                final String result = offer.substring(0, offer.length - 1);
                updateOffer(result);
              }
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

  void _addNumber(String num) {
    String _temp = offer;
    if (_temp == '0') {
      _temp = num;
    } else {
      _temp += num;
    }
    updateOffer(_temp);
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
          child: Icon(Icons.backspace_outlined),
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
        const Text(
          '10 offers left',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
