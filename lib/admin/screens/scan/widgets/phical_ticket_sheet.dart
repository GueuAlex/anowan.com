import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';

import '../../../../config/app_text.dart';
import '../../../../config/functions.dart';
import '../../../../config/palette.dart';
import '../../../../widgets/all_sheet_header.dart';
import '../../../../widgets/custom_button.dart';

class PhicalTicketSheet extends StatelessWidget {
  const PhicalTicketSheet({
    super.key,
    required this.code,
    /*  required this.inspectoroken, */
  });
  final int code;
  /*  final String inspectoroken; */

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      /* margin: EdgeInsets.only(bottom: keyboardHeight), */
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const AllSheetHeader(),
          Expanded(
            child: Column(
              children: [
                const Gap(10),
                buildIcon(),
                const Gap(10),
                AppText.medium(
                  'Ce billet est conforme',
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppText.small(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor .',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    color: Palette.appRed,
                    width: double.infinity,
                    height: 35,
                    radius: 5,
                    text: 'Valider la vérification',
                    onPress: () async {
                      // EasyLoading.show();
                      Map<String, dynamic> data = {
                        /* "scanned": 1, */
                        "scan_id": code,
                      };
                      EasyLoading.show();

                      Functions.scanValidation2(
                        data: data,
                        /* uniqueCode: code.toString(), */
                      ).then((response) {
                        EasyLoading.dismiss();
                        if (response != null) {
                          // _btnController.success();
                          EasyLoading.showToast(
                            'Scan confirmé !',
                            toastPosition: EasyLoadingToastPosition.top,
                          );
                        } else {
                          //_btnController.reset();
                          EasyLoading.showToast(
                            'Try again !',
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
      ),
    );
  }
}

///
Container buildIcon() {
  return Container(
    padding: const EdgeInsets.all(10),
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Palette.primaryColor.withOpacity(0.15),
      shape: BoxShape.circle,
    ),
    child: Container(
      padding: const EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Palette.primaryColor.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            // size: 25,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
