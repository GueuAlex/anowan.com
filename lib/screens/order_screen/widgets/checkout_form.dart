import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/screens/order_screen/widgets/text_midle.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../local_service/local_service.dart';
import '../../../model/third_party_model.dart';
import '../../../model/user_model.dart';
import '../../../providers/providers.dart';
import '../../../providers/user.provider.dart';
import '../../../widgets/country_selector.sheet.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/dialog_modal.dart';
import 'check_button.dart';
import 'checkout_details_sheet.dart';
import 'custome_toggle_switch.dart';
import 'operator_switch.dart';
import 'third_part_form.dart';
import 'ticket_container.dart';

class CheckoutForm extends ConsumerStatefulWidget {
  const CheckoutForm({super.key, required this.onCancel});
  final VoidCallback onCancel;

  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends ConsumerState<CheckoutForm>
    with SingleTickerProviderStateMixin {
  // animation
  late AnimationController _animationController;
  // CountryModel _selectedCountry = CountryModel.list[3];
  final _namController = TextEditingController();
  final _emailControler = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();

  void _initializeForm() async {
    final selectedPass = ref.watch(selectedPassProvider);
    List<SelectedTickeModel> tickets = [];
    selectedPass.forEach((key, value) {
      print('pass id : $key');
      print('nombre de tickets : $value');

      for (int i = 0; i < value; i++) {
        tickets.add(SelectedTickeModel(passId: key));
      }
    });
    ref.read(selectedTickedProvider.notifier).state = tickets;
    final LocalService localService = await LocalService();
    final UserModel? user = await localService.getUser();
    //final UserModel? user = ref.watch(userProvider);

    if (user != null) {
      _namController.text = user.name;
      _emailControler.text = user.email ?? '';
      _prenomController.text = user.firstname ?? '';
      _phoneController.text = user.phone ?? '';
    }
  }

  // List<Map<String, dynamic>> _selectedTickets = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeForm();
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    // Perform any necessary cleanup here
    _emailControler.dispose();
    _namController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _rememberMe = true;
  //bool _isThirdParty = false;

  @override
  Widget build(BuildContext context) {
//providers
    final selectedCountry = ref.watch(selectedCountryProvider);
    final selectedOprator = ref.watch(selectedOperatorProvider);
    //final thirdPart = ref.watch(thirdPartyProvider);
    final size = MediaQuery.of(context).size;
    final selectedTicked = ref.watch(selectedTickedProvider);
    final UserModel? user = ref.watch(userProvider);

    if (selectedTicked == null) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
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
                  'Operateurs',
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 46, 46, 46),
                ),
              ),
              /*   InkWell(
                onTap: () => Functions.showSimpleBottomSheet(
                  ctxt: context,
                  widget: OperatorSwitch(),
                ),
                child: AppText.medium(
                  '',
                ),
              ), */
              Gap(8),
            ],
          ),
        ),
        Gap(10),
        // show selected operator
        OperatorSwitch(),
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
            height: (size.height * 0.055),
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
                    height: (size.height * 0.055),
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
        Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                selectedTicked.length == 1 ? 'Votre billet' : 'Vos billets',
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 46, 46, 46),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(selectedTicked.length, (i) {
                    /*   ThirdPartyModel? thirdPart;
                    if (_selectedTickets[i]['purchase_for'] != null) {
                      thirdPart = ThirdPartyModel.fromJson(
                        _selectedTickets[i]['purchase_for'],
                      );
                    } */
                    return TicketContainer(
                      ticket: selectedTicked[i],
                      thirdPart: selectedTicked[i].thirdParty,
                      onTap: () {
                        //print(thirdPart);
                        //print(user);
                        /*  if (user == null) return _showLoginSheet(); */

                        _showThirdPartyForm(
                          thirdPart: selectedTicked[i].thirdParty,
                          index: i,
                        );
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),

        // if user == null demander comment les biellet seront envoyer
        if (user == null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    AppText.medium(
                      selectedTicked.length == 1
                          ? 'Recevoir votre billet par'
                          : 'Rcevoir vos billets par',
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 46, 46, 46),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Functions.showCustomDialog(
                          context: context,
                          child: DialogModal(
                            title: 'Frais liés aux SMS',
                            message:
                                'Un montant de 100 ₣ sera appliqué  à chaque ticket pour supporter le service d\'envoie de SMS',
                          ),
                        );
                      },
                      child: Icon(
                        FluentIcons.question_circle_24_filled,
                      ),
                    )
                  ],
                ),
                const Gap(10),
                CustomToggleSwitch(),
              ],
            ),
          ),

        Gap(15),
        CheckButton(
          value: _rememberMe,
          onChanged: (p0) {
            setState(() {
              _rememberMe = !_rememberMe;
            });
          },
        ),
        /*    Gap(15),
        CheckButton(
          title: 'J\'achète pour un tiers',
          subtitle: 'Cochez cette case si vous achetez pour quelqu\'un',
          value: _isThirdParty,
          onChanged: (p0) {
            setState(() {
              _isThirdParty = !_isThirdParty;
            });
            if (_isThirdParty && thirdPart == null) {
              _showThirdPartyForm();
            }
          },
        ), */
        /*   Gap(15),
        if (thirdPart != null && _isThirdParty)
          InkWell(
            onTap: () => _showThirdPartyForm(thirdPart: thirdPart),
            child: ThirdPartyContainer(thirdPart: thirdPart),
          ), */
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
                  onPress: () {
                    if (_namController.text.trim().isEmpty) {
                      Functions.showToast(msg: 'Veuillez renseigner votre nom');
                      return;
                    }
                    if (_prenomController.text.trim().isEmpty) {
                      Functions.showToast(
                          msg: 'Veuillez renseigner votre prénom');
                      return;
                    }
                    if (_emailControler.text.trim().isNotEmpty &&
                        !Functions.isValidEmail(_emailControler.text.trim())) {
                      Functions.showToast(
                          msg: 'Veuillez renseigner un email valide');
                      return;
                    }
                    if (user == null) {
                      final selectedRecepient =
                          ref.watch(selectedRecepientProvider);
                      if (selectedRecepient == 'E-mail' ||
                          selectedRecepient == 'Les deux') {
                        if (_emailControler.text.trim().isEmpty) {
                          Functions.showToast(
                              msg: 'Veuillez renseigner votre adresse mail');
                          return;
                        }
                        if (_emailControler.text.trim().isNotEmpty &&
                            !Functions.isValidEmail(
                                _emailControler.text.trim())) {
                          Functions.showToast(
                              msg: 'Veuillez renseigner un email valide');
                          return;
                        }
                      }
                    }
                    if (_phoneController.text.trim().isEmpty) {
                      Functions.showToast(
                          msg: 'Veuillez renseigner votre numéro de téléphone');
                      return;
                    }

                    if (selectedOprator == null) {
                      Functions.showToast(
                          msg: 'Veuillez sélectionner un opérateur');
                      return;
                    }

                    Functions.showSimpleBottomSheet(
                      ctxt: context,
                      widget: CheckoutDetailsSheet(
                        //isThirdParty: false,
                        userName: _namController.text.trim(),
                        userFirstname: _prenomController.text.trim(),
                        userEmail: _emailControler.text.trim(),
                        userPhone: _phoneController.text.trim(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const Gap(50),
      ],
    );
  }

  void _showThirdPartyForm({ThirdPartyModel? thirdPart, int index = 0}) async {
    EasyLoading.show();
    await Future.delayed(const Duration(seconds: 3));
    EasyLoading.dismiss();
    Functions.showSimpleBottomSheet(
      ctxt: context,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
      ),
      transitionAnimationController: _animationController,
      widget: ThirdPartForm(
        thirdPart: thirdPart,
        index: index,
      ),
    );
  }

/*   void _showLoginSheet() {
    Functions.showSimpleBottomSheet(
      ctxt: context,
      widget: LoginSheet(),
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
      ),
      transitionAnimationController: _animationController,
    );
  } */

  /*  void _selectCountry(CountryModel country) {
    _selectedCountry = country;
  } */
}
