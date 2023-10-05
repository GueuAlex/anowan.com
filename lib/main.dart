import 'package:flutter/material.dart';
import 'package:ticketwave/admin/screens/scan/scan_screen.dart';
import 'package:ticketwave/config/palette.dart';
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
      title: 'Anowan.com',
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
      ),
      //home: const BottomBar(),
      routes: {
        BottomBar.routeName: (ctxt) => const BottomBar(),
        ScanScreen.routeName: (ctxt) => const ScanScreen(),
      },
    );
  }
}
