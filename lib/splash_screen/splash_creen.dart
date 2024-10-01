import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticketwave/config/palette.dart';

import '../config/preferences.dart';
import '../screens/auth/setup/setup_screen.dart';
import '../screens/intro/intro_screen.dart';

//import '../screens/home/home_screen.dart';
//import '../screens/intro/intro_screen.dart';

class SplashSceen extends StatefulWidget {
  static String routeName = 'splash_screen';
  const SplashSceen({super.key});

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  @override
  void initState() {
    setinitPositiob();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushReplacementNamed(
        context,
        /* BottomBar.routeName, */
        /* RegistrationScreen.routeName, */
        /* IntroScrenn.routeName, */
        SetupScreen.routeName,
        /*  ScanScreen.routeName, */
        /* ScanScreen.routeName, */
        /* (route) => false, */
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

Future<void> setinitPositiob() async {
  final prefs = Preferences();
  await prefs.init();

  // Si aucune position par défaut n'est enregistrée, enregistre Abidjan comme position par défaut
  LatLng? defaultPosition = prefs.getDefaultPosition();
  if (defaultPosition == null) {
    await prefs.setDefaultPosition(5.345317, -4.024429);
  }
}
