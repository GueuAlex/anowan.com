import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';

import '../otp/otp_screen.dart';

class EmailTextInput extends StatelessWidget {
  const EmailTextInput({
    super.key,
    required this.controller,
    required this.size,
  });
  final TextEditingController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    //String initialCountry = 'NG';

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Color.fromARGB(5, 61, 68, 74),
              border: Border.all(
                width: 0.3,
                color: const Color.fromARGB(255, 61, 68, 74),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "adresse email",
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                // Custom border
                contentPadding: EdgeInsets.all(8.0),
                prefixIcon: Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: const Color.fromARGB(
                            255, 61, 68, 74), // Change the color as needed
                        width: 1.0, // Change the width as needed
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      FluentIcons.mail_24_filled,
                      size: 20,
                      color: Color.fromARGB(255, 27, 30, 32),
                    ),
                  ),
                ),
              ),
            )),
        Gap(10),
        SizedBox(
          width: Functions.contextSize(context).width,
          height: (size.height * 0.05),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              OtpScreen.routeName,
            ),
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(
                Palette.appRed,
              ),
            ),
            child: Center(
              child: AppText.medium(
                'Contiuner',
                fontSize: 14,
                color: Palette.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
