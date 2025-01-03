import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/app_text.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = "notificationScreen";
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Notifications"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              child: Image.asset('assets/images/no-notif.jpg'),
            ),
            AppText.medium(
              textAlign: TextAlign.center,
              'Aucune notification pour le moment,\nrevenez plus tard',
              //fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            Gap(30)
          ],
        ),
      ),
    );
  }
}
