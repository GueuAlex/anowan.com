import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/utils.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/app_text.dart';
import '../../../../config/functions.dart';
import '../../../../config/palette.dart';
import '../../../../model/inspector_model.dart';
import '../../../../model/localization_model.dart';
import '../../../../model/ticket_model.dart';
import '../../../../widgets/all_sheet_header.dart';
import '../../../../widgets/error_sheet_container.dart';
import '../../../../widgets/infos_column.dart';
import 'token_checker.dart';

class ScanSheet extends StatefulWidget {
  const ScanSheet({
    super.key,
    required this.ticket,
  });

  final TicketModel ticket;

  @override
  State<ScanSheet> createState() => _ScanSheetState();
}

class _ScanSheetState extends State<ScanSheet> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  //////////////////////////////////////////:
  ///////////
  //TicketModel? _ticket;
  ///////////////////
  ///
  ///////////////////////////////////////////////
  String? _token;
  ////////////////////::
  ///
  bool isLoading = true;

  Future<void> fetchToken() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("scantoken");
    /*  _ticket = await Functions.getTicketFromApi(uniqueCode: uniqueCode); */

    //print(_ticket);
  }

  ///
  ////////////////////////////////////////////
  @override
  void initState() {
    fetchToken().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }
  ////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? Center(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.appRed),
                  ),
                  Gap(5),
                  AppText.small('Chargement...'),
                ],
              ),
            ),
          )
        : getWidget(ticket: widget.ticket, size: size, scantoken: _token);
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  Widget getWidget({
    required TicketModel ticket,
    required Size size,
    required String? scantoken,
  }) {
    if (scantoken == null) {
      // token saver
      return TokenChecker();
      //return Functions.inactifQrCode(ctxt: context);
      //return Functions.widget404(size: size, ctxt: context);
    }

    // vérifier l'existance de token
    List<InspectorModel> inspectors = ticket.event.inspectors ?? [];
    if (inspectors.isEmpty) {
      // personne n'est autorisé a scanné les tickets de cet évènnement pour le moment!
      return Container(
        width: double.infinity,
        height: 230,
        /* margin: EdgeInsets.only(bottom: keyboardHeight), */
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: const ErrorSheetContainer(
          text:
              "Personne n'est autorisé à scanner les tickets de cet événement pour le moment !",
        ),
      );
    }
    // vérifier une correspondance de token
    InspectorModel? inspect = inspectors
        .firstWhereOrNull((element) => element.scanToken == scantoken);
    if (inspect == null) {
      // vous n'est pas autorisé a scanné les tickets de cet évènnement
      // Veuillez vérifier votre token ou contacter l'organisateur.
      return Container(
        width: double.infinity,
        height: 230,
        /* margin: EdgeInsets.only(bottom: keyboardHeight), */
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: const ErrorSheetContainer(
          text:
              "Vous n'êtes pas autorisé à scanner les tickets de cet événement. Veuillez vérifier votre clé de scan ou contacter l'organisateur",
        ),
      );
    }

    // si ticket n'est pas active
    if (!ticket.active) {
      return Functions.inactifQrCode(ctxt: context);
    }

    // sinon si ticket à déjà été scanné
    if (ticket.scanned) {
      return Container(
        width: double.infinity,
        height: 230,
        /* margin: EdgeInsets.only(bottom: keyboardHeight), */
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: const ErrorSheetContainer(
          text: 'Ce Qr code a déjà été scanné !',
        ),
      );
    } else {
      // vérifier les dates de l'évennement

      /// liste pour stocké toutes les dates de l'évennement
      /// dans ticket.event.localizations
      List<DateTime> _dates = [];
      // recuperation des dates
      for (LocalizationModel localization in ticket.event.localizations) {
        // Ajouter dateEvent
        _dates.add(localization.dateEvent);

        // Ajouter dateEventEnd si elle n'est pas nulle
        if (localization.dateEventEnd != null) {
          _dates.add(localization.dateEventEnd!);
        }
      }

      ///// vérifier si l'un des dates dans _dates vaut la date d'aujourd'hui
      ///
      if (!Functions.containsCurrentDate(_dates)) {
        return Container(
          width: double.infinity,
          height: 230,
          /* margin: EdgeInsets.only(bottom: keyboardHeight), */
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: const ErrorSheetContainer(
            icon: FluentIcons.calendar_24_regular,
            text:
                'Ce n\'est pas encore la date de l\'événement\nou la date est déjà passée.',
          ),
        );
      }

      // ou valider le scan

      return firstScan(ticket: ticket, token: inspect.scanToken);
    }
  }

  Widget firstScan({required TicketModel ticket, required String token}) {
    final _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: _size.height / 1.6,
      /* margin: EdgeInsets.only(bottom: keyboardHeight), */
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: Functions.borderRadius(),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/ticket2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              const AllSheetHeader(),
            ],
          ),
          //////////////////////// qr code infos /////////////////////
          ///////////////////////////////////////////////////////////
          const Gap(5),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 145,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Palette.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/qr-model.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      children: [
                        InfosColumn(
                          opacity: 0.1,
                          label: 'Pass',
                          widget: AppText.medium(
                            ticket.pass.name,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InfosColumn(
                          opacity: 0.1,
                          label: 'Event',
                          widget: AppText.medium(
                            ticket.event.name,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InfosColumn(
                          opacity: 0.1,
                          label: 'Code',
                          widget: AppText.medium(
                            ticket.uniqueCode,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            /* child: CustomButton(
              color: Palette.secondaryColor,
              width: double.infinity,
              height: 35,
              radius: 5,
              text: 'Confirmer le scan',
              onPress: () {
                /*  Map<String, dynamic> data = {
                  "is_checked": 1,
                }; */
                EasyLoading.show(status: 'loading...');
                Future.delayed(const Duration(seconds: 5))
                    .then((value) => EasyLoading.dismiss());
              },
            ), */
            child: Container(
              width: double.infinity,
              child: RoundedLoadingButton(
                elevation: 1,
                height: 40,
                borderRadius: 5,
                color: Palette.appRed,
                successColor: Color.fromARGB(255, 90, 151, 92),
                controller: _btnController,
                onPressed: () {
                  //////////// implementer la validation du scan //////////////////
                  Map<String, dynamic> data = {
                    /* "scanned": 1, */
                    "token": token,
                  };

                  Functions.scanValidation(
                    data: data,
                    uniqueCode: ticket.uniqueCode,
                  ).then((response) {
                    if (response != null) {
                      _btnController.success();
                      EasyLoading.showToast(
                        'Scan confirmé !',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                    } else {
                      _btnController.reset();
                      EasyLoading.showToast(
                        'Try again !',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                    }
                  });

                  ////////:

                  ////////////////////////////////////////////////////////////////
                },
                child: const Text(
                  'Confirmer le scan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ///////////////////////////////////////////////////////////
          ///////////////////////////////////////////////////////////
        ],
      ),
    );
  }
}
