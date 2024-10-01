import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/screens/auth/setup/setup_screen.dart';
import 'package:ticketwave/widgets/custom_button.dart';
import 'package:ticketwave/widgets/horizontal_separator.dart';
import 'package:ticketwave/widgets/infos_column.dart';
import 'package:ticketwave/widgets/vertical_separator.dart';

import '../../../remote_service/remote_service.dart';
import '../../../widgets/sheet_closer_cross.dart';
import '../otp/otp_screen.dart';

class TakeUserInfos extends StatefulWidget {
  static String routeName = "takeUserInfos";
  const TakeUserInfos({super.key});

  @override
  State<TakeUserInfos> createState() => _TakeUserInfosState();
}

class _TakeUserInfosState extends State<TakeUserInfos> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = 'Je préfère ne pas répondre';
  List<String> _genderList = [
    'Je préfère ne pas répondre',
    'Homme',
    'Femme',
    'Non-binaire',
    'Autre',
  ];

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OTPScrenArgs;
    return Scaffold(
      backgroundColor: Palette.scafoldColor,
      appBar: AppBar(
        title: AppText.medium('Mes informatios'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () => _submit(args),
              child: AppText.medium(
                'Inscription',
                fontWeight: FontWeight.w400,
                color: Palette.appRed,
              ),
            ),
          )
        ],
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        highlightColor: Colors.transparent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(25),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Palette.separatorColor,
                      width: 0.8,
                    ),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  //height: 45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.2,
                      color: Palette.separatorColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        //height: 45,

                        // decoration: BoxDecoration(b),
                        child: Row(
                          children: [
                            //Gap(3),
                            Expanded(
                              child: Functions.getTextField(
                                controller: _firstnameController,
                                textFieldLabel: 'Votre nom',
                              ),
                            ),
                            verticalSeparator(width: 0.8),
                            Expanded(
                              child: Functions.getTextField(
                                controller: _lastNameController,
                                textFieldLabel: 'Vos prénoms',
                              ),
                            )
                          ],
                        ),
                      ),
                      horizontalSeparator(width: double.infinity, height: 0.7),
                      Row(
                        children: [
                          Expanded(
                            child: Functions.getTextField(
                              controller: _passwordController,
                              textFieldLabel: 'Définir un mot de passe',
                              obscureText: _obscureText,
                            ),
                          ),
                          Gap(5),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              !_obscureText
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: AppText.medium(
                    fontWeight: FontWeight.w300,
                    'Votre nom et prénoms seront public et nous envorrons des notifications à l\'adresse e-mail fournie.'),
              ),
              Gap(25),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Palette.separatorColor,
                      width: 0.8,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final DateTime? result =
                            await showAdaptiveDateTimePicker(
                          context: context,
                          mode: DateTimeFieldPickerMode.date,
                          initialPickerDateTime: DateTime.now(),
                          //lastDate: DateTime(year),
                          pickerPlatform: DateTimeFieldPickerPlatform.adaptive,
                        );
                        setState(() {
                          _selectedDate = result ?? DateTime.now();
                        });
                      },
                      child: InfosColumn(
                        height: 50,
                        label: 'Date de naissance',
                        labelFontSize: 15,
                        widget: AppText.medium(
                          DateFormat('EEEE d MMMM yyyy', 'fr')
                              .format(_selectedDate),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: horizontalSeparator(
                            width: double.infinity, height: 0.8)),
                    InkWell(
                      onTap: () => Functions.showSimpleBottomSheet(
                          ctxt: context, widget: _genderSelector()),
                      child: InfosColumn(
                        height: 50,
                        label: 'Genre',
                        labelFontSize: 15,
                        widget: AppText.medium(_selectedGender),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: AppText.medium(
                  fontWeight: FontWeight.w300,
                  'L\'âge et le sexe permmettent d\'améliorer les recommandations et d\'accéder aux informations sur les événements.',
                ),
              ),
              Gap(20),
              //if (!Platform.isIOS)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: CustomButton(
                  color: Palette.appRed,
                  width: double.infinity,
                  height: 35,
                  radius: 5,
                  text: 'Inscription',
                  onPress: () => _submit(args),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _genderSelector() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          sheetCloserCross(
              ctxt: context,
              text: 'Sélectionner un genre',
              fontWeight: FontWeight.w400),
          Gap(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _genderList.map((gender) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedGender = gender;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText.medium(
                              gender,
                              fontSize: 16.5,
                            ),
                          ),
                          Gap(5),
                          Container(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ));

  void _submit(OTPScrenArgs args) async {
    if (_firstnameController.text.trim().isEmpty) {
      Functions.showToast(msg: 'Renseignez votre nom');
      return;
    }
    if (_lastNameController.text.trim().isEmpty) {
      Functions.showToast(msg: 'Renseignez votre prénom');
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      Functions.showToast(msg: 'Renseignez un mot de passe');
      return;
    }
    if (_passwordController.text.trim().length < 8) {
      Functions.showToast(
        msg: 'Le mot de passe doit contenir au moins 8 caractères',
      );
      return;
    }
    EasyLoading.show();
    Map<String, dynamic> _payload = {};

    _payload = {
      'firstname': _lastNameController.text,
      'name': _firstnameController.text,
      /* "email": args.login, */
      'password': _passwordController.text,
      "gender": _selectedGender,
      "birth_date": _selectedDate.toIso8601String(),
    };

    // print(_payload);
    /* EasyLoading.dismiss();
    return; */
    await RemoteService()
        .postSomethings(
      api: 'users/register',
      data: args.isEmail
          ? {..._payload, 'email': args.login}
          : {..._payload, 'phone': args.login, 'zip_code': args.zipCode},
    )
        .then((r) async {
      print(r.statusCode);
      print(r.body);

      if (r.statusCode == 200 || r.statusCode == 201) {
        //Functions.showToast(msg: 'Inscription réussie');
        await Future.delayed(const Duration(seconds: 5));
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacementNamed(
          /*  NewPassCodeScreen.routeName, */ /* PassCodeScreen.routeName, */
          SetupScreen.routeName,
          arguments: args,
        );
      } else /* if (r.statusCode == 400 || r.statusCode == 422) */ {
        EasyLoading.dismiss();
        Functions.showToast(msg: 'Erreur lors de l\'inscription');
      }
    });
    EasyLoading.dismiss();
  }
}
