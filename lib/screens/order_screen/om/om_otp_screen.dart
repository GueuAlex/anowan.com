import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/dialog_modal.dart';
import 'widgets/app_bar.dart';

class OmOtpScreen extends StatefulWidget {
  static const routeName = '/omotpscreen';
  const OmOtpScreen({super.key});

  @override
  State<OmOtpScreen> createState() => _OmOtpScreenState();
}

class _OmOtpScreenState extends State<OmOtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Color.fromARGB(255, 255, 244, 227),
                Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarCusttom(
                    title: 'Paiement OM',
                    leadingText: '',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 48),
                        // Login form
                        const Text(
                          'Code OTP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppText.small(
                          'Veuillez générer un code OTP sur votre mobile',
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        'assets/images/pay1.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Gap(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText.medium(
                                        'Orange Money',
                                        fontSize: 18,
                                        height: 1.2,
                                      ),
                                      AppText.small('+225 07890495849'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            //const Gap(10),
                            Expanded(
                              child: Container(
                                height: 55,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Palette.separatorColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Functions.getTextField(
                                        controller: _otpController,
                                        textFieldLabel: 'OPT',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Functions.showCustomDialog(
                                          context: context,
                                          child: DialogModal(),
                                        );
                                      },
                                      child: Icon(
                                        FluentIcons.question_circle_24_filled,
                                        color: const Color.fromARGB(
                                          255,
                                          55,
                                          55,
                                          55,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(45),
                        CustomButton(
                          color: Palette.appRed,
                          width: double.infinity,
                          height: 40,
                          radius: 5,
                          text: 'Confirmer',
                          onPress: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
