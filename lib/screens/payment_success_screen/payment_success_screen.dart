import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/main_bottom_nav_bar_provider.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../main_screen/main_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green[200],
              child: const Icon(
                Icons.download_done,
                color: Colors.green,
                size: 60,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Payment Successful'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      const _TitleAndWidget(
                        title: 'Transaction Number',
                        subtitle: Text('123456789'),
                      ),
                      _TitleAndWidget(
                        title: 'Transaction Date',
                        subtitle: Column(
                          children: const <Widget>[
                            Text('28/02/2021'),
                            Text('11:54 AM'),
                          ],
                        ),
                      ),
                      const _TitleAndWidget(
                        title: 'Payment Method',
                        subtitle: Text('PayPal'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomElevatedButton(
                title: 'Go To Home',
                onTap: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .onTabTapped(0);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainScreen.rotueName, (_) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TitleAndWidget extends StatelessWidget {
  const _TitleAndWidget({required this.title, required this.subtitle, Key? key})
      : super(key: key);
  final String title;
  final Widget subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle,
        ],
      ),
    );
  }
}
