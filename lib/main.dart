import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'admin/screens/scan/scan_screen.dart';
import 'config/palette.dart';
import 'notification/notification_screen.dart';
import 'screens/auth/new_pass_code/confirm_pass_code.dart';
import 'screens/auth/new_pass_code/new_pass_code.dart';
import 'screens/auth/otp/otp_screen.dart';
import 'screens/auth/pass_code/pass_code_screen.dart';
import 'screens/auth/registration/registration.dart';
import 'screens/checkout_screen/checkout_screen.dart';
import 'screens/intro/intro_screen.dart';
import 'screens/maps_screen/maps_screen.dart';
import 'screens/order_screen/order_screen.dart';
import 'screens/single_event_screen/single_event_screen.dart';
import 'splash_screen/splash_creen.dart';
import 'widgets/bottom_bar.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      locale: const Locale('eu', 'FR'),
      title: 'Anowan.com',
      theme: ThemeData(
        useMaterial3: true, //scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      builder: EasyLoading.init(),
      // home: SearchbarAnimationExample(),
      initialRoute: SplashSceen.routeName,
      routes: {
        '/': (ctxt) => const BottomBar(),
        SplashSceen.routeName: (ctxt) => const SplashSceen(),
        ScanScreen.routeName: (ctxt) => const ScanScreen(),
        SingleEventScreen.routeName: (ctxt) => const SingleEventScreen(),
        OrderScreen.routeName: (ctxt) => const OrderScreen(),
        CheckoutScreen.routeName: (ctxt) => const CheckoutScreen(),
        RegistrationScreen.routeName: (ctxt) => const RegistrationScreen(),
        IntroScrenn.routeName: (ctxt) => const IntroScrenn(),
        OtpScreen.routeName: (ctxt) => const OtpScreen(),
        PassCodeScreen.routeName: (ctxt) => const PassCodeScreen(),
        NewPassCodeScreen.routeName: (ctxt) => const NewPassCodeScreen(),
        ConfirmPassCodeScreen.routeName: (ctxt) =>
            const ConfirmPassCodeScreen(),
        NotificationScreen.routeName: (ctxt) => const NotificationScreen(),
        MapsScreen.routeName: (ctxt) => const MapsScreen(),
      },
    );
  }
}
