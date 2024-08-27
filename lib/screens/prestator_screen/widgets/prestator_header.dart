import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/prestator_model.dart';
import '../../../widgets/horizontal_separator.dart';
import '../../../widgets/vertical_separator.dart';
import 'about_prestator.dart';
import 'action_button_row.dart';
import 'get_contact.dart';
import 'more_contact.dart';
import 'photo_galery.dart';

class PrestatorHeader extends StatelessWidget {
  const PrestatorHeader({
    super.key,
    required this.prestator,
  });
  final PrestatorMdel prestator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.5,
      //color: Colors.grey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.21,
            child: Stack(
              //alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.16,
                  decoration: BoxDecoration(),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/anowan-placeholder.png',
                    image: prestator.images[0].url,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/anowan-placeholder.png',
                        fit: BoxFit.cover,
                      );
                    },
                    width: double.infinity,
                    // height: size.width * 0.25,
                  ),
                ),
                Positioned(
                  right: size.width / 2 - 40,
                  bottom: 0,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Palette.separatorColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/anowan-placeholder.png',
                        image: prestator.logo,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/anowan-placeholder.png',
                            fit: BoxFit.cover,
                          );
                        },
                        width: double.infinity,
                        // height: size.width * 0.25,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: AppText.large(
              prestator.name,
              maxLine: 2,
              fontSize: 22,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          AppText.medium(
            prestator.shortDescription,
            maxLine: 3,
            textAlign: TextAlign.center,
            textOverflow: TextOverflow.ellipsis,
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          Gap(5),
          horizontalSeparator(vpadding: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.location_24_regular),
              AppText.medium(
                '${prestator.town}, ${prestator.city} - ${prestator.country}',
              ),
            ],
          ),
          Gap(10),
          // horizontalSeparator(vpadding: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  GetContact(
                    svgPah: 'assets/icons/appel-de-notation-par-etoiles.svg',
                    text: 'Appeler',
                    onTap: () {},
                  ),
                  verticalSeparator(),
                  GetContact(
                    svgPah: 'assets/icons/whatsapp-line.svg',
                    text: 'WhatsApp',
                    onTap: () {},
                  ),
                  verticalSeparator(),
                  MoreContact(prestator: prestator)
                  /*  verticalSeparator(),
                  GetContact(
                    svgPah: 'assets/icons/facebook-line.svg',
                    text: 'Facebook',
                    gap: 0,
                    onTap: () {},
                  ),
                  verticalSeparator(),
                  GetContact(
                    svgPah: 'assets/icons/instagram-line.svg',
                    text: 'Instagram',
                    //gap: 0,
                    onTap: () {},
                  ),
                  verticalSeparator(),
                  GetContact(
                    svgPah: 'assets/icons/global-line.svg',
                    text: 'Site Web',
                    //gap: 0,
                    onTap: () {},
                  ), */
                ],
              ),
            ),
          ),
          Gap(5),
          ActionButtonsRow(),
          Gap(15),
          AboutPrestator(prestator: prestator),
          Gap(30),
          Expanded(
            child: PhotoGalery(images: prestator.images),
          )
        ],
      ),
    );
  }
}
