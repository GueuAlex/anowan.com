import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/app_text.dart';
import '../../config/palette.dart';
import '../../widgets/add_forite.dart';
import '../../widgets/customAnimateSlide.dart';
import '../../widgets/custom_leading.dart';
import '../../widgets/menu_contextuel.dart';
import 'widgets/bottom_area.dart';
import 'widgets/date_selector.dart';
import 'widgets/event_about.dart';
import 'widgets/google_map_container.dart';
import 'widgets/more_event_container.dart';
import 'widgets/organisateur_page_route.dart';
import 'widgets/sellStatus.dart';
import 'widgets/tag_container.dart';

class SingleEventScreen extends StatelessWidget {
  static String routeName = 'single_event_screen';
  const SingleEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CustomeAnimatedSlide(
        child: BottomArea(size: size),
        // duration: const Duration(seconds: 5),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            leadingWidth: 35,
            leading: CustomLeading(),
            actions: [
              AddForiteButton(),
              Gap(5),
              MenuContextuel(),
              Gap(5),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: double.infinity,
                child: AppText.medium(
                  'Abidjain Rhum Festival 2023',
                  color: Palette.blackColor,
                  textAlign: TextAlign.center,
                ),
              ),
              background: Image.asset(
                'assets/images/concert-demo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SellStatus(),
                      OrganisateurPageRoute(),
                      DateSelector(),
                      EventAbout(),
                      const Divider(),
                      GoogleMapContainer(),
                      const Divider(),
                      TageContainer(),
                      MoreEventContainer()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
