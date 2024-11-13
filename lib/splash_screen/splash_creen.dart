import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../config/functions.dart';
import '../config/palette.dart';
import '../config/preferences.dart';
import '../screens/intro/intro_screen.dart';
import '../widgets/bottom_bar.dart';

class SplashSceen extends StatefulWidget {
  static String routeName = 'splash_screen';
  const SplashSceen({super.key});

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _showLoading = false;

  @override
  void initState() {
    // dropTable();
    setinitPositiob();
    super.initState();

    // Initialiser le contrôleur d'animation
    _controller = AnimationController(vsync: this);

    // Écouter l'état de l'animation pour savoir quand elle est terminée
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // Action à effectuer à la fin de l'animation
        /* Navigator.pushReplacementNamed(context, IntroScrenn.routeName); */
        _toggleLoading();
        // get logged state
        bool isLogged = await Functions.getLoggedState();
        Future.delayed(const Duration(seconds: 3)).then(
          (value) => Navigator.pushReplacementNamed(
            context,
            /* BottomBar.routeName, */
            /* RegistrationScreen.routeName, */
            !isLogged ? IntroScrenn.routeName : BottomBar.routeName,
            /* SetupScreen.routeName, */
            /*  WelcomeScreen.routeName, */
            /* SetupScreen.routeName, */
            /*  ScanScreen.routeName, */
            /*  ScanScreen.routeName, */
            /* (route) => false, */
          ),
        );
      }
    });
  }

  /*  void dropTable() async {
    LocalService localService = LocalService();
    int r = await localService.dropTable();
    print(r);
  } */

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              SizedBox(
                width: 350,
                child: Lottie.asset(
                  'assets/images/simple-dot.json',
                  controller: _controller,
                  animate: true,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
              Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 40),
                  child: _showLoading
                      ? CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.appRed,
                          ),
                        )
                      : Container())
            ],
          ),
        ),
      ),
    );
  }

  _toggleLoading() {
    setState(() {
      _showLoading = !_showLoading;
    });
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
