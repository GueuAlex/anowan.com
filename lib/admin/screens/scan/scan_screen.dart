import 'package:audioplayers/audioplayers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/model/ticket_model.dart';
import 'package:ticketwave/remote_service/remote_service.dart';
import 'package:vibration/vibration.dart';

import '../../../config/overlay.dart';
import '../../../config/palette.dart';
import '../../../providers/providers.dart';
import '../../../widgets/error_sheet_container.dart';
import 'widgets/error_sheet.dart';
import 'widgets/scan_sheet.dart';
import 'widgets/search_ticket.dart';
import 'widgets/token_checker.dart';

class ScanScreen extends ConsumerStatefulWidget {
  static String routeName = 'scan_screen';
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  ///////////////////////// bools /////////////////////////
  ////////////////////////////////////////////////////////
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFontCamera = false;
  //bool showGif = false;
  /////////////////////////////////////////////////////////
  MobileScannerController mobileScannerController = MobileScannerController();
  void closeScreen() {
    isScanCompleted = false;
  }

  //////////// sonnette /////////////:
  ////////////////
  ///
  AudioCache player = AudioCache();
  //bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isKeyboardVisible = ref.watch(keyboardVisibilityProvider);
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
            onDetect: (barcodes, args) async {
              if (!isScanCompleted) {
                ////////://///////////////
                /// on montre le gif de detection

                ////////////////
                /// data =  données que le qrcode continet
                String data = barcodes.rawValue ?? '';
                //debugPrint(data);

                //////////////
                /// booleen permettant de connaitre l'etat
                /// du process de scanning
                isScanCompleted = true;
                //////////////////////////////
                // on temporise pendant 3 second

                /*  Future.delayed(
                  const Duration(seconds: 3),
                ).whenComplete(() {
                  /////on cache le gif ensuite on enchaine
                  setState(() {
                    showGif = false;
                  }); */
                ///// avec le traitement du qrcode

                //////////////////////////
                /// on attend un int
                /// donc on int.tryParse code pour etre sur de
                /// son type
                int? _tickeCode = int.tryParse(data);
                if (_tickeCode != null) {
                  // juste pour le fun
                  // print(id);
                  EasyLoading.show(
                    status: ' ',
                  );

                  await RemoteService()
                      .getTicket(
                    uniqueCode: _tickeCode.toString(),
                  )
                      .then((res) async {
                    if (res.statusCode == 200 || res.statusCode == 201) {
                      TicketModel _ticket = ticketModelFromJson(res.body);
                      await AudioPlayer().play(AssetSource('images/soung.mp3'));
                      Functions.showSimpleBottomSheet(
                        ctxt: context,
                        widget: ScanSheet(ticket: _ticket),
                      ).whenComplete(() {
                        setState(() {
                          isScanCompleted = false;
                        });
                      });
                      EasyLoading.dismiss();
                    } else {
                      EasyLoading.dismiss();
                      error(size: size, context: context);
                    }
                  });
                  EasyLoading.dismiss();
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
                    //Future.delayed(const Duration(seconds: 3)).then((_) {
                    setState(() {
                      isScanCompleted = false;
                    });
                    // });
                  });
                }
                // });
              }
            },
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: const QRScannerOverlay(overlayColour: Colors.transparent),
          ),

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

          ////////// bottom widgets //////////////////////:
          Positioned(
            bottom: 50,
            right: 15,
            child: Container(
              // margin: EdgeInsets.only(top: size.height / 1.2),
              //width: double.infinity,
              color: Colors.transparent,
              child: SafeArea(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
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
                    Gap(15),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: InkWell(
                        onTap: () async {
                          ref.read(keyboardVisibilityProvider.notifier).state =
                              true;
                          await Functions.showSimpleBottomSheet(
                            ctxt: context,
                            widget: TokenChecker(),
                          );
                          ref.read(keyboardVisibilityProvider.notifier).state =
                              false;
                        },
                        child: Icon(
                          color: Colors.white,
                          FluentIcons.key_24_regular,
                        ),
                      ),
                    ),
                    Gap(15),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: InkWell(
                        onTap: () async {
                          ref.read(keyboardVisibilityProvider.notifier).state =
                              true;
                          await Functions.showSimpleBottomSheet(
                            ctxt: context,
                            widget: SearchTicket(),
                          );
                          ref.read(keyboardVisibilityProvider.notifier).state =
                              false;
                        },
                        child: Icon(
                          color: Colors.white,
                          FluentIcons.search_24_regular,
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