import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/app_text.dart';
import '../../config/palette.dart';
import '../../providers/providers.dart';
import '../../widgets/action_tile.dart';
import '../../widgets/search_bar_view.dart';
import 'widgets/annuer_shimmer.dart';
import 'widgets/most_view.dart';
import 'widgets/prestator_by_category.dart';

class AnnuaireScreen extends ConsumerStatefulWidget {
  static String routeName = "AnnuaireScreen";
  const AnnuaireScreen({super.key});

  @override
  _AnnuaireScreenState createState() => _AnnuaireScreenState();
}

class _AnnuaireScreenState extends ConsumerState<AnnuaireScreen> {
  final RefreshController _annuaireRefreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // Accès à WidgetRef via ref
    final prestators = ref.watch(prestatorsProvider);

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
            child: SearchBarView(hintText: "Trouver un prestataire"),
          ),
          prestators.when(
            data: (listPrestator) {
              ///
              void _onRefresh() async {
                // EasyLoading.show();
                ref.invalidate(prestatorsProvider); // invalider le cache
                listPrestator = await ref.refresh(prestatorsProvider.future);
                _annuaireRefreshController.refreshCompleted();
                listPrestator.shuffle();

                // EasyLoading.dismiss();
              }

              return listPrestator.isNotEmpty
                  ? Expanded(
                      child: SmartRefresher(
                        //onLoading: () => ,
                        onRefresh: _onRefresh,
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _annuaireRefreshController,
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
                              PrestatorByCategory(prestatorList: listPrestator),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    top: BorderSide(
                                        width: 0.8,
                                        color: Palette.separatorColor),
                                  ),
                                ),
                                child: actionTile(
                                  size: size,
                                  onTap: () {},
                                  title: "Devenir prestataire",
                                  subtitle: "Proposer vos services sur Anowan",
                                  asset: "assets/images/cup.png",
                                ),
                              ),
                              Gap(10),
                              Container(
                                width: double.infinity,
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
                                    MostView(
                                      prestatorList:
                                          listPrestator.sublist(2, 4),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : _emptyPrestators();
            },
            error: (e, _) => _errowView(),
            loading: () => AnnuaireShimmer(),
          )
        ],
      ),
    );
  }

  Container _errowView() => Container();

  Container _emptyPrestators() => Container();

  //
}
