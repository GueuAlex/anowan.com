import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:ticketwave/admin/screens/scan/widgets/error_sheet.dart';
import 'package:vibration/vibration.dart';

import '../../../../config/app_text.dart';
import '../../../../config/functions.dart';
import '../../../../config/palette.dart';
import '../../../../model/ticket_model.dart';
import '../../../../remote_service/remote_service.dart';
import '../../../../widgets/all_sheet_header.dart';
import '../../../../widgets/error_sheet_container.dart';
import '../../../../widgets/infos_column.dart';
import 'phical_ticket_sheet.dart';
import 'scan_sheet.dart';

class SearchTicket extends StatefulWidget {
  const SearchTicket({super.key});

  @override
  State<SearchTicket> createState() => _SearchTicketState();
}

class _SearchTicketState extends State<SearchTicket> {
  TextEditingController _ticketCodeController = TextEditingController();
  // animated rounded btn controller
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final size = MediaQuery.of(context).size;
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
          AppText.medium('Trouver un ticket par code'),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                InfosColumn(
                  opacity: 0.2,
                  label: 'Entrez le code du ticket',
                  widget: Expanded(
                    child: Functions.getTextField(
                      controller: _ticketCodeController,
                      textFieldLabel: 'code',
                    ),
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
                    if (_ticketCodeController.text.isEmpty) {
                      _btnController.reset();
                      Functions.showToast(
                        msg: 'Veuillez renseigner le champ !',
                      );
                      return;
                    }
                    _btnController.reset();
                    EasyLoading.show();

                    int? _tickeCode = int.tryParse(_ticketCodeController.text);
                    if (_tickeCode != null) {
                      // check if is a valid event code
                      if (_tickeCode.toString().length <= 10) {
                        // fetch physical ticket data
                        return _fetchPysicalTicket(code: _tickeCode);
                      }
                      // juste pour le fun
                      // print(id);
                      //_btnController.success();

                      await RemoteService()
                          .getTicket(
                        uniqueCode: _tickeCode.toString(),
                      )
                          .then((res) async {
                        if (res.statusCode == 200 || res.statusCode == 201) {
                          TicketModel _ticket = ticketModelFromJson(res.body);
                          await AudioPlayer()
                              .play(AssetSource('images/soung.mp3'));
                          EasyLoading.dismiss();
                          Functions.showSimpleBottomSheet(
                            ctxt: context,
                            widget: ScanSheet(ticket: _ticket),
                          );
                        } else {
                          print('-------->');
                          EasyLoading.dismiss();
                          error(context: context);
                        }
                      });
                    } else {
                      ///////////////////////
                      ///sinon on fait vibrer le device
                      ///et on afficher un message d'erreur
                      ///

                      EasyLoading.dismiss();
                      Vibration.vibrate(duration: 200);
                      Functions.showBottomSheet(
                        ctxt: context,
                        size: size,
                        heightRatio: 3,
                        widget: const ErrorSheetContainer(
                          text: 'Qr code invalide !',
                        ),
                      );
                    }
                    // });
                  },
                  child: const Text(
                    'Trouver le ticket',
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

  void _fetchPysicalTicket({required int code}) {
    RemoteService().getEvent(uniqueCode: code.toString()).then((res) async {
      if (res.statusCode == 200 || res.statusCode == 201) {
        // EventModel _ticket = eventModelFromJson(res.body);
        EasyLoading.dismiss();
        await AudioPlayer().play(AssetSource('images/soung.mp3'));
        Functions.showSimpleBottomSheet(
          ctxt: context,
          widget: PhicalTicketSheet(code: code),
        );
      } else {
        EasyLoading.dismiss();
        error(context: context);
      }
    });
  }
}
