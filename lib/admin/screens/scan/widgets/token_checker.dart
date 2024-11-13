import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/app_text.dart';
import '../../../../config/functions.dart';
import '../../../../config/palette.dart';
import '../../../../widgets/all_sheet_header.dart';
import '../../../../widgets/infos_column.dart';

class TokenChecker extends StatefulWidget {
  const TokenChecker({super.key});

  @override
  State<TokenChecker> createState() => _TokenCheckerState();
}

class _TokenCheckerState extends State<TokenChecker> {
  TextEditingController _tokenController = TextEditingController();
  // animated rounded btn controller
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      width: double.infinity,
      height: 235,
      margin: EdgeInsets.only(bottom: keyboardHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          AllSheetHeader(),
          Gap(10),
          AppText.medium('Clé d\'autorisation'),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                InfosColumn(
                  height: 60,
                  opacity: 0.2,
                  label: 'Entrez la clé de scan',
                  widget: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Functions.getTextField(
                          controller: _tokenController, textFieldLabel: 'clé'),
                    ),
                  ),
                ),
                Gap(20),
                /* CustomButton(
                  color: Palette.primaryColor,
                  width: double.infinity,
                  height: 45,
                  radius: 5,
                  text: 'Vérifier',
                  onPress: () {},
                ) */

                RoundedLoadingButton(
                  elevation: 1,
                  height: 40,
                  borderRadius: 5,
                  color: Palette.appRed,
                  controller: _btnController,
                  onPressed: () async {
                    ////////////implementer la l'enregistrement local  du token
                    if (_tokenController.text.isEmpty) {
                      _btnController.reset();
                      EasyLoading.showToast(
                        'Veuillez renseigner le champ !',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                      return;
                    }

                    String _token = _tokenController.text;
                    //print(_token);

                    // Obtain shared preferences.
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    // Save an String value to 'action' key.
                    bool _tokenIsSet =
                        await prefs.setString('scantoken', _token);

                    if (_tokenIsSet) {
                      _btnController.success();
                      EasyLoading.showToast(
                        'Token enregistré avec succès.',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                      Navigator.pop(context);
                    } else {
                      _btnController.reset();
                      EasyLoading.showToast(
                        'Something went wrong try again !',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                    }
                    ////////:

                    ////////////////////////////////////////////////////////////////
                  },
                  child: const Text(
                    'Enregistrer la clé',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
