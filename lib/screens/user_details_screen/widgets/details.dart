import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/palette.dart';
import '../../../widgets/counter.dart';
import '../../../widgets/vertical_separator.dart';
import 'about.dart';
import 'centre_interet_2.dart';
import 'invite_friends.dart';
import 'organize_area.dart';
import 'pic_and_name.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.38,
      maxChildSize: 0.7,
      builder: (context, controller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            color: Colors.white,
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            controller: controller,
            itemCount: 1,
            itemBuilder: (context, index) {
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(5),
                      _sheetCloserBar(),
                      const Gap(15),
                      const PicAndName(),
                      const Gap(15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          counter(count: 11),
                          verticalSeparator(),
                          counter(count: 8, text: 'Centre d\'intérêt'),
                          verticalSeparator(),
                          counter(count: 5, text: 'Évenements à venir'),
                        ],
                      ),
                      const Gap(15),
                      const InviteFriends(),
                      const Gap(15),
                      const About(),
                      const Gap(15),
                      CentreInteret2(),
                      const Gap(15),
                      const OrganizeArea(),
                      const Gap(50),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Container _sheetCloserBar() {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: Palette.separatorColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
