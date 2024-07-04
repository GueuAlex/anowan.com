import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../organizer/widgets/organizer_card.dart';
import 'widgets/header_carousel.dart';
import 'widgets/home_up_coming_events.dart';
import 'widgets/hot_events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isButtonVisible = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _isButtonVisible = _scrollController.position.userScrollDirection ==
          ScrollDirection.forward;
    });
  }

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
      backgroundColor: Palette.scafoldColor,
      floatingActionButton: MyFloatingButton(isButtonVisible: _isButtonVisible),
      body: Column(
        //controller: _scrollController,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
            child: headerCarousel(context: context),
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
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    HomeUpcomingEvents(),
                    HotEvents(),
                    Gap(10),
                    _topOrganizer(size: size),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _topOrganizer({required Size size}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(25),
          AppText.medium(
            'Top organisateurs',
            fontSize: (size.width * 0.042),
            fontWeight: FontWeight.w500,
          ),
          Gap(10),
          Row(
            children: [
              organizerCard(size: size),
            ],
          ),
          Gap(25),
        ],
      ),
    );
  }
}

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({
    super.key,
    required bool isButtonVisible,
  }) : _isButtonVisible = isButtonVisible;

  final bool _isButtonVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isButtonVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 130,
            height: 35,
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.circular(5.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Palette.primaryColor,
                  ),
                  Gap(5),
                  Expanded(
                    child: Center(
                      child: AppText.medium(
                        'Abidjan',
                        textOverflow: TextOverflow.ellipsis,
                        color: Palette.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gap(5),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
