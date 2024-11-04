import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/palette.dart';
import '../../../constants/constants.dart';
import '../../../model/prestator_model.dart';
import 'open_photos.dart';

class PhotoGalery extends StatelessWidget {
  const PhotoGalery({
    super.key,
    required this.images,
  });

  final List<PrestatorCovers> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Color.fromARGB(255, 208, 208, 208),
                ),
              ),
            ),
            child: Center(
              child: Container(
                width: 45,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2.5,
                      color: Color.fromARGB(255, 57, 57, 57),
                    ),
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/icons/menu2.svg',
                  width: 22,
                  colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 57, 57, 57),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          // GridView.builder pour afficher les images
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(top: 1),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 images par ligne
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PhotoGalleryScreen(
                        images: images,
                        initialIndex: index,
                      ),
                    ),
                  ),
                  child: Image.network(
                    images[index].url ?? networtImgPlaceholder,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Palette.separatorColor,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Palette.separatorColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
