import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';

import '../../widgets/add_forite.dart';
import '../../widgets/customAnimateSlide.dart';
import '../../widgets/custom_leading.dart';
import '../../widgets/menu_contextuel.dart';
import 'widgets/bottom_area.dart';
import 'widgets/sellStatus.dart';

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
                    children: [SellStatus(), OrganisateurPageRoute()],
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

class OrganisateurPageRoute extends StatelessWidget {
  const OrganisateurPageRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => print('go to orgasiteur profil'),
                    child: AppText.medium(
                      'Captain Shrine - La Maison du Rhum',
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gap(8),
                  AppText.medium(
                    '59 abonnés',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  )
                ],
              ),
            ),
            Gap(15),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(1),
                backgroundColor: MaterialStatePropertyAll(
                  Color.fromARGB(255, 17, 118, 234),
                ),
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                width: 90,
                child: AppText.medium(
                  'Suivre',
                  textAlign: TextAlign.center,
                  color: Palette.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
