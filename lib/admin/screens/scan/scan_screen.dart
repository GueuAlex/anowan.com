import 'package:audioplayers/audioplayers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';

import '../../../config/overlay.dart';
import '../../../config/palette.dart';
import '../../../side_bar/custom_side_bar.dart';
import '../../../side_bar/open_side_dar.dart';

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
      drawer: const CustomSiderBar(),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
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
                        //////////////////////////////
                        // on temporise pendant 3 second

                        Future.delayed(const Duration(seconds: 3))
                            .whenComplete(() {
                          /////on cache le gif ensuite on enchaine
                          setState(() {
                            showGif = false;
                          });
                          ///// avec le traitement du qrcode
                          //////////////
                          /// booleen permettant de connaitre l'etat
                          /// du process de scanning
                          isScanCompleted = true;
                          //////////////////////////
                          /// on attend un int
                          /// donc on int.tryParse code pour etre sur de
                          /// son type
                          //int? id = int.tryParse(data);
                          if (data.isNotEmpty) {
                            // juste pour le fun
                            player.play('images/soung.mp3');
                            Functions.showBottomSheet(
                              ctxt: context,
                              ///// pour le fun
                              widget: Container(
                                color: Colors.white,
                                width: double.infinity,
                                height: size.height / 2,
                                child: Center(
                                  child: AppText.medium(data),
                                ),
                              ),
                            );
                          }
                        });
                      }
                    },
                  ),
                  const QRScannerOverlay(overlayColour: Colors.transparent),

                  /////////////// top widgets :::://s///////////
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
                          leading: const OpenSideBar(
                            isWhiteIcon: true,
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isFlashOn = !isFlashOn;
                                });

                                mobileScannerController.toggleTorch();
                              },
                              child: Icon(
                                !isFlashOn
                                    ? FluentIcons.flash_off_24_regular
                                    : FluentIcons.flash_24_filled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  showGif
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
                      : Container()

                  //////////////////////////////////////////////
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
