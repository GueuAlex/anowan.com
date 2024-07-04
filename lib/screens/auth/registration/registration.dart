import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/screens/auth/widgets/phone_number_input.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../widgets/custom_leading.dart';
import '../widgets/email_text_field.dart';
import '../widgets/terms_of_us.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "registrationScreen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isEmail = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.large(
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: Functions.contextSize(context).height / 2.8,
            leadingWidth: 28,
            leading: CustomLeading(),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.all(0),
              background: SafeArea(
                child: Image.asset(
                  'assets/images/people.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Gap(45),
                SizedBox(
                  width: Functions.contextSize(context).width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 135,
                    ),
                    child: Image(
                      image: AssetImage('assets/images/logo-text-short.jpg'),
                    ),
                  ),
                ),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AppText.large(
                    'Vos événements à portée de main',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                AppText.small(
                  'Login or Sign up',
                  textAlign: TextAlign.center,
                  fontSize: 14,
                ),
                Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.bounceIn,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: Offset(1.0, 0.0), // Slide in from right
                        end: Offset(0.0, 0.0),
                      ).animate(animation);

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                    child: isEmail
                        ? EmailTextInput(
                            controller: emailController,
                            size: size,
                          )
                        : PhoneInput(
                            controller: phoneController,
                            size: size,
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: AppText.medium(
                      'OU',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: Functions.contextSize(context).width,
                    height: (size.height * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(46, 61, 68, 74),
                    ),
                    child: InkWell(
                      onTap: () => setState(() {
                        isEmail = !isEmail;
                      }),
                      child: Center(
                        child: !isEmail
                            ? continuerWith(
                                icon: FluentIcons.mail_24_filled,
                                text: 'Continuer avec email',
                              )
                            : continuerWith(
                                icon: FluentIcons.phone_24_filled,
                                text: 'Continuer avec téléphone',
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: TermsOfUs(size: size),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Row continuerWith({
    required IconData icon,
    required String text,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Color.fromARGB(255, 27, 30, 32),
          ),
          Gap(8.0),
          AppText.medium(
            text,
            fontSize: 15,
            color: Color.fromARGB(255, 27, 30, 32),
          ),
        ],
      );
}
