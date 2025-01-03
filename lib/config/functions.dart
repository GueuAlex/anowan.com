import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as htt;
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import '../model/event_model.dart';
import '../model/localization_model.dart';
import '../remote_service/remote_service.dart';
import '../widgets/all_sheet_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/snackbar_widget.dart';
import 'app_text.dart';
import 'palette.dart';
import 'preferences.dart';

class Functions {
  static void showSnackBar(
      {required BuildContext ctxt, required String messeage}) {
    ScaffoldMessenger.of(ctxt).showSnackBar(
      SnackBar(
        content: AppText.medium(
          messeage,
          color: Colors.white70,
        ),
        duration: const Duration(seconds: 3),
        elevation: 5,
      ),
    );
  }

  /// bottom sheet preconfiguré
  static Future<void> showBottomSheet({
    required BuildContext ctxt,
    required Widget widget,
    required Size size,
    double heightRatio = 1.3,
    bool isMargin = false,
  }) async {
    return await showModalBottomSheet(
      // sheetAnimationStyle: SheetAnimationStyle.slideInBottom,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      context: ctxt,
      builder: (context) {
        return Container(
          margin: isMargin
              ? EdgeInsets.only(
                  top: size.height - (size.height / heightRatio),
                )
              : EdgeInsets.zero,
          height: size.height / heightRatio,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: widget,
        );
      },
    );
  }

