import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'admin/screens/scan/scan_screen.dart';
import 'config/palette.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/auth/setup/setup_screen.dart';
import 'screens/auth/user_infos/take_user_infos.dart';
import 'screens/notification_screen/notification_screen.dart';
import 'screens/auth/new_pass_code/confirm_pass_code.dart';
import 'screens/auth/new_pass_code/new_pass_code.dart';
import 'screens/auth/otp/otp_screen.dart';
import 'screens/auth/pass_code/pass_code_screen.dart';
import 'screens/checkout_screen/checkout_screen.dart';
import 'screens/intro/intro_screen.dart';
import 'screens/maps_screen/maps_screen.dart';
import 'screens/order_screen/om/om_otp_screen.dart';
import 'screens/order_screen/order_screen.dart';
import 'screens/organizer_screen/organizer_screen.dart';
import 'screens/prestator_screen/prestator_screen.dart';
import 'screens/single_event_screen/single_event_screen.dart';
import 'screens/suggestion_screen/suggestion_screen.dart';
import 'screens/tickets_swap_screen/tickets_swap_screen.dart';
import 'screens/user_details_screen/profil_settings/profil_settings.dart';
import 'screens/user_details_screen/user_details_screen.dart';
import 'screens/welcome/welcome_screen.dart';
import 'splash_screen/splash_creen.dart';
import 'widgets/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: IziBillet(),
    ),
  );
}

class IziBillet extends StatelessWidget {
  const IziBillet({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        // Vérifie si le pop a eu lieu
        if (didPop) {
          if (Navigator.of(context).canPop()) {
            return; // Permet de revenir en arrière si possible
          } else {
            if (Platform.isAndroid) {
              exit(0); // Quitte l'application sous Android
            } else {
              SystemNavigator.pop(); // Ferme l'application sous iOS
            }
            return;
          }
        }
        return;
      },
      child: MaterialApp(
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
          AuthScreen.routeName: (context) => const AuthScreen(),
          TakeUserInfos.routeName: (ctxt) => const TakeUserInfos(),
          SetupScreen.routeName: (ctxt) => const SetupScreen(),
          IntroScrenn.routeName: (ctxt) => const IntroScrenn(),
          OtpScreen.routeName: (ctxt) => const OtpScreen(),
          PassCodeScreen.routeName: (ctxt) => const PassCodeScreen(),
          NewPassCodeScreen.routeName: (ctxt) => const NewPassCodeScreen(),
          ConfirmPassCodeScreen.routeName: (ctxt) =>
              const ConfirmPassCodeScreen(),
          NotificationScreen.routeName: (ctxt) => const NotificationScreen(),
          MapsScreen.routeName: (ctxt) => const MapsScreen(),
          OrganizerScreen.routeName: (ctxt) => const OrganizerScreen(),
          PrestatorScreen.routeName: (ctxt) => const PrestatorScreen(),
          UserDetailsScreen.routeName: (ctxt) => const UserDetailsScreen(),
          TicketsSwapScreen.routeName: (ctxt) => const TicketsSwapScreen(),
          ProfilSettings.routeName: (ctxt) => const ProfilSettings(),
          SuggestionScreen.routeName: (ctxt) => const SuggestionScreen(),
          WelcomeScreen.routeName: (ctxt) => const WelcomeScreen(),
          OmOtpScreen.routeName: (ctxt) => const OmOtpScreen()
        },
      ),
    );
  }
}
