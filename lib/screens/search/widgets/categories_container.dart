import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../model/category_model.dart';

GridView categoriesContainer() {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Deux éléments par ligne
      crossAxisSpacing: 12, // Espacement horizontal entre les éléments
      mainAxisSpacing: 8, // Espacement vertical entre les éléments
      childAspectRatio: 3 / 2.7, // Ratio de chaque élément (largeur/hauteur)
    ),
    itemCount: CategoryModel
        .categories.length, // Nombre total d'éléments dans la grille
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 2),
                //height: ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: NetworkImage(CategoryModel.categories[index].img),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            AppText.medium(
              CategoryModel.categories[index].libelle,
              maxLine: 1,
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.039,
            ),
          ],
        ),
      );
    },
  );
}
