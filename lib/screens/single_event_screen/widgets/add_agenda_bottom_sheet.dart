import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/localization_model.dart';
import '../../../widgets/custom_button.dart';

class AddToAgendaContainer extends StatelessWidget {
  const AddToAgendaContainer({
    super.key,
    required this.title,
    required this.description,
    required this.localization,
  });
  final String title;
  final String description;
  final LocalizationModel localization;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                AppText.medium(
                  '',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: Color.fromARGB(255, 20, 20, 20),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Palette.appRed.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Palette.appRed.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            size: 24,
                            color: Palette.appRed,
                            /* FluentIcons.calendar_add_24_regular, */
                            CupertinoIcons.calendar_badge_plus,
                          ),
                        ),
                      ),
                    ),
                    Gap(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: AppText.medium(
                        "Ne manquez plus jamais un événement important ! Ajoutez-le dès maintenant à votre agenda et restez organisé.",
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(30.0),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                          color: Palette.appRed,
                          width: double.infinity,
                          height: 35,
                          radius: 5,
                          text: 'Ajouter à mon agenda',
                          onPress: () => _addToCalendar(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ) //écrir une phrase attrayante et accrocheur
          ],
        ),
      ),
    );
  }

  _addToCalendar() {
    final Event event = Event(
      title: title,
      description: description,
      location: localization.place,
      startDate: localization.dateEvent,
      endDate: localization.dateEvent,
      iosParams: IOSParams(
        reminder: Duration(
          days: 1,
        ), // on iOS, you can set alarm notification after your event.
        url: 'https://anowan.com/', // on iOS, you can set url to your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );

    Add2Calendar.addEvent2Cal(event).then(
      (isAdded) {
        if (isAdded) {
          Functions.showToast(msg: 'Agenda ajoutée avec succès !');
          //Navigator.pop(context);
        } else {
          Functions.showToast(msg: 'Erreur lors de l\'ajout de l\'agenda !');
        }
      },
    );
  }
}
