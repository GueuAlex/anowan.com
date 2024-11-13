import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/model/third_party_model.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../providers/providers.dart';
import '../../../widgets/b_country_selector.sheet.dart';
import 'custome_toggle_switch.dart';
import 'sheet_header.dart';

class ThirdPartForm extends ConsumerStatefulWidget {
  const ThirdPartForm({
    super.key,
    this.thirdPart,
  });

  final ThirdPartyModel? thirdPart;

  @override
  _ThirdPartFormState createState() => _ThirdPartFormState();
}

class _ThirdPartFormState extends ConsumerState<ThirdPartForm> {
  final _bnamController = TextEditingController();
  final _bemailControler = TextEditingController();
  final _bprenomController = TextEditingController();
  final _bphoneController = TextEditingController();

  @override
  void dispose() {
    _bnamController.dispose();
    _bemailControler.dispose();
    _bprenomController.dispose();
    _bphoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.thirdPart != null) {
      _bnamController.text = widget.thirdPart!.name;
      _bemailControler.text = widget.thirdPart!.email ?? '';
      _bprenomController.text = widget.thirdPart!.firstname;
      _bphoneController.text = widget.thirdPart!.phone ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(bselectedCountryProvider);
    final selectedRecepient = ref.watch(selectedRecepientProvider);
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sheetheader(context: context, text: 'Informations du bénéficiaire'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AppText.medium(
                      'Par quel moyen le bénéficiaire recevra le(s) billet(s) ?',
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                  Gap(5),
                  CustomToggleSwitch(),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AppText.medium(
                      'Informations de contacts',
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 95,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Palette.separatorColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Palette.separatorColor,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Functions.getTextField(
                                      controller: _bnamController,
                                      textFieldLabel: 'Nom',
                                      fontSize: 16.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Functions.getTextField(
                                      controller: _bprenomController,
                                      textFieldLabel: 'Prénoms',
                                      fontSize: 16.5,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Palette.separatorColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: size.height,
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(10),
                                    color: Palette.separatorColor,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Icon(
                                        FluentIcons.mail_16_regular,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Functions.getTextField(
                                      controller: _bemailControler,
                                      textFieldLabel: 'Email',
                                      fontSize: 16.5,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: AppText.medium(
                      'Numéro de portable',
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: double.infinity,
                      height: (size.height * 0.05),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(5, 61, 68, 74),
                        border: Border.all(
                          width: 0.35,
                          color: const Color.fromARGB(255, 201, 201, 201),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Functions.showSimpleBottomSheet(
                              ctxt: context,
                              widget: BCountrySelectorSheet(),
                            ),
                            child: Container(
                              width: 70,
                              height: (size.height * 0.05),
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Palette.separatorColor,
                              ),
                              child: AppText.medium(
                                '+${selectedCountry?.zipCode ?? ''}',
                                fontSize: 16.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Functions.getTextField(
                              controller: _bphoneController,
                              textFieldLabel: 'Portable du bénéficiaire',
                              fontSize: 16.5,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  if (selectedRecepient == 'SMS' ||
                      selectedRecepient == 'Les deux')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Palette.appRed.withOpacity(0.07),
                          border: Border(
                            bottom: BorderSide(
                              color: Palette.appRed,
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color: Palette.appRed,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Text(
                          'Un montant de 100 ₣ sera appliqué pour supporter le service d\'envoie de SMS',
                          style: TextStyle(
                            color: Palette.appRed,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  Gap(25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      color: Palette.appRed,
                      width: double.infinity,
                      height: 35,
                      radius: 5,
                      text: 'Enregistrer le bénéficiaire',
                      onPress: () => _handleThirdParty(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleThirdParty() async {
    final selectedRecepient = ref.watch(selectedRecepientProvider);

    // Vérification des champs requis
    if (_bnamController.text.trim().isEmpty) {
      Functions.showToast(msg: 'Veuillez renseigner un nom !');
      return;
    }
    if (_bprenomController.text.trim().isEmpty) {
      Functions.showToast(msg: 'Veuillez renseigner un prénom !');
      return;
    }

    // Validation de l'email si nécessaire
    if ((selectedRecepient == 'E-mail' || selectedRecepient == 'Les deux') &&
        _bemailControler.text.trim().isEmpty) {
      Functions.showToast(msg: 'Veuillez renseigner une adresse mail !');
      return;
    }
    final emailPattern = RegExp(r"^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$");
    if ((selectedRecepient == 'E-mail' || selectedRecepient == 'Les deux') &&
        !emailPattern.hasMatch(_bemailControler.text.trim())) {
      Functions.showToast(msg: 'Veuillez renseigner une adresse mail valide !');
      return;
    }

    // Validation du numéro de téléphone si nécessaire
    if ((selectedRecepient == 'SMS' || selectedRecepient == 'Les deux') &&
        _bphoneController.text.trim().isEmpty) {
      Functions.showToast(msg: 'Veuillez renseigner un numéro de téléphone !');
      return;
    }

    // Logique de sauvegarde
    EasyLoading.show();
    await Future.delayed(const Duration(seconds: 3));

    final country = ref.read(bselectedCountryProvider);
    final ThirdPartyModel thirdParty = ThirdPartyModel(
      name: _bnamController.text.trim(),
      firstname: _bprenomController.text.trim(),
      recepient: selectedRecepient,
      email: _bemailControler.text,
      phone: _bphoneController.text,
      zipcode: country!.zipCode,
    );
    ref.read(thirdPartyProvider.notifier).state = thirdParty;
    EasyLoading.dismiss();
    Navigator.pop(context);
  }
}
