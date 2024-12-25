import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/remote_service/remote_service.dart';

import '../../../../config/app_text.dart';
import '../../../../config/palette.dart';
import '../../../../widgets/all_sheet_header.dart';
import '../../../../widgets/custom_button.dart';

class CartonSheet extends StatelessWidget {
  const CartonSheet({
    super.key,
    required this.uniqueCode,
    required this.isCanned,
    required this.token,
  });
  final String uniqueCode;
  final bool isCanned;
  final String token;
  /*  final String inspectoroken; */

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 325,
      /* margin: EdgeInsets.only(bottom: keyboardHeight), */
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: !isCanned
          ? Column(
              children: [
                const AllSheetHeader(),
                Expanded(
                  child: Column(
                    children: [
                      const Gap(10),
                      buildIcon(),
                      const Gap(10),
                      AppText.medium(
                        'Cette invitation est conforme',
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppText.small(
                          'Veuillez valider la vérification pour enregistrer ce contrôle',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Gap(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                          isSetting: true,
                          fontsize: 15,
                          color: Palette.appRed,
                          width: double.infinity,
                          height: 35,
                          radius: 5,
                          text: 'Valider la vérification',
                          onPress: () async {
                            // EasyLoading.show();
                            Map<String, dynamic> data = {
                              'token': token,
                              "unique_code": uniqueCode,
                            };
                            EasyLoading.show();

                            RemoteService()
                                .putSomethings2(
                                    api: 'invitation-card/scan', data: data)
                                .then((r) {
                              EasyLoading.dismiss();
                              if (r.statusCode == 200 || r.statusCode == 201) {
                                // _btnController.success();
                                EasyLoading.showToast(
                                  'Scan confirmé !',
                                  toastPosition: EasyLoadingToastPosition.top,
                                );
                              } else {
                                //_btnController.reset();
                                EasyLoading.showToast(
                                  'Veuillez réesayer',
                                  toastPosition: EasyLoadingToastPosition.top,
                                );
                              }
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                const AllSheetHeader(),
                Expanded(
                  child: Column(
                    children: [
                      const Gap(10),
                      buildIcon(isCanned: true),
                      const Gap(10),
                      AppText.medium(
                        'Déjà scanné !',
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppText.small(
                          'Cette carte d\'invitation a déjà été scannée',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Gap(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                          isSetting: true,
                          fontsize: 15,
                          color: Palette.appRed,
                          width: double.infinity,
                          height: 35,
                          radius: 5,
                          text: 'Retour',
                          onPress: () {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

///
Container buildIcon({bool isCanned = false}) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: !isCanned
          ? const Color.fromARGB(255, 88, 153, 94).withOpacity(0.15)
          : const Color.fromARGB(255, 176, 5, 39).withOpacity(0.15),
      shape: BoxShape.circle,
    ),
    child: Container(
      padding: const EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: !isCanned
            ? Color.fromARGB(255, 88, 153, 94).withOpacity(0.3)
            : Color.fromARGB(255, 176, 5, 39).withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: !isCanned
              ? Color.fromARGB(255, 88, 153, 94).withOpacity(0.5)
              : Color.fromARGB(255, 176, 5, 39).withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            !isCanned ? Icons.check : Icons.close,
            // size: 25,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
