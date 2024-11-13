import 'package:audioplayers/audioplayers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/model/ticket_model.dart';
import 'package:ticketwave/remote_service/remote_service.dart';
import 'package:vibration/vibration.dart';

import '../../../config/overlay.dart';
import '../../../providers/providers.dart';
import '../../../widgets/error_sheet_container.dart';
import 'widgets/error_sheet.dart';
import 'widgets/phical_ticket_sheet.dart';
import 'widgets/scan_sheet.dart';
import 'widgets/scanner_screen_title.dart';
import 'widgets/search_ticket.dart';
import 'widgets/token_checker.dart';

/* class ScanScreen extends ConsumerStatefulWidget {
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
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            controller: mobileScannerController,

            /// Lorsque le qrcode est détecté

            onDetect: (barcodes) async {
              if (!isScanCompleted) {
                ////////////////
                /// data =  données que le qrcode continet
                String data = barcodes.barcodes.first.rawValue ?? '';

                //////////////
                /// booleen permettant de connaitre l'etat
                /// du process de scanning
                isScanCompleted = true;

                //////////////////////////
                /// on attend un int
                /// donc on int.tryParse data pour etre sur de
                /// son type
                int? _tickeCode = int.tryParse(data);
                //_tickeCode.bitLength;
                if (_tickeCode != null) {
                  EasyLoading.show();
                  // check if is a valid event code
                  if (_tickeCode.toString().length <= 10) {
                    // fetch physical ticket data
                    return _fetchPysicalTicket(code: _tickeCode);
                  }

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
                          // print('scan completed');
                        });
                      });
                      EasyLoading.dismiss();
                    } else {
                      EasyLoading.dismiss();
                      await error(context: context);
                      setState(() {
                        isScanCompleted = false;
                      });
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
            child: QRScannerOverlay(
              overlayColour: Colors.transparent.withOpacity(0.45),
            ),
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

          ScannerScreenTitle(),

          ////////// bottom widgets //////////////////////:
          Positioned(
            bottom: 50,
            right: 15,
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: Column(
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
          ),

          //////////////////////////////////////////////
        ],
      ),
    );
  }

  void _fetchPysicalTicket({required int code}) {
    RemoteService().getEvent(uniqueCode: code.toString()).then((res) async {
      if (res.statusCode == 200 || res.statusCode == 201) {
        // EventModel _ticket = eventModelFromJson(res.body);
        EasyLoading.dismiss();
        await AudioPlayer().play(AssetSource('images/soung.mp3'));
        Functions.showSimpleBottomSheet(
          ctxt: context,
          widget: PhicalTicketSheet(code: code),
        ).whenComplete(() {
          setState(() {
            isScanCompleted = false;
          });
        });
      } else {
        EasyLoading.dismiss();
        await error(context: context);
        setState(() {
          isScanCompleted = false;
        });
      }
    });
  }
} */

class ScanScreen extends ConsumerStatefulWidget {
  static String routeName = 'scan_screen';
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen>
    with WidgetsBindingObserver {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  MobileScannerController mobileScannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mobileScannerController.barcodes.listen(_handleBarcode);
    mobileScannerController.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //if (!mobileScannerController.) return;

    switch (state) {
      case AppLifecycleState.resumed:
        mobileScannerController.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        mobileScannerController.stop();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    mobileScannerController.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (isScanCompleted) return;

    String data = barcodes.barcodes.first.rawValue ?? '';
    int? ticketCode = int.tryParse(data);

    setState(() => isScanCompleted = true);

    if (ticketCode != null) {
      EasyLoading.show();
      if (ticketCode.toString().length <= 10) {
        // fetch physical ticket data
        return _fetchPysicalTicket(code: ticketCode);
      }

      try {
        final res =
            await RemoteService().getTicket(uniqueCode: ticketCode.toString());

        if (res.statusCode == 200 || res.statusCode == 201) {
          TicketModel ticket = ticketModelFromJson(res.body);
          await AudioPlayer().play(AssetSource('images/soung.mp3'));
          Functions.showSimpleBottomSheet(
            ctxt: context,
            widget: ScanSheet(ticket: ticket),
          ).whenComplete(() {
            setState(() => isScanCompleted = false);
          });
        } else {
          await _showError().whenComplete(() {
            setState(() => isScanCompleted = false);
          });
          ;
        }
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      Vibration.vibrate(duration: 200);
      await _showError().whenComplete(() {
        setState(() => isScanCompleted = false);
      });
    }
  }

  void _fetchPysicalTicket({required int code}) async {
    // check if inspecto token is set
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("scantoken");
    if (token == null) {
      EasyLoading.dismiss();
      await Functions.showSimpleBottomSheet(
        ctxt: context,
        widget: TokenChecker(),
      );
      setState(() {
        isScanCompleted = false;
      });
    } else {
      RemoteService().getEvent(uniqueCode: code.toString()).then((res) async {
        if (res.statusCode == 200 || res.statusCode == 201) {
          // EventModel _ticket = eventModelFromJson(res.body);
          EasyLoading.dismiss();
          await AudioPlayer().play(AssetSource('images/soung.mp3'));
          Functions.showSimpleBottomSheet(
            ctxt: context,
            widget: PhicalTicketSheet(token: token),
          ).whenComplete(() {
            setState(() {
              isScanCompleted = false;
            });
          });
        } else {
          EasyLoading.dismiss();
          await error(context: context);
          setState(() {
            isScanCompleted = false;
          });
        }
      });
    }
  }

  Future<void> _showError() async {
    await Functions.showBottomSheet(
      ctxt: context,
      size: MediaQuery.of(context).size,
      heightRatio: 3,
      widget: const ErrorSheetContainer(text: 'Qr code invalide !'),
    ).whenComplete(() {
      setState(() => isScanCompleted = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = ref.watch(keyboardVisibilityProvider);
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            controller: mobileScannerController,
            onDetect: _handleBarcode,
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: QRScannerOverlay(
              overlayColour: Colors.transparent.withOpacity(0.45),
            ),
          ),
          Positioned(
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'Scanner',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          ScannerScreenTitle(),
          Positioned(
            bottom: 50,
            right: 15,
            child: Column(
              children: [
                _buildControlButton(
                  icon: isFlashOn
                      ? FluentIcons.flash_24_filled
                      : FluentIcons.flash_off_24_regular,
                  onTap: () {
                    mobileScannerController.toggleTorch();
                    setState(() => isFlashOn = !isFlashOn);
                  },
                ),
                Gap(15),
                _buildControlButton(
                  icon: FluentIcons.key_24_regular,
                  onTap: () => _showBottomSheet(const TokenChecker()),
                ),
                Gap(15),
                _buildControlButton(
                  icon: FluentIcons.search_24_regular,
                  onTap: () => _showBottomSheet(const SearchTicket()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: InkWell(onTap: onTap, child: Icon(icon, color: Colors.white)),
    );
  }

  Future<void> _showBottomSheet(Widget widget) async {
    ref.read(keyboardVisibilityProvider.notifier).state = true;
    await Functions.showSimpleBottomSheet(ctxt: context, widget: widget);
    ref.read(keyboardVisibilityProvider.notifier).state = false;
  }
}
