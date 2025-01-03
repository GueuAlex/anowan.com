import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../constants/constants.dart';
import '../../../model/prestator_model.dart';

Container prestatorCard({
  required PrestatorMdel prestator,
  required Size size,
  required VoidCallback onTap,
  required BuildContext context,
}) =>
    Container(
      width: size.width * 0.6,
      //height: size.width * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Palette.whiteColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.8, color: Palette.separatorColor),
        boxShadow: [
          BoxShadow(
            color: Palette.separatorColor,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/anowan-placeholder.png',
                          image:
                              prestator.images[0].url ?? networtImgPlaceholder,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/anowan-placeholder.png',
                              fit: BoxFit.cover,
                            );
                          },
                          width: double.infinity,
                          height: size.width * 0.25,
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/anowan-placeholder.png',
                        image: prestator.logo ?? networtImgPlaceholder,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/anowan-placeholder.png',
                            fit: BoxFit.cover,
                          );
                        },
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _prestatorDetails(size, prestator),
          ],
        ),
      ),
    );

Container _prestatorDetails(Size size, PrestatorMdel prestator) {
  return Container(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
    width: double.infinity,
    //height: size.width * 0.38,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          prestator.name,
          fontSize: (size.width * 0.048),
          fontWeight: FontWeight.w700,
          maxLine: 1,
          color: Color.fromARGB(255, 39, 40, 41),
          //textAlign: TextAlign.center,
        ),
        Gap(4),
        Transform.rotate(
          angle: -0.03, // Rotation en radians
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(226, 180, 20, 52),
              borderRadius: BorderRadius.circular(3),
            ),
            child: AppText.medium(
              prestator.serviceCategory,
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              maxLine: 1,
            ),
          ),
        ),
        Gap(10),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: Color.fromARGB(255, 114, 114, 114),
            ),
            AppText.medium(
              '${prestator.town}, ${prestator.city}',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 29, 29, 29),
            )
          ],
        ),
        Gap(4),
        AppText.medium(
          prestator.shortDescription ?? '',
          maxLine: 2,
          fontWeight: FontWeight.w300,
        )
      ],
    ),
  );
}
