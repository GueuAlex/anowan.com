import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

import '../admin/screens/scan/scan_screen.dart';

class SplashSceen extends StatefulWidget {
  static String routeName = 'splash_screen';
  const SplashSceen({super.key});

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushNamedAndRemoveUntil(
        context,
        ScanScreen.routeName,
        (route) => false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Palette.appRed,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
