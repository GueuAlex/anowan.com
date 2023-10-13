import 'package:audioplayers/audioplayers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/model/ticket_model.dart';
import 'package:ticketwave/widgets/all_sheet_header.dart';
import 'package:vibration/vibration.dart';

import '../../../config/overlay.dart';
import '../../../config/palette.dart';
import '../../../side_bar/custom_side_bar.dart';
import '../../../side_bar/open_side_dar.dart';
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

                        //////////////
                        /// booleen permettant de connaitre l'etat
                        /// du process de scanning
                        isScanCompleted = true;
                        //////////////////////////////
                        // on temporise pendant 3 second

                        Future.delayed(const Duration(seconds: 3))
                            .whenComplete(() {
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
                            player.play('images/soung.mp3');
                            Functions.showBottomSheet(
                              size: size,
                              heightRatio: 1.7,
                              ctxt: context,
                              ///// pour le fun
                              widget: ScanSheet(data: data),
                            ).whenComplete(() {
                              Future.delayed(const Duration(seconds: 3))
                                  .then((_) {
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
                              Future.delayed(const Duration(seconds: 3))
                                  .then((_) {
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

                  /////////////// top widgets menu and flash :::://s///////////
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
                                mobileScannerController.toggleTorch();
                                setState(() {
                                  isFlashOn = !isFlashOn;
                                });
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
  bool isLoading = true;

  Future<void> getTicket({required String uniqueCode}) async {
    _ticket = await Functions.getTicketFromApi(uniqueCode: uniqueCode);
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
            child: AppText.small('Chargement...'),
          )
        : getWidget(ticket: _ticket, size: size);
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  Widget getWidget({required TicketModel? ticket, required Size size}) {
    if (ticket != null) {
      if (!ticket.active) {
        return Functions.inactifQrCode(ctxt: context);
      } else if (ticket.scanned) {
        return const ErrorSheetContainer(
            text: 'Ce Qr code a déjà été scanné !');
      } else {
        return firstScan(ticket: ticket);
      }
    } else {
      return Functions.widget404(size: size, ctxt: context);
    }
  }

  Widget firstScan({required TicketModel ticket}) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: Functions.borderRadius(),
                image: const DecorationImage(
                  image: AssetImage('assets/images/concert-demo.jpg'),
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
                        label: 'Nom et prénoms',
                        widget: AppText.medium(
                          'KOUAKOU Anderson Yves',
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InfosColumn(
                        opacity: 0.1,
                        label: 'Numéro',
                        widget: AppText.medium(
                          '07 098 095 78',
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
          child: RoundedLoadingButton(
            elevation: 1,
            height: 40,
            borderRadius: 5,
            color: Palette.primaryColor,
            controller: _btnController,
            onPressed: () {
              //////////// implementer la validation du scan //////////////////
              Map<String, dynamic> data = {"scanned": 1};
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
        ///////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////
      ],
    );
  }
}
