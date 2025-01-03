import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/app_text.dart';
import '../../config/functions.dart';
import '../../config/palette.dart';
import '../../providers/providers.dart';
import '../../widgets/search_bar_view.dart';
import 'widgets/search_screen_doby.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String routeName = "searchScreen";
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  /*  List<String> categories = [
    "Entreprise",
    "Culture et Art",
    "Sport",
    "Social",
    "Education",
    "Charité et Levée de fonds",
    "Divertissement",
    "Religieux"
  ]; */

  // List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    var events = ref.watch(eventsProvider);
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
                //onLoading: _onLoading,
                onRefresh: () async {
                  events = await ref.refresh(eventsProvider);
                  await Future.delayed(Duration(milliseconds: 1000));
                  setState(() {});
                  _refreshController.refreshCompleted();
                },
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
                child: events.when(
                  data: (events) {
                    return SearchScreenBody(
                      events: Functions.filterAndSortUpcomingEvents(
                        events: events,
                      ),
                    );
                  },
                  error: (e, _) => Center(
                    child: AppText.medium(
                      e.toString(),
                    ),
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  //
}
