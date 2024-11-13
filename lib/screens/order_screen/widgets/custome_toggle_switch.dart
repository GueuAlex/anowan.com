import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/palette.dart';
import '../../../providers/providers.dart';

class CustomToggleSwitch extends ConsumerWidget {
  const CustomToggleSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRecepient = ref.watch(selectedRecepientProvider);
    final List<String> recepients = [
      'E-mail',
      'SMS',
      'Les deux',
    ];

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          color: Palette.separatorColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: recepients.map((r) {
            bool isSelected = r == selectedRecepient;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedRecepientProvider.notifier).state = r;
                },
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isSelected ? Colors.white : Colors.transparent,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      r,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.grey[700],
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
