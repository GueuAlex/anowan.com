import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_text.dart';
import '../../../model/category_model.dart';
import '../../maps_screen/maps_screen.dart';

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
      return InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          MapsScreen.routeName,
          arguments: LatLng(5.345317, -4.024429),
        ),
        child: Container(
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
                        image:
                            NetworkImage(CategoryModel.categories[index].img),
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
        ),
      );
    },
  );
}
