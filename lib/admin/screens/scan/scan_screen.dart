import 'package:audioplayers/audioplayers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/model/inspector_model.dart';
import 'package:ticketwave/model/ticket_model.dart';
import 'package:ticketwave/widgets/all_sheet_header.dart';
import 'package:vibration/vibration.dart';

import '../../../config/overlay.dart';
import '../../../config/palette.dart';
import '../../../model/localization_model.dart';
import '../../../widgets/error_sheet_container.dart';
import '../../../widgets/infos_column.dart';

class ScanScreen extends StatefulWidget {
  static String routeName = 'scan_screen';
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ///////////////////////// bools /////////////////////////
  ////////////////////////////////////////////////////////
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFontCamera = false;
  bool showGif = false;
  /////////////////////////////////////////////////////////
  MobileScannerController mobileScannerController = MobileScannerController();
  void closeScreen() {
    isScanCompleted = false;
  }

  //////////// sonnette /////////////:
  ////////////////
  ///
  AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //drawer: const CustomSiderBar(),
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            controller: mobileScannerController,
            allowDuplicates: true,
            ///////////////////////////////////
            /// Lorsque le qrcode est détecté
            ///
            onDetect: (barcodes, args) {
              if (!isScanCompleted) {
                ////////://///////////////
                /// on montre le gif de detection
                setState(() {
                  showGif = !showGif;
                });
                ////////////////
                /// data =  données que le qrcode continet
                String data = barcodes.rawValue ?? '';
                debugPrint(data);

                //////////////
                /// booleen permettant de connaitre l'etat
                /// du process de scanning
                isScanCompleted = true;
                //////////////////////////////
                // on temporise pendant 3 second

                Future.delayed(
                  const Duration(seconds: 3),
                ).whenComplete(() {
                  /////on cache le gif ensuite on enchaine
                  setState(() {
                    showGif = false;
                  });
                  ///// avec le traitement du qrcode

                  //////////////////////////
                  /// on attend un int
                  /// donc on int.tryParse code pour etre sur de
                  /// son type
                  int? id = int.tryParse(data);
                  if (id != null) {
                    // juste pour le fun
                    print(id);
                    AudioPlayer().play(AssetSource('images/soung.mp3'));
                    Functions.showSimpleBottomSheet(
                      /* size: size,
                      heightRatio: 1.7, */
                      ctxt: context,
                      ///// pour le fun
                      widget: ScanSheet(data: id.toString()),
                    ).whenComplete(() {
                      Future.delayed(const Duration(seconds: 3)).then((_) {
                        setState(() {
                          isScanCompleted = false;
                        });
                      });
                    });
                  } else {
                    ///////////////////////
                    ///sinon on fait vibrer le device
                    ///et on afficher un message d'erreur
                    ///
                    Vibration.vibrate(duration: 200);
                    Functions.showBottomSheet(
                      ctxt: context,
                      size: size,
                      heightRatio: 3,
                      widget: const ErrorSheetContainer(
                        text: 'Qr code invalide !',
                      ),
                    ).whenComplete(() {
                      Future.delayed(const Duration(seconds: 3)).then((_) {
                        setState(() {
                          isScanCompleted = false;
                        });
                      });
                    });
                  }
                });
              }
            },
          ),
          const QRScannerOverlay(overlayColour: Colors.transparent),

          /////////////// top widgets menu//s///////////
          Positioned(
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: SafeArea(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: AppText.medium(
                    'Scanner',
                    color: Palette.whiteColor,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              width: double.infinity,
              color: Colors.transparent,
              child: SafeArea(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: 'Placez le  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' Code QR ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      TextSpan(
                        text: ' dans la ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' zone de scan ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      TextSpan(
                        text:
                            ' le\nprocessus de scan commencera automatiquement',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          showGif ///// widget d'animation gif afficher on detect
              ? Positioned(
                  top: (size.height - 200) /
                      2, // Align au milieu de la hauteur de l'écran
                  left: (size.width - 200) /
                      2, // Align au milieu de la largeur de l'écran
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      //color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/images/detect.gif'),
                      ),
                    ),
                  ),
                )
              : Container(),

          ////////// bottom widgets //////////////////////:
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: size.height / 1.2),
              width: double.infinity,
              color: Colors.transparent,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: InkWell(
                        onTap: () {
                          mobileScannerController.toggleTorch();
                          setState(() {
                            isFlashOn = !isFlashOn;
                          });
                        },
                        child: Icon(
                          color: Colors.white,
                          !isFlashOn
                              ? FluentIcons.flash_off_24_regular
                              : FluentIcons.flash_24_filled,
                        ),
                      ),
                    ),
                    Gap(3.5),
                    Container(
                      padding: const EdgeInsets.all(13.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: InkWell(
                        onTap: () {
                          Functions.showSimpleBottomSheet(
                            ctxt: context,
                            widget: TokenChecker(),
                          );
                        },
                        child: Icon(
                          color: Colors.white,
                          FluentIcons.key_24_regular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

          //////////////////////////////////////////////
        ],
      ),
    );
  }
}

// token checker
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
      height: 230,
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
                  opacity: 0.2,
                  label: 'Entrez la clé de scan',
                  widget: Expanded(
                    child: Functions.getTextField(
                        controller: _tokenController, textFieldLabel: 'clé'),
                  ),
                ),
                Gap(50),
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

class ScanSheet extends StatefulWidget {
  const ScanSheet({
    super.key,
    required this.data,
  });

  final String data;

  @override
  State<ScanSheet> createState() => _ScanSheetState();
}

class _ScanSheetState extends State<ScanSheet> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  //////////////////////////////////////////:
  ///////////
  TicketModel? _ticket;
  ///////////////////
  ///
  ///////////////////////////////////////////////
  String? _token;
  ////////////////////::
  ///
  bool isLoading = true;

  Future<void> getTicket({required String uniqueCode}) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("scantoken");
    _ticket = await Functions.getTicketFromApi(uniqueCode: uniqueCode);

    print(_ticket);
  }

  ///
  ////////////////////////////////////////////
  @override
  void initState() {
    getTicket(uniqueCode: widget.data).whenComplete(() {
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
        : getWidget(ticket: _ticket, size: size, scantoken: _token);
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  Widget getWidget({
    required TicketModel? ticket,
    required Size size,
    required String? scantoken,
  }) {
    if (scantoken == null) {
      // token saver
      return TokenChecker();
      //return Functions.inactifQrCode(ctxt: context);
      //return Functions.widget404(size: size, ctxt: context);
    }

    /// si ticket est different de null
    if (ticket != null) {
      // vérifier l'existance de token
      List<InspectorModel> inspectors = ticket.event.inspectors;
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
          _dates.add(localization.dateEvent);
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
    } else {
      // afficher pas de tickets trouvé
      return Functions.widget404(size: size, ctxt: context);
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
