import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';

import '../../../providers/providers.dart';
import '../../../widgets/country_selector.sheet.dart';
import '../../../widgets/custom_button.dart';

class PhoneInput extends ConsumerWidget {
  const PhoneInput({
    super.key,
    required this.controller,
    required this.size,
    required this.onSubmit,
  });
  final TextEditingController controller;
  final Size size;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.watch(selectedCountryProvider);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: (size.height * 0.05),
          decoration: BoxDecoration(
            color: Color.fromARGB(5, 61, 68, 74),
            border: Border.all(
              width: 0.35,
              color: const Color.fromARGB(255, 201, 201, 201),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => Functions.showSimpleBottomSheet(
                  ctxt: context,
                  widget: CountrySelectorSheet(),
                ),
                child: Container(
                  width: 70,
                  height: (size.height * 0.05),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.12),
                  ),
                  child: AppText.medium(
                    '+${selectedCountry?.zipCode ?? ''}',
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Functions.getTextField(
                  controller: controller,
                  textFieldLabel: 'N° de téléphone',
                  fontSize: 16.5,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ),
        Gap(10),
        CustomButton(
          color: Palette.appRed,
          width: double.infinity,
          height: 40,
          radius: 5,
          text: 'Continuer',
          onPress: onSubmit,
        ),
      ],
    );
  }
}
