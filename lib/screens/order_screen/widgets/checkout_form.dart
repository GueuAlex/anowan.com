import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/screens/order_screen/widgets/text_midle.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../providers/providers.dart';
import '../../../widgets/country_selector.sheet.dart';
import '../../../widgets/custom_button.dart';
import 'checkout_details_sheet.dart';
import 'operator_switch.dart';

class CheckoutForm extends ConsumerStatefulWidget {
  const CheckoutForm({super.key, required this.onCancel});
  final VoidCallback onCancel;

  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends ConsumerState<CheckoutForm> {
  // CountryModel _selectedCountry = CountryModel.list[3];
  final _namController = TextEditingController();
  final _emailControler = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//providers
    final selectedCountry = ref.watch(selectedCountryProvider);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: AppText.medium(
                  'Operateur',
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 46, 46, 46),
                ),
              ),
              InkWell(
                onTap: () => Functions.showSimpleBottomSheet(
                  ctxt: context,
                  widget: OperatorSwitch(),
                ),
                child: AppText.medium(
                  'Modifier',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: Palette.appRed,
                ),
              ),
              Gap(8),
            ],
          ),
        ),
        // show selected operator
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
                            controller: _namController,
                            textFieldLabel: 'Nom',
                            fontSize: 16.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Functions.getTextField(
                            controller: _prenomController,
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
                            controller: _emailControler,
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: AppText.medium(
            'Numéro de paiement',
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
                    widget: CountrySelectorSheet(),
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
                    controller: _phoneController,
                    textFieldLabel: 'N° de téléphone',
                    fontSize: 16.5,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox.adaptive(
                value: true,
                onChanged: (value) {},
                checkColor: Colors.white,
                fillColor: WidgetStatePropertyAll(Palette.appRed),
                activeColor: Palette.appRed,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(7),
                  AppText.medium(
                    'Se souvenir de moi',
                    fontWeight: FontWeight.w400,
                  ),
                  AppText.small(
                    'Pour un prochain achat encore plus rapide et sans tracas !',
                    fontWeight: FontWeight.w300,
                  )
                ],
              )
            ],
          ),
        ),
        Gap(25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65),
          child: textMidleLine(text: 'Termes et conditions'),
        ),
        Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'En continuant, je suis d\'accord avec les ',
              style: TextStyle(
                color: Color.fromARGB(255, 27, 27, 27),
                fontSize: 11.7,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(
                  text: 'conditions générales de paiement',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Palette.appRed,
                  ),
                ),
                TextSpan(
                  text: ' et j\'accepte les ',
                  //style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'termes et politiques  ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Palette.appRed),
                ),
                TextSpan(text: 'relatifs au '),
                TextSpan(
                  text: 'traitement de données de anowan.com',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Palette.appRed,
                  ),
                ),
                TextSpan(
                  text: '.',
                  // style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Gap(35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  textColor: Colors.black,
                  // opacity: 0.25,
                  color: Colors.black.withOpacity(0.08),
                  width: double.infinity,
                  height: 40,
                  radius: 5,
                  text: 'Annuler',
                  onPress: widget.onCancel,
                ),
              ),
              Gap(10),
              Expanded(
                child: CustomButton(
                  color: Palette.appRed,
                  width: double.infinity,
                  height: 40,
                  radius: 5,
                  text: 'Continuer',
                  onPress: () => Functions.showSimpleBottomSheet(
                    ctxt: context,
                    widget: CheckoutDetailsSheet(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*  void _selectCountry(CountryModel country) {
    _selectedCountry = country;
  } */
}
