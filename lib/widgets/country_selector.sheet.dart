import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';
import '../model/country_model.dart';
import '../providers/providers.dart';
import 'sheet_closer_cross.dart';

class CountrySelectorSheet extends ConsumerWidget {
  const CountrySelectorSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          sheetCloserCross(
              ctxt: context,
              text: 'Sélectionner un pays',
              fontWeight: FontWeight.w400),
          Gap(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: CountryModel.list.map((country) {
                  return InkWell(
                    onTap: () {
                      ref.read(selectedCountryProvider.notifier).state =
                          country;
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText.medium(
                              country.name,
                              fontSize: 16.5,
                            ),
                          ),
                          Gap(5),
                          AppText.medium(
                            '+${country.zipCode}',
                            fontSize: 13,
                            color: Color.fromARGB(255, 64, 64, 64),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
