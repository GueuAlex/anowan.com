import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../constants/constants.dart';
import '../../../model/prestator_model.dart';
import '../../prestator_screen/prestator_screen.dart';

class MostView extends StatelessWidget {
  const MostView({super.key, required this.prestatorList});
  final List<PrestatorMdel> prestatorList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BannerCarousel(
      height: 150,
      margin: const EdgeInsets.all(0),
      activeColor: Palette.appRed,
      customizedIndicators:
          IndicatorModel(width: 5, height: 5, spaceBetween: 3),
      customizedBanners: List.generate(
        prestatorList.length,
        (index) => _mostViewedPrestatorsContainer(
          size: size,
          prestator: prestatorList[index],
          context: context,
        ),
      ),
    );
  }

  Container _mostViewedPrestatorsContainer({
    required Size size,
    required PrestatorMdel prestator,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(
        right: 10,
        left: 10,
        bottom: 13,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        /*  border: Border.all(
          width: 0.8,
          color: Color.fromARGB(255, 181, 181, 181),
        ), */
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(50, 0, 0, 0),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          PrestatorScreen.routeName,
          arguments: prestator,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Palette.appRed,
                          ),
                          AppText.medium(
                            '${prestator.town}, ${prestator.city}',
                            color: Palette.appRed,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      AppText.medium(
                        prestator.name,
                        fontSize: (size.width * 0.048),
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                        color: Color.fromARGB(255, 39, 40, 41),
                      ),
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
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Palette.separatorColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        prestator.images[0].url ?? networtImgPlaceholder,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.medium(
                  '456 consultations',
                  fontWeight: FontWeight.w300,
                ),
                SvgPicture.asset(
                  'assets/icons/controle-des-badges.svg',
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 101, 192, 104),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
