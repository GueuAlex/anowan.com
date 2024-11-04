import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../config/app_text.dart';
import '../../../../config/palette.dart';
import '../../../../model/centre_interet_model.dart';
import '../../../../providers/providers.dart';

class CentreInteretView extends ConsumerStatefulWidget {
  const CentreInteretView({super.key});

  @override
  _CentreInteretViewState createState() => _CentreInteretViewState();
}

class _CentreInteretViewState extends ConsumerState<CentreInteretView> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  Map<String, bool> categoryExpanded = {};

  @override
  void initState() {
    super.initState();
    for (var category in CentreInteretModel.centreInteretList) {
      categoryExpanded[category.category] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTags = ref.watch(tagsProvider);
    //print(selectedTags);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.large(
              'Quels sont vos centres\nd\'intérêts ?',
              textAlign: TextAlign.left,
            ),
            const Gap(3),
            AppText.medium(
              'Sélectionnez au moins un centre d\'intérêt pour recevoir des recommandations d\'évènements et de groupes.',
              fontWeight: FontWeight.w300,
              fontSize: 15,
              textAlign: TextAlign.left,
            ),
            const Gap(15),

            // Barre de recherche
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.03),
                border: Border.all(
                  color: Palette.separatorColor,
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher des centres d\'intérêt',
                  prefixIcon: Icon(Icons.search),

                  // Bordure lorsque le TextField est inactif
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent), // Pas de bordure
                    borderRadius: BorderRadius.circular(5),
                  ),

                  // Bordure lorsque le TextField est activé/focus
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent), // Pas de bordure
                    borderRadius: BorderRadius.circular(5),
                  ),

                  // Bordure lorsque le TextField est désactivé
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent), // Pas de bordure
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const Gap(15),

            // Affichage des centres d'intérêt sélectionnés
            if (selectedTags.isNotEmpty) ...[
              Text(
                'Ajouté',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
              const Gap(5),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: selectedTags.map((tag) {
                  return Chip(
                    color: WidgetStatePropertyAll(Palette.appRed),
                    shape: const StadiumBorder(),
                    side: BorderSide(color: Colors.transparent, width: 0),
                    deleteIcon: Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                    ),
                    label: Text(
                      tag,
                      style: TextStyle(color: Colors.white),
                    ),
                    onDeleted: () {
                      ref.read(tagsProvider.notifier).removeTag(tag);
                    },
                  );
                }).toList(),
              ),
              const Gap(15),
            ],

            // Catégories d'intérêts
            for (var category in CentreInteretModel.centreInteretList)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      category.category,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Palette.appRed,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        child: Icon(
                          categoryExpanded[category.category]!
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 18,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            categoryExpanded[category.category] =
                                !categoryExpanded[category.category]!;
                          });
                        },
                      ),
                    ),
                  ),
                  if (categoryExpanded[category.category]!)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: category.centres
                          .where((interest) =>
                              searchQuery.isEmpty ||
                              interest.toLowerCase().contains(searchQuery))
                          .map((interest) {
                        bool isSelected = selectedTags.contains(interest);
                        return FilterChip(
                          selectedColor: Palette.appRed,
                          checkmarkColor: Colors.white,
                          shape: const StadiumBorder(),
                          label: Text(
                            interest,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color.fromARGB(255, 77, 77, 77),
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(tagsProvider.notifier).addTag(interest);
                            } else {
                              ref
                                  .read(tagsProvider.notifier)
                                  .removeTag(interest);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  const Gap(10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
