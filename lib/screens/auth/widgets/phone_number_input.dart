import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';

import '../otp/otp_screen.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    super.key,
    required this.controller,
    required this.size,
  });
  final TextEditingController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    //String initialCountry = 'NG';
    PhoneNumber number = PhoneNumber(isoCode: 'CI');
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
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              useBottomSheetSafeArea: true,
              leadingPadding: 0,
              useEmoji: true,
            ),
            locale: 'fr',
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(
              color: Colors.black,
            ),
            initialValue: number,
            textFieldController: controller,
            formatInput: true,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputDecoration: InputDecoration(
              hintText: "numéro",
              hintStyle: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(168, 0, 0, 0),
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

              // Border only on the left side

              prefixIcon: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 2,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border(
                    left: BorderSide(
                      color: const Color.fromARGB(
                          255, 61, 68, 74), // Change the color as needed
                      width: 1.0, // Change the width as needed
                    ),
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints.loose(Size.zero),
            ),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ),
        Gap(10),
        SizedBox(
          width: Functions.contextSize(context).width,
          height: (size.height * 0.05),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              OtpScreen.routeName,
            ),
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                Palette.appRed,
              ),
            ),
            child: Center(
              child: AppText.medium(
                'Contiuner',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Palette.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
