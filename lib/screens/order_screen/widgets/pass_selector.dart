import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/pass_model.dart';
import 'add_romve_button.dart';
import 'pass_description_sheet.dart';

class PassSeclector extends StatelessWidget {
  const PassSeclector({
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
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Palette.primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    AppText.medium(
                      pass.name,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(8),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Palette.secondaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => Functions.showBottomSheet(
                            ctxt: context,
                            widget: PassDecriptionSheet(),
                            size: size),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.question,
                            color: Palette.secondaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  AddButton(
                    color: Palette.primaryColor.withOpacity(0.15),
                    icon: CupertinoIcons.minus,
                    onPressed: onMinus,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: AppText.large(
                        '$selectedCount'), // Afficher ici le nombre sélectionné pour chaque pass
                  ),
                  AddButton(
                    color: Palette.primaryColor,
                    icon: CupertinoIcons.add,
                    incoColor: Colors.white,
                    onPressed: onAdd,
                  ),
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          AppText.medium(
            '${pass.price} FCFA',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          Gap(8),
          AppText.small(
            'Les ventes se terminent dans un jour',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          )
        ],
      ),
    );
  }
}