  static BorderRadius borderRadius() {
    return const BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    );
  }

  /// renvoi un widget avec a l'intérieur un érreur 404
  static Widget widget404({required Size size, required BuildContext ctxt}) {
    return Container(
      /* width: double.infinity, */
      height: 260,
      /* margin: EdgeInsets.only(bottom: keyboardHeight), */
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      //height: size.height / 1.5,
      width: size.width,
      child: Center(
        child: Column(
          children: [
            const AllSheetHeader(),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Column(
                children: [
                  Container(
                    width: 135,
                    height: 135,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/icons/404.svg'),
                  ),
                  //AppText.medium('Not found !'),
                  AppText.small('Aucune correspondance !'),
                  const SizedBox(
                    height: 20,
                  ),
                  //Expanded(child: Container()),
                  CustomButton(
                    color: Palette.appRed,
                    width: double.infinity,
                    height: 35,
                    radius: 5,
                    text: 'Retour',
                    onPress: () => Navigator.pop(ctxt),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget inactifQrCode({required BuildContext ctxt}) {
    return Container(
      width: double.infinity,
      height: 230,
      /* margin: EdgeInsets.only(bottom: keyboardHeight), */
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const AllSheetHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/disconnect.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                AppText.medium('Oops !'),
                AppText.small('Ce Qr code est suspendu !'),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  color: Palette.appRed,
                  width: double.infinity,
                  height: 35,
                  radius: 5,
                  text: 'Retour',
                  onPress: () => Navigator.pop(ctxt),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    /* required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel, */
    required Widget child,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return child;
      },
    );
  }

  static isValidEmail(String email) {
    return RegExp(r"^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

/*   static Future<TicketModel?> getTicketFromApi(
      {required String uniqueCode}) async {
    return await RemoteService().getTicket(uniqueCode: uniqueCode);
  } */

  // method to PUT  ticket
  static Future<dynamic> scanValidation({
    required Map<String, dynamic> data,
    required String uniqueCode,
  }) async {
    var response = await RemoteService().putSomethings(
      api: 'tickets/$uniqueCode/scan',
      data: data,
    );
    return response;
  }

  // method to add scan history
  static Future<htt.Response> scanValidation2({
    required Map<String, dynamic> data,
    /*  required String uniqueCode, */
  }) async {
    var response = await RemoteService().postSomethings(
      api: 'histories-scan/scan',
      data: data,
    );
    return response;
  }

  // simple bottom sheet
  static Future<void> showSimpleBottomSheet({
    required BuildContext ctxt,
    required Widget widget,
    AnimationStyle? sheetAnimationStyle,
    AnimationController? transitionAnimationController,
  }) async {
    return await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      transitionAnimationController: transitionAnimationController,
      sheetAnimationStyle: sheetAnimationStyle,
      context: ctxt,
      builder: (context) {
        return widget;
      },
    );
  }

  static TextField getTextField({
    required TextEditingController controller,
    required String textFieldLabel,
    TextInputType keyboardType = TextInputType.name,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
    bool obscureText = false,
    void Function(String)? onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: textFieldLabel,
        hintStyle: TextStyle(color: Colors.grey),

        /* label: AppText.medium(
          textFieldLabel,
          color: Colors.grey.withOpacity(0.5),
        ), */
        border: InputBorder.none,
      ),
    );
  }

  static DateTime getToday() {
    // renvoi la date du jour
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

/*   static bool containsCurrentDate(List<DateTime> dates) {
    DateTime currentDate = DateTime.now();
    for (DateTime date in dates) {
      if (date.year == currentDate.year &&
          date.month == currentDate.month &&
          date.day == currentDate.day) {
        return true;
      }
    }
    return false;
  } */

  static bool containsCurrentDate(List<DateTime> dates) {
    DateTime currentDate = DateTime.now();
    bool allDatesInPast = true;

    for (DateTime date in dates) {
      // Vérifie si une date correspond à aujourd'hui
      if (date.year == currentDate.year &&
          date.month == currentDate.month &&
          date.day == currentDate.day) {
        return true;
      }
      // Vérifie si la date est dans le futur
      if (date.isAfter(currentDate)) {
        allDatesInPast = false;
      }
    }

    // Retourne true si toutes les dates sont dans le passé
    return allDatesInPast;
  }

  static Size contextSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size;
  }

  static followOrganizer() {
    debugPrint('follow organizer');
  }

  static showToast({
    required String msg,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: Palette.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

/* // events du plus proche au plus future
  static List<EventModel> filterAndSortUpcomingEvents(List<EventModel> events) {
    return events.where((event) {
      // Filtrer les événements dont au moins une date de localisation est dans le futur
      return event.visibility &&
          event.published &&
          event.localizations.any(
            (location) => location.dateEvent.isAfter(DateTime.now()),
          );
    }).toList()
      ..sort((a, b) {
        // Trouver la date la plus proche dans les localisations de chaque événement
        final aClosestDate = a.localizations
            .where((location) => location.dateEvent.isAfter(DateTime.now()))
            .map((location) => location.dateEvent)
            .reduce((date1, date2) => date1.isBefore(date2) ? date1 : date2);

        final bClosestDate = b.localizations
            .where((location) => location.dateEvent.isAfter(DateTime.now()))
            .map((location) => location.dateEvent)
            .reduce((date1, date2) => date1.isBefore(date2) ? date1 : date2);

        return aClosestDate.compareTo(bClosestDate);
      });
  } */

// events ordonnées par date du plus future proche au plus en ancien (ajout un param bool withPassEvents = false pour inclu les events déjà passés ou non)
  static List<EventModel> filterAndSortUpcomingEvents(
      {required List<EventModel> events, bool withPassEvents = true}) {
    DateTime today = DateTime.now();

    // Function to find the nearest date in localizations
    DateTime getNearestDate(EventModel event) {
      return event.localizations
          .map((localization) => localization.dateEvent)
          .reduce((current, next) => current.isBefore(next) ? current : next);
    }

    // Split the events into three categories
    List<EventModel> todayEvents = [];
    List<EventModel> futureEvents = [];
    List<EventModel> pastEvents = [];

    for (var event in events) {
      // Only process events that are published and visible
      //if (event.published && event.visibility) {
      DateTime nearestDate = getNearestDate(event);

      if (nearestDate.isAtSameMomentAs(today)) {
        todayEvents.add(event);
      } else if (nearestDate.isAfter(today)) {
        futureEvents.add(event);
      } else {
        pastEvents.add(event);
      }
      //}
    }

    // Sort future events by nearest date (from nearest to furthest)
    futureEvents.sort((a, b) => getNearestDate(a).compareTo(getNearestDate(b)));

    // Sort past events by nearest date (from most recent to oldest)
    pastEvents.sort((a, b) => getNearestDate(b).compareTo(getNearestDate(a)));

    // Combine the lists
    if (withPassEvents) return [...todayEvents, ...futureEvents, ...pastEvents];
    return [...todayEvents, ...futureEvents];
  }

  static List<EventModel> eventsHistory(List<EventModel> events) {
    return events.where((event) {
      // Filtrer les événements dont au moins une date de localisation est dans le futur
      return event.localizations.any(
        (location) => location.dateEvent.isBefore(DateTime.now()),
      );
    }).toList()
      ..sort((a, b) {
        // Trouver la date la plus proche dans les localisations de chaque événement
        final aClosestDate = a.localizations
            .where((location) => location.dateEvent.isBefore(DateTime.now()))
            .map((location) => location.dateEvent)
            .reduce((date1, date2) => date1.isBefore(date2) ? date1 : date2);

        final bClosestDate = b.localizations
            .where((location) => location.dateEvent.isBefore(DateTime.now()))
            .map((location) => location.dateEvent)
            .reduce((date1, date2) => date1.isBefore(date2) ? date1 : date2);

        return aClosestDate.compareTo(bClosestDate);
      });
  }

  static List<LocalizationModel> filterAndSortLocalizations(
      List<LocalizationModel> localizations) {
    return localizations.where((localization) {
      // Filtrer les localisations dont la date est dans le futur
      return localization.dateEvent.isAfter(DateTime.now());
    }).toList()
      ..sort((a, b) {
        // Trier par date la plus proche
        return a.dateEvent.compareTo(b.dateEvent);
      });
  }

  //
  static List<EventModel> filterEventsByCategory(
    List<EventModel> events,
    String category,
  ) {
    return events
        .where((event) =>
            event.category.trim().toLowerCase() ==
            category.trim().toLowerCase())
        .toList();
  }

  static Future<void> launchUri({required String url}) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      Functions.showToast(msg: 'Could not launch $_url');
    }
  }

  static Future<void> launchUri2({required Uri url}) async {
    //final Uri _url = Uri.parse(url);

    if (!await launchUrl(url)) {
      Functions.showToast(msg: 'Could not launch ${url.toString()}');
    }
  }

  static String? getFirstWord(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    }
    // Séparer les mots par espace et retourner le premier mot
    return text.split(',').first.trim();
  }

  static Future<void> setLoggedState({required bool isLogged}) async {
    final prefs = await Preferences();
    await prefs.setBool('isLogged', isLogged);
  }

  static Future<bool> getLoggedState() async {
    final prefs = await Preferences();
    return prefs.getBool('isLogged') ?? false;
  }

  ///
  static String numberFormat(String input) {
    // Supprimer les espaces et vérifier si l'entrée est un nombre valide
    String cleanedInput = input.replaceAll(' ', '');

    // Supprimer le ".0" à la fin de la chaîne si présent
    if (cleanedInput.endsWith('.0')) {
      cleanedInput = cleanedInput.substring(0, cleanedInput.length - 2);
    }

    // Convertir la chaîne nettoyée en entier
    int? number = int.tryParse(cleanedInput);

    // Si la conversion réussit, formater avec des espaces
    if (number != null) {
      final formattedNumber = NumberFormat('#,###', 'fr_FR').format(number);
      return formattedNumber.replaceAll(',', ' ');
    }

    // Si la conversion échoue, renvoyer la chaîne d'origine
    return input;
  }

  static String stringToTimeOfDay(String heureVisite) {
    final parsedTime = heureVisite
        .split(':'); // Sépare la chaîne en heures, minutes et secondes
    int hour = int.parse(parsedTime[0]); // Convertir les heures en int
    int minute = int.parse(parsedTime[1]); // Convertir les minutes en int
    if (minute == 0) {
      return '$hour:${minute}0';
    }
    return '$hour:$minute'; // Retourner un TimeOfDay
  }

  static void getSnackbar({required String messageText, IconData? icon}) {
    Get.rawSnackbar(
      messageText: SnackbarWidget(
        icon: icon,
        text: messageText,
      ),
      isDismissible: false,
      duration: const Duration(days: 1),
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.only(top: 2, bottom: 0),
      margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: SnackPosition.TOP,
    );
  }

  static // Fonction pour calculer le nombre total de tickets sélectionnés
      int calculateTotalTickets(Map<int, int> selectedPass) {
    int totalTickets = 0;
    for (var count in selectedPass.values) {
      totalTickets += count;
    }
    return totalTickets;
  }

  /* static // Fonction pour calculer le nombre total de tickets sélectionnés
      List<int> getSelectePassIds(Map<int, int> selectedPass) {
   /*    List<int> ids = [];
    for (var id in selectedPass.keys) {
      ids.add(id);
    } */
    return selectedPass.keys.toList();
  } */
}


// est ce que tu peux écrire une fonction qui filtre les évènements de la manière suivante :
// les évents dont la date est également aux d'aujourd'hui sont en tete de la liste
// suivi des évents dont les dates sont proches (future en fonction) de la date de aujourd'hui
// Et enfin les évents dont la date est déjà passé classée du plus recent au plus ancien

