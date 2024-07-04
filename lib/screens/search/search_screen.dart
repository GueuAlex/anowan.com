import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/app_text.dart';
import '../../config/palette.dart';
import '../../model/category_model.dart';
import '../../widgets/action_tile.dart';
import '../../widgets/search_bar_view.dart';
import 'widgets/categories_container.dart';
import 'widgets/category_events.dart';
import 'widgets/discover_by_date.dart';
import 'widgets/map_preview.dart';
import 'widgets/popular_events.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "searchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> categories = [
    "Entreprise",
    "Culture et Art",
    "Sport",
    "Social",
    "Education",
    "Charité et Levée de fonds",
    "Divertissement",
    "Religieux"
  ];

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
            child: searcheBarView(size: size),
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MapPreview(),
                          Gap(15),
                          DiscoversByDate(),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 25),
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
                              title: "Trouver un prestataire",
                              subtitle: "Pour l'organisation évènementiel",
                              asset: "assets/images/search-icon.png",
                            ),
                          ),
                          Gap(5)
                        ],
                      ),
                    ),
                    Gap(10),
                    // Dsicover events
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: AppText.medium(
                        'Découvrir des évenements',
                        fontSize: (size.width * 0.042),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          popularEvents(
                            size: size,
                            context: context,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: CategoryModel.categories
                                .map(
                                  (category) => categoryEvents(
                                    category: category.libelle,
                                    size: size,
                                    context: context,
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),

                    //become organizer
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
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
                          title: "Dévenir organisateur",
                          subtitle: "Organiser vos propres évènements",
                          asset: "assets/images/cup.png"),
                    ),

                    // discover by categories
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 22, 26, 27),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.medium(
                            'Parcourir les catégories',
                            color: const Color.fromARGB(255, 240, 240, 240),
                            fontSize: (size.width * 0.042),
                            fontWeight: FontWeight.w500,
                          ),
                          Gap(20),
                          categoriesContainer()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
}
