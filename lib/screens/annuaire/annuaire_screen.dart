import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:ticketwave/model/prestator_model.dart';

import '../../config/app_text.dart';
import '../../config/palette.dart';
import '../../widgets/action_tile.dart';
import '../../widgets/search_bar_view.dart';
import 'widgets/prestator_by_category.dart';

class AnnuaireScreen extends StatefulWidget {
  static String routeName = "AnnuaireScreen";
  const AnnuaireScreen({super.key});

  @override
  State<AnnuaireScreen> createState() => _AnnuaireScreenState();
}

class _AnnuaireScreenState extends State<AnnuaireScreen> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 238, 241),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            height: (size.height * 0.084),
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
            child: searcheBarView(size: size, text: "Trouver un prestataire"),
          ),
          Expanded(
            child: SmartRefresher(
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              physics: BouncingScrollPhysics(),
              header: ClassicHeader(
                completeText: "",
                idleText: "",
                refreshingText: "",
                releaseText: "",
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrestatorByCategory(),
                    Container(
                      width: double.infinity,
                      //margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              width: 0.8, color: Palette.separatorColor),
                        ),
                      ),
                      child: actionTile(
                        size: size,
                        onTap: () {},
                        title: "Dévenir prestataire",
                        subtitle: "Proposer vos services sur Anowan",
                        asset: "assets/images/cup.png",
                      ),
                    ),
                    Gap(10),
                    Container(
                      width: double.infinity,
                      //margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.medium(
                            'Les plus consultés',
                            fontSize: (size.width * 0.0435),
                            fontWeight: FontWeight.w500,
                          ),
                          Gap(15),
                          _mostViewedPrestators(size: size),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostViewedPrestators({required Size size}) {
    return BannerCarousel(
      height: 140,
      margin: const EdgeInsets.all(0),
      activeColor: Palette.appRed,
      customizedIndicators:
          IndicatorModel(width: 5, height: 5, spaceBetween: 3),
      customizedBanners: List.generate(
        PrestatorMdel.prestators.length,
        (index) => _mostViewedPrestatorsContainer(
            size: size, prestator: PrestatorMdel.prestators[index]),
      ),
    );
  }

  Container _mostViewedPrestatorsContainer({
    required Size size,
    required PrestatorMdel prestator,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 13),
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
                    image: NetworkImage(prestator.images[0].url),
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
                color: const Color.fromARGB(255, 101, 192, 104),
              ),
            ],
          )
        ],
      ),
    );
  }
  //
}
