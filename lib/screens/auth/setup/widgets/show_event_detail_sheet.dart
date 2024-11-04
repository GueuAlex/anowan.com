import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/model/pass_model.dart';
import 'package:ticketwave/widgets/horizontal_separator.dart';
import 'package:ticketwave/widgets/sheet_closer_cross.dart';

import '../../../../config/app_text.dart';
import '../../../../constants/constants.dart';
import '../../../../model/event_model.dart';
import '../../../../providers/bookmark_event_provider.dart';
import '../../../organizer_screen/widgets/organizer_row.dart';
import '../../../single_event_screen/widgets/icon_row.dart';

class ShowEventDetailSheet extends ConsumerWidget {
  const ShowEventDetailSheet({super.key, required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupérer la liste des événements favoris
    final bookmarkedEvents = ref.watch(bookmarkedEventsProvider);

    // Vérifier si l'événement est déjà favori
    final bool isBookmarked = bookmarkedEvents.contains(event.id.toString());
    final size = MediaQuery.of(context).size;
    List<PassModel> passes = [];
    if (event.passes != null) {
      passes = PassModel.sortPassesByPrice(event.passes!);
    }
    return Container(
      width: double.infinity,
      height: size.height * 0.90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: 200,
                ),
                child: Container(
                  // margin: const EdgeInsets.only(right: 15),
                  width: double.infinity,
                  height: size.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/anowan-placeholder.png',
                      image: event.image ?? networtImgPlaceholder,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/anowan-placeholder.png',
                          fit: BoxFit.cover,
                        );
                      },
                      width: double.infinity,
                      height: size.height,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: 200,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  left: 0,
                  child: Container(
                    child: sheetCloserCross(ctxt: context),
                  ))
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.medium(
                      event.name,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: (size.width * 0.04),
                      fontWeight: FontWeight.w700,
                      maxLine: 3,
                      color: Color.fromARGB(255, 39, 40, 41),
                    ),
                    //
                    Gap(10),
                    AppText.medium(
                      'A propos de cet événement',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(5),
                    HtmlWidget(
                      event.shortDescription ?? '',
                      renderMode: RenderMode.column,
                      textStyle: TextStyle(fontSize: 14),
                    ),
                    Gap(10),
                    IconRow(
                      showIcon: false,
                      icon: FluentIcons.calendar_24_regular,
                      title:
                          '${DateFormat('EEEE dd MMM  à ', 'fr_FR').format(event.localizations[0].dateEvent)} ${event.localizations[0].starttimeEvent}',
                      subtitle:
                          'Les horaires sont affichés dans votre fuseau horaire',
                      onTap: () {},
                    ),
                    Gap(5),
                    IconRow(
                      showIcon: false,
                      icon: FluentIcons.location_24_regular,
                      title: '${event.localizations[0].place}',
                      subtitle: 'Abijan - CI',
                      onTap: () {},
                    ),
                    Gap(10),
                    AppText.medium(
                      'Cet événement est organisé par',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    OrganizerRow(
                      assets: event.organizer.avatar ??
                          networtImgPlaceholder, // Assuming imageUrl in OrganizerModel
                      name: event.organizer.name ?? '',
                      followers: '114k followers',
                      events: '9+ événements',
                      isSetup: true,
                      organizerId: event.organizer.id.toString(),
                    ),

                    Row(
                      children: [
                        _participants(),
                        Expanded(
                          child: AppText.medium(
                            'Participent à cet événement',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    if (isBookmarked)
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.green),
                        ),
                        child: Center(
                          child: Text(
                            'L\'événement à été ajouter à vos favoris. Rendez-vous dans la section favoris de votre profile pour la reservation de vos billets.',
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          horizontalSeparator(width: double.infinity, height: 0.8),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  event.free || passes.isEmpty
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.large(
                                'GRATUIT',
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.small(
                                'Cet évènement est accessible à partir de',
                              ),
                              AppText.large(
                                '${passes[0].price.toString()} F CFA',
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                  Gap(8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: isBookmarked ? Colors.grey : Palette.appRed,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (isBookmarked) return;
                        await ref
                            .read(bookmarkedEventsProvider.notifier)
                            .addEvent(event.id.toString());
                      },
                      child: Text(
                        'Je participe',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _participants() => Container(
        constraints: BoxConstraints(maxHeight: 65, maxWidth: 150),
        width: 115,
        height: 65,
        //color: Colors.amber,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            _smalpic(assest: 'assets/images/carousel/carousel1.jpg'),
            Positioned(
              left: 20,
              child: _smalpic(assest: 'assets/images/carousel/carousel2.jpg'),
            ),
            Positioned(
              left: 40,
              child: _smalpic(assest: 'assets/images/carousel/carousel3.jpg'),
            ),
            Positioned(
              left: 60,
              child: _smalpic(),
            )
          ],
        ),
      );

  Container _smalpic({String count = '99', String assest = ''}) {
    bool isAsset = assest.isNotEmpty;
    if (isAsset)
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Palette.primaryColor, width: 2.5),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(assest),
            )),
      );
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 225, 225, 225),
        shape: BoxShape.circle,
        border: Border.all(color: Palette.primaryColor, width: 2.5),
      ),
      child: Center(
        child: FittedBox(
            child: Text(
          '+$count',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
