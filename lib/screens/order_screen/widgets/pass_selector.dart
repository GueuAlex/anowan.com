import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/pass_model.dart';
import '../../../widgets/custome_divider.dart';
import 'add_romve_button.dart';
import 'pass_description_sheet.dart';

class PassSelector extends StatelessWidget {
  const PassSelector({
    super.key,
    required this.pass,
    required this.selectedCount,
    required this.onAdd,
    required this.onMinus,
  });
  final PassModel pass;
  final int selectedCount;
  final VoidCallback onAdd;
  final VoidCallback onMinus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(204, 236, 236, 236),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: ClipRRect(
        child: Stack(
          children: [
            /* Positioned(
              //top: 150,
              bottom: 0,
              left: 0,
              right: 50,
              child: Transform.rotate(
                angle: 0.3,
                child: pass.allmostFinish
                    ? Alert1(
                        alert: 'Bientôt épuisé !',
                        color: Color.fromARGB(255, 209, 1, 70),
                        icon: CupertinoIcons.exclamationmark_triangle,
                      )
                    : Container(),
              ),
            ), */
            Container(
              padding: const EdgeInsets.all(12),
              //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pass.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Palette.primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            //const Gap(4),
                            Text(
                              '${Functions.numberFormat(pass.price.toString())} ₣',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Palette.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (pass.description!.trim().isNotEmpty)
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.question_circle,
                            color: Palette.secondaryColor,
                          ),
                          onPressed: () => Functions.showSimpleBottomSheet(
                            ctxt: context,
                            widget: PassDecriptionSheet(
                              description: pass.description ?? '',
                            ),
                          ),
                        ),
                    ],
                  ),
                  customDiveder(),
                  Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*  Text(
                        'Les ventes se terminent dans un jour',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ), */
                      Container(),
                      Row(
                        children: [
                          AddButton(
                            color: Colors.red.withOpacity(0.1),
                            icon: CupertinoIcons.minus,
                            onPressed: onMinus,
                            incoColor: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: 25,
                              child: Text(
                                '$selectedCount',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          AddButton(
                            color: Palette.primaryColor,
                            icon: CupertinoIcons.add,
                            //iconColor: Colors.white,
                            incoColor: Colors.white,
                            onPressed: onAdd,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
