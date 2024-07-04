import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/model/localization_model.dart';

import '../../config/app_text.dart';
import '../../model/event_model.dart';
import '../../model/pass_model.dart';
import '../../widgets/app_bar_leading.dart';
import '../../widgets/customAnimateSlide.dart';
import 'widgets/cheickout_bottom_area.dart';
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
    PassModel.eventList.sort((a, b) => a.price.compareTo(b.price));
    // Initialiser selectedPass avec des valeurs par défaut (0)
    for (var pass in PassModel.eventList) {
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

  void printSelectedPasses() {
    PassModel.eventList.forEach((pass) {
      print(
          'Pour le pass ${pass.id}, voici le nombre sélectionné : ${selectedPass[pass.id] ?? 0}');
    });
  }

  void calculateTotalPrice() {
    int totalPrice = 0;
    PassModel.eventList.forEach((pass) {
      int count = selectedPass[pass.id] ?? 0;
      totalPrice += pass.price * count;
    });
    print('Total : $totalPrice FCFA');
    //return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    final List<LocalizationModel> localizations = event.localizations;
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedLocalization = localizations[0];
      });
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
      bottomNavigationBar: CustomeAnimatedSlide(
        child: CheckBottomArea(size: size, onPress: calculateTotalPrice),
        // duration: const Duration(seconds: 5),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          AppText.medium(
                            '${DateFormat('EEE. dd MMM. yyyy \u2022 HH:mm - 22:00', 'fr_FR').format(
                              DateTime.now(),
                            )} GMT',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(),
                      ),
                      Column(
                        children: List.generate(
                          PassModel.eventList.length,
                          (index) {
                            return PassSeclector(
                              pass: PassModel.eventList[index],
                              selectedCount:
                                  selectedPass[PassModel.eventList[index].id]!,
                              onAdd: () {
                                _addPass(PassModel.eventList[index].id);
                              },
                              onMinus: () {
                                _removePass(PassModel.eventList[index].id);
                              },
                            );
                          },
                        ),
                      )
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
