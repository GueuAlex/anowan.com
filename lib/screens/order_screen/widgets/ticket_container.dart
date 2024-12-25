import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/screens/order_screen/widgets/third_party_container.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/third_party_model.dart';
import '../../../providers/providers.dart';

class TicketContainer extends ConsumerWidget {
  const TicketContainer({
    super.key,
    required this.ticket,
    required this.onTap,
    this.thirdPart,
  });
  final SelectedTickeModel ticket;
  final VoidCallback onTap;
  final ThirdPartyModel? thirdPart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(selectedEventProvider);
    final pass =
        event!.passes!.firstWhere((element) => element.id == ticket.passId);

    bool willShare = thirdPart != null;
    //print(pass);
    return Container(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 6,
        right: 12,
      ),
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 2),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.55,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 0.5),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // padding: const EdgeInsets.all(10),
            width: 60,
            decoration: BoxDecoration(
              color: Palette.appRed,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Icon(
                FluentIcons.ticket_diagonal_24_regular,
                color: const Color.fromARGB(255, 249, 221, 221),
              ),
            ),
          ),
          const Gap(8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(pass.name),
              AppText.medium(
                '${Functions.numberFormat(pass.price.toString())} ₣',
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              GestureDetector(
                onTap: onTap,
                child: !willShare
                    ? Row(
                        children: [
                          AppText.small(
                            'Envoyer à quelqu\'un',
                            color: const Color.fromARGB(255, 48, 124, 255),
                          ),
                          const Gap(5),
                          SvgPicture.asset(
                            'assets/icons/fleche-vers-le-haut-vers-la-droite.svg',

                            colorFilter: ColorFilter.mode(
                              const Color.fromARGB(255, 48, 124, 255),
                              BlendMode.srcIn,
                            ),
                            width: 11,
                            //size: size.width * 0.03,
                          )
                        ],
                      )
                    : ThirdPartyContainer(thirdPart: thirdPart!),
              )
            ],
          ),
        ],
      ),
    );
  }
}
