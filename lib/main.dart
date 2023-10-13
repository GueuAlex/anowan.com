import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ticketwave/admin/screens/scan/scan_screen.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/screens/single_event_screen/single_event_screen.dart';
import 'package:ticketwave/splash_screen/splash_creen.dart';
import 'package:ticketwave/widgets/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        primaryColor: Palette.primaryColor,
      ),
      builder: EasyLoading.init(),
      //home: const BottomBar(),
      initialRoute: SplashSceen.routeName,
      routes: {
        '/': (ctxt) => const BottomBar(),
        SplashSceen.routeName: (ctxt) => const SplashSceen(),
        ScanScreen.routeName: (ctxt) => const ScanScreen(),
        SingleEventScreen.routeName: (ctxt) => const SingleEventScreen(),
      },
    );
  }
}
