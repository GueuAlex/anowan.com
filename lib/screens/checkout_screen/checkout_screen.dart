import 'package:flutter/material.dart';
import 'package:ticketwave/config/app_text.dart';

import '../../widgets/app_bar_leading.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = 'check_screen';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppText.medium('Check out'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: AppBarLeading(),
      ),
      body: Center(
        child: AppText.medium('Check out screen'),
      ),
    );
  }
}
