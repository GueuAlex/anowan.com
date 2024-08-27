import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/model/localization_model.dart';
import 'package:ticketwave/screens/single_event_screen/widgets/icon_row.dart';

import '../../config/app_text.dart';
import '../../model/event_model.dart';
import '../../model/pass_model.dart';
import '../../widgets/app_bar_leading.dart';
import 'widgets/checkout_draggable_sheet.dart';
import 'widgets/pass_selector.dart';

class OrderScreen extends StatefulWidget {
  static String routeName = 'order_screen';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Liste pour suivre le nombre de passes sélectionnés
  int _selectedIndex = 0;
  late LocalizationModel _selectedLocalization;
  Map<int, int> selectedPass = {};

  @override
  void initState() {
    super.initState();

    PassModel.passList.sort((a, b) => a.price.compareTo(b.price));
    // Initialiser selectedPass avec des valeurs par défaut (0)
    for (var pass in PassModel.passList) {
      selectedPass[pass.id] = 0;
    }
  }

  void _addPass(int passId) {
    setState(() {
      selectedPass[passId] = selectedPass[passId]! + 1;
    });
  }

  void _removePass(int passId) {
    setState(() {
      if (selectedPass[passId]! > 0) {
        selectedPass[passId] = selectedPass[passId]! - 1;
      }
    });
  }

  int _totalPrice = 0;

  void calculateTotalPrice() {
    int totalPrice = 0;
    PassModel.passList.forEach((pass) {
      int count = selectedPass[pass.id] ?? 0;
      totalPrice += pass.price * count;
    });
    setState(() {
      _totalPrice = totalPrice;
    });
    //return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    final List<LocalizationModel> localizations = event.localizations;
    final size = MediaQuery.of(context).size;
    //double hauteur = Scaffold.of(context).appBarMaxHeight!;

    setState(() {
      _selectedLocalization = localizations[_selectedIndex];
    });

    bool isMultipleLocalization = localizations.length > 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppText.medium(event.name),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: AppBarLeading(),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight -
                    (kToolbarHeight + MediaQuery.of(context).padding.top),
                margin: EdgeInsets.only(
                  top: (kToolbarHeight + MediaQuery.of(context).padding.top),
                  bottom: size.height * 0.30,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  //physics: const BouncingScrollPhysics(),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        PassModel.passList.length,
                        (index) {
                          return PassSelector(
                            pass: PassModel.passList[index],
                            selectedCount:
                                selectedPass[PassModel.passList[index].id]!,
                            onAdd: () {
                              _addPass(PassModel.passList[index].id);
                              calculateTotalPrice();
                            },
                            onMinus: () {
                              _removePass(PassModel.passList[index].id);
                              calculateTotalPrice();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          CheckoutDraggableSheet(
            totalPrice: _totalPrice,
            selectedPass: selectedPass,
          ),
          // top bar
          Container(
            width: double.infinity,
            //height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
            child: SafeArea(
                bottom: false,
                right: false,
                left: false,
                child: _getTitleView(
                  isMultipleLocalizationt: isMultipleLocalization,
                  size: size,
                  localizations: localizations,
                )),
          ),
        ],
      ),
    );
  }

  Widget _getTitleView({
    required bool isMultipleLocalizationt,
    required Size size,
    required List<LocalizationModel> localizations,
  }) {
    if (isMultipleLocalizationt) {
      return Row(
        children: [
          Expanded(
            child: AppText.medium(
              '${DateFormat('EEE dd MMM. yyyy \u2022', 'fr_FR').format(
                _selectedLocalization.dateEvent,
              )}  ${_selectedLocalization.starttimeEvent} à ${_selectedLocalization.endtimeEvent} GMT',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
          ),
          Gap(5),
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 1,
              vertical: 1,
            ),
            decoration: BoxDecoration(
              color: Palette.primaryColor.withOpacity(1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/calendrier-horloge.svg',
                //color: Palette.primaryColor,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () => Functions.showSimpleBottomSheet(
                ctxt: context,
                widget: Container(
                  height: size.height * 0.34,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: _dateSelectorWidget(localizations: localizations),
                ),
              ).whenComplete(() {
                setState(() {});
              }),
            ),
          )
        ],
      );
    }

    return AppText.medium(
      '${DateFormat('EEE. dd MMM. yyyy \u2022', 'fr_FR').format(
        _selectedLocalization.dateEvent,
      )}  ${_selectedLocalization.starttimeEvent} - ${_selectedLocalization.endtimeEvent} GMT',
      fontSize: 16,
      fontWeight: FontWeight.w300,
      textAlign: TextAlign.center,
    );
  }

  Column _dateSelectorWidget(
          {required List<LocalizationModel> localizations}) =>
      Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: List.generate(
                    localizations.length,
                    (index) {
                      String title =
                          '${DateFormat('EEE dd MMM. yyyy \u2022 ', 'fr_FR').format(
                        localizations[index].dateEvent,
                      )}  ${localizations[index].starttimeEvent} à ${localizations[index].endtimeEvent} GMT';
                      String subtitle = localizations[index].place;
                      return IconRow(
                        icon: CupertinoIcons.calendar,
                        title: title,
                        subtitle: subtitle,
                        onTap: () {
                          //print(index);

                          _selectedIndex = index;
                          _selectedLocalization = localizations[_selectedIndex];

                          /*  print(_selectedLocalization.place);
                          print('object'); */
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Container _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: Palette.separatorColor,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          AppText.medium(
            'Date et lieu',
            fontSize: 18,
            fontWeight: FontWeight.w500,
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
    );
  }
}
