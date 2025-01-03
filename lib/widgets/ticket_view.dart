import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../config/app_layout.dart';
import '../config/app_text.dart';
import '../config/palette.dart';
import 'ticket_dot.dart';

class TicketView extends StatelessWidget {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width,
      height: 200,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            /* 
                partie bleu du ticket
               */
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Palette.blueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                  )),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText.medium(
                        'NYC',
                        color: Palette.whiteColor,
                      ),
                      Expanded(child: Container()),
                      const TicketDot(),
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 24,
                              child: LayoutBuilder(
                                builder: (p0, p1) {
                                  return Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(
                                      (p1.constrainWidth() / 6).floor(),
                                      (index) => const SizedBox(
                                        width: 3,
                                        height: 1,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Palette.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Center(
                              child: Icon(
                                FluentIcons.ticket_diagonal_20_filled,
                                color: Palette.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const TicketDot(),
                      const Spacer(),
                      AppText.medium(
                        'LDN',
                        color: Palette.whiteColor,
                      ),
                    ],
                  ),
                  /////////////
                  const Gap(3),
                  ////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: AppText.medium(
                          'New-York',
                          color: Palette.whiteColor,
                        ),
                      ),
                      AppText.medium(
                        '8H 30M',
                        color: Palette.whiteColor,
                      ),
                      SizedBox(
                        width: 100,
                        child: AppText.medium(
                          'London',
                          color: Palette.whiteColor,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  )
                  /////////////
                  ///
                ],
              ),
            ),
            /* 
              partie orange du ticket
             */
            Container(
              color: Palette.redColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  const SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Palette.whiteColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                  ),
                  Expanded(
                    child: Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      direction: Axis.horizontal,
                      children: List.generate(
                        5,
                        (index) => const SizedBox(
                          width: 5,
                          height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Palette.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///
                  const SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Palette.whiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    ),
                  )
                ],
              ),
            )
            ////////
          ],
        ),
      ),
    );
  }
}
