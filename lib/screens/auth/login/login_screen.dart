import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/local_service/local_service.dart';
import 'package:ticketwave/model/user_model.dart';
import 'package:ticketwave/widgets/bottom_bar.dart';
import 'package:ticketwave/widgets/custom_button.dart';
import 'package:ticketwave/widgets/horizontal_separator.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../constants/constants.dart';
import '../../../providers/providers.dart';
import '../../../remote_service/remote_service.dart';
import '../widgets/redirect_to.dart';
import '../widgets/terms_of_us.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    super.key,
    required this.loginController,
    required this.passwordController,
    required this.toggleAppBar,
  });

  final TextEditingController loginController;
  final TextEditingController passwordController;
  final VoidCallback toggleAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedCountry = ref.watch(selectedCountryProvider);
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Gap(45),
        SizedBox(
          width: Functions.contextSize(context).width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 155,
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
            fontSize: 18,
          ),
        ),
        AppText.small(
          'Se connecter',
          textAlign: TextAlign.center,
          fontSize: 14,
        ),
        Gap(30),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Palette.separatorColor,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.045,
                child: Functions.getTextField(
                  controller: loginController,
                  textFieldLabel: 'email ou téléphone',
                  fontSize: 16.5,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              horizontalSeparator(height: 0.8, width: double.infinity),
              SizedBox(
                height: size.height * 0.045,
                child: Functions.getTextField(
                  controller: passwordController,
                  textFieldLabel: 'Mot de passe',
                  obscureText: true,
                  fontSize: 16.5,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: CustomButton(
            color: Palette.appRed,
            width: double.infinity,
            height: 40,
            radius: 5,
            text: 'Connexion',
            onPress: () => _handleLogin(ref: ref, ctxt: context),
          ),
        ),
        Container(
          width: size.width,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: TextButton(
              style: TextButton.styleFrom(
                // Splash color
                backgroundColor: Colors.transparent, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                splashFactory: InkRipple.splashFactory, // Ripple effect
              ),
              onPressed: () {},
              child: AppText.small(
                'Mot de passe oublié ?',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Palette.appRed,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RedirectTo(
            size: size,
            text: 'S\'inscrire',
            question: 'Vous n\'avez pas un compte ? ',
            onPressed: () => toggleAppBar(),
          ),
        ),
        Gap(10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: horizontalSeparator(height: 0.8)),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            onTap: () => Functions.launchUri(
              url: termsOFus,
            ),
            child: TermsOfUs(size: size),
          ),
        )
      ],
    );
  }

  void _handleLogin(
      {required WidgetRef ref, required BuildContext ctxt}) async {
    // Vérification des champs
    if (!_validateInputs()) return;

    EasyLoading.show();

    LocalService localService = LocalService();
    String login = loginController.text.trim();
    String password = passwordController.text.trim();

    // Définir la regex pour l'email
    final RegExp emailPattern =
        RegExp(r"^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$");

    // Définir le payload pour l'API
    Map<String, dynamic> payload = emailPattern.hasMatch(login)
        ? {'email': login, 'password': password}
        : await _getPhonePayload(ref, login, password);

    // Appel à l'API de connexion
    await _attemptLogin(localService, ctxt, payload);
  }

  bool _validateInputs() {
    if (passwordController.text.isEmpty) {
      Functions.showToast(msg: 'Veuillez entrer votre mot de passe');
      return false;
    }

    if (loginController.text.isEmpty) {
      Functions.showToast(msg: 'Veuillez entrer votre email ou votre numéro');
      return false;
    }

    if (passwordController.text.trim().length < 8) {
      Functions.showToast(msg: 'Mot de passe invalide');
      return false;
    }

    return true;
  }

  Future<Map<String, dynamic>> _getPhonePayload(
      WidgetRef ref, String phone, String password) async {
    final zipcode = await ref.read(selectedCountryProvider)?.zipCode ?? '';
    return {
      'phone': phone,
      'zip_code': zipcode,
      'password': password,
    };
  }

  Future<void> _attemptLogin(LocalService localService, BuildContext ctxt,
      Map<String, dynamic> payload) async {
    await RemoteService()
        .postSomethings(api: 'users/login', data: payload)
        .then((r) async {
      EasyLoading.dismiss();

      if (r.statusCode == 200 || r.statusCode == 201) {
        var json = jsonDecode(r.body);
        UserModel userFromApi = UserModel.fromJson(json['user']);
        UserModel? localUser = await localService.getUser();
        if (localUser != null) {
          if (localUser.id == userFromApi.id) {
            // set logged state
            await Functions.setLoggedState(isLogged: true);
            Navigator.of(ctxt)
                .pushNamedAndRemoveUntil(BottomBar.routeName, (route) => false);
          } else {
            // drop table and save userFromApi
            await localService.clearUserTable();
            // save userFromApi
            int sqlResult = await localService.saveUser(userFromApi);
            if (sqlResult != 0) {
              // set logged state
              await Functions.setLoggedState(isLogged: true);
              Navigator.of(ctxt).pushNamedAndRemoveUntil(
                  BottomBar.routeName, (route) => false);
            } else {
              Functions.showToast(
                  msg: 'Something went wrong, please try again');
            }
          }
        } else {
          // save userFromApi
          int sqlResult = await localService.saveUser(userFromApi);
          if (sqlResult != 0) {
            // set logged state
            await Functions.setLoggedState(isLogged: true);
            Navigator.of(ctxt)
                .pushNamedAndRemoveUntil(BottomBar.routeName, (route) => false);
          } else {
            Functions.showToast(msg: 'Something went wrong, please try again');
          }
        }
      } else {
        Functions.showToast(msg: 'Mot de passe invalide');
      }
    }).catchError((error) {
      EasyLoading.dismiss();
      Functions.showToast(
          msg: 'Erreur lors de la connexion : ${error.toString()}');
    });
  }
}
