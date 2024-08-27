import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/model/country_model.dart';
import 'package:ticketwave/screens/order_screen/widgets/text_midle.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/custom_button.dart';
import 'checkout_details_sheet.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key, required this.onCancel});
  final VoidCallback onCancel;

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  CountryModel _selectedCountry = CountryModel.list[3];
  final _namController = TextEditingController();
  final _emailControler = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppText.medium(
            'Informations de contacts',
            fontWeight: FontWeight.w400,
          ),
        ),
        Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 90,
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
                              textFieldLabel: 'Nom'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Functions.getTextField(
                              controller: _prenomController,
                              textFieldLabel: 'Prénoms'),
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
                          width: 50,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
                color: Palette.separatorColor,
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Functions.showSimpleBottomSheet(
                    ctxt: context,
                    widget: Container(
                      height: size.height * 0.34,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _countrySelector(context: context),
                    ),
                  ).whenComplete(() => setState(() {})),
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.all(12),
                    color: Palette.separatorColor,
                    child: SvgPicture.asset(_selectedCountry.flag),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Functions.getTextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      textFieldLabel: 'Numéro',
                    ),
                  ),
                )
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    fontWeight: FontWeight.bold,
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
                      fontWeight: FontWeight.bold, color: Palette.appRed),
                ),
                TextSpan(text: 'relatifs au '),
                TextSpan(
                  text: 'traitement de données de anowan.com',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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

  Column _countrySelector({required BuildContext context}) => Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: CountryModel.list
                      .map(
                        (country) => InkWell(
                          onTap: () {
                            _selectCountry(country);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: SvgPicture.asset(
                                      country.flag,
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText.medium(
                                        country.name,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                      AppText.small('+${country.zipCode}')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      );

  Container _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: Palette.separatorColor,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          AppText.medium(
            'Selectionnez un pays',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.xmark,
                  color: Color.fromARGB(255, 20, 20, 20),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectCountry(CountryModel country) {
    _selectedCountry = country;
  }
}
