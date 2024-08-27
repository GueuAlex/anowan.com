import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/palette.dart';
import '../organizer_screen/widgets/organizer_suggestion.dart';
import 'widgets/centre_interet.dart';
import 'widgets/up_coming_events.dart';

class ProfilScreen extends StatefulWidget {
  static String routeName = "ProfilScreen";
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
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
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 238, 241),
      body: Column(
        children: [
          Container(
            //padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            height: 5,
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
            //child: searcheBarView(size: size),
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: UpcomingEvents(),
                    ),
                    // centre interet
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: CentreInteret(),
                    ),

                    //suivre organisateurs
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: OrganizerSuggestion(),
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
