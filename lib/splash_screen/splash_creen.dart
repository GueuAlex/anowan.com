import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

//import '../screens/home/home_screen.dart';
import '../widgets/bottom_bar.dart';

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
        BottomBar.routeName,
        /* RegistrationScreen.routeName, */
        /* IntroScrenn.routeName, */
        (route) => false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              SizedBox(
                width: 100,
                child: Image(
                  image: AssetImage('assets/images/logo-text-short.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Palette.appRed,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
