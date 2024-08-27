import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/screens/prestator_screen/prestator_screen.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/prestator_model.dart';
import '../../../providers/providers.dart';
import 'filter_modal_bottom_sheet.dart';
import 'prestator_card.dart';

class PrestatorByCategory extends ConsumerWidget {
  const PrestatorByCategory({super.key, required this.prestatorList});
  final List<PrestatorMdel> prestatorList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    // Lire la catégorie sélectionnée depuis le provider
    final selectedCategory = ref.watch(selectedCategoryProvider);

    // Liste des catégories
    List<String> categories = [
      "Tout",
      "Décoration",
      "Service traiteur",
      "Tenue traditionnelle",
      "Location (salle , couverts etc....)",
      "Resto grill et lounge",
    ];

    final filteredPrestators = selectedCategory == "Tout"
        ? prestatorList
        : prestatorList
            .where((p) => p.serviceCategory == selectedCategory)
            .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AppText.medium(
              'Prestataires par catégorie',
              fontSize: (size.width * 0.042),
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(10),
          // Filtres
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll(Palette.primaryColor),
                    ),
                    onPressed: () => Functions.showSimpleBottomSheet(
                      ctxt: context,
                      widget: FilterModalBottomeSheet(),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/filters.svg',
                      // ignore: deprecated_member_use
                      color: Colors.white,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  Wrap(
                    children: categories
                        .map((label) => _buildTag(label, selectedCategory, ref))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Gap(20),
          // Consommation des prestataires filtrés par catégorie
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filteredPrestators
                  .map(
                    (prestator) => prestatorCard(
                      prestator: prestator,
                      onTap: () => Navigator.of(context).pushNamed(
                        PrestatorScreen.routeName,
                        arguments: prestator,
                      ),
                      size: size,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String label, String selectedCategory, WidgetRef ref) {
    bool isSelected = label == selectedCategory;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: const EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        color: !isSelected
            ? Palette.primaryColor.withOpacity(0.1)
            : Palette.primaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: InkWell(
        onTap: () => ref.read(selectedCategoryProvider.notifier).state = label,
        child: AppText.medium(
          label,
          fontSize: 12,
          color: !isSelected ? Palette.primaryColor : Palette.whiteColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
