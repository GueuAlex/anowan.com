import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/palette.dart';
import '../../../model/operator_model.dart';
import '../../../providers/providers.dart';

class OperatorSwitch extends StatelessWidget {
  const OperatorSwitch({super.key});

  @override
  Widget build(BuildContext contex) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: OperatorModel.operators.map((op) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      8.0), // Ajoute un espacement horizontal entre les cartes
              child: OpratorCard(operator: op),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class OpratorCard extends ConsumerWidget {
  const OpratorCard({
    super.key,
    required this.operator,
  });

  final OperatorModel operator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOprator = ref.watch(selectedOperatorProvider);
    final bool isSelected = selectedOprator == operator;

    return InkWell(
      onTap: () {
        ref.read(selectedOperatorProvider.notifier).state = operator;
      },
      child: Container(
        // width: 100, // Définir une largeur fixe pour chaque carte
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(51, 180, 20, 52)
              : const Color.fromARGB(164, 225, 225, 225),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? Palette.appRed : Palette.separatorColor,
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(operator.assetPath, width: 35),
              borderRadius: BorderRadius.circular(5),
            ),
            const Gap(8),
            Text(
              operator.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Palette.appRed
                    : const Color.fromARGB(255, 54, 54, 54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
