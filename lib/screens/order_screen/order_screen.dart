import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/model/localization_model.dart';
import 'package:ticketwave/screens/single_event_screen/widgets/icon_row.dart';

import '../../config/app_text.dart';
import '../../model/event_model.dart';
import '../../model/pass_model.dart';
import '../../providers/providers.dart';
import '../../widgets/app_bar_leading.dart';
import 'widgets/checkout_draggable_sheet.dart';
import 'widgets/pass_selector.dart';
import 'widgets/sheet_header.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static String routeName = 'order_screen';
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  int _selectedIndex = 0;
  Map<int, int> selectedPass = {};
  LocalizationModel? _selectedLocalization;

  // int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePasses();
      _updateSelectedLocalization();
      ref.read(selectedEventProvider.notifier).state =
          ModalRoute.of(context)!.settings.arguments as EventModel;
    });
  }

  // Initialize selected passes
  void _initializePasses() {
    final _event = ModalRoute.of(context)!.settings.arguments as EventModel;
    final selectedPassMap = ref.read(selectedPassProvider.notifier);

    Map<int, int> initialPassSelection = {};
    for (var pass in _event.passes ?? []) {
      initialPassSelection[pass.id] = 0;
    }
    selectedPassMap.state = initialPassSelection;
  }

  // Add pass and update total price
  void _addPass(int passId, List<PassModel> passes) {
    final selectedPassMap = ref.read(selectedPassProvider.notifier);
    final totalPriceNotifier = ref.read(totalPriceProvider.notifier);

    selectedPassMap.state = {
      ...selectedPassMap.state,
      passId: selectedPassMap.state[passId]! + 1,
    };

    _calculateTotalPrice(
        passes: passes, totalPriceNotifier: totalPriceNotifier);
  }

  // Remove pass and update total price
  void _removePass(int passId, List<PassModel> passes) {
    final selectedPassMap = ref.read(selectedPassProvider.notifier);
    final totalPriceNotifier = ref.read(totalPriceProvider.notifier);

    if (selectedPassMap.state[passId]! > 0) {
      selectedPassMap.state = {
        ...selectedPassMap.state,
        passId: selectedPassMap.state[passId]! - 1,
      };

      _calculateTotalPrice(
          passes: passes, totalPriceNotifier: totalPriceNotifier);
    }
  }

  // Calculate total price of selected passes
  void _calculateTotalPrice({
    required List<PassModel> passes,
    required StateController<int> totalPriceNotifier,
  }) {
    int totalPrice = 0;
    final selectedPassMap = ref.read(selectedPassProvider);

    for (var pass in passes) {
      int count = selectedPassMap[pass.id] ?? 0;
      totalPrice += pass.price * count;
    }
    totalPriceNotifier.state = totalPrice;
  }

  // Update the selected localization based on the index
  void _updateSelectedLocalization() {
    final _event = ModalRoute.of(context)!.settings.arguments as EventModel;
    setState(() {
      _selectedLocalization = _event.localizations[_selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final _event = ModalRoute.of(context)!.settings.arguments as EventModel;
    final List<LocalizationModel> localizations = [
      ..._event.localizations,
      ..._event.localizations
    ];

    final List<PassModel> passes = _event.passes ?? [];

    final size = MediaQuery.of(context).size;

    // Watch providers for selected pass and total price
    final selectedPassMap = ref.watch(selectedPassProvider);
    final totalPrice = ref.watch(totalPriceProvider);

    // set the selected event to the state of the provider

    bool isMultipleLocalization = localizations.length > 1;

    if (_selectedLocalization == null && localizations.isNotEmpty) {
      return CircularProgressIndicator(); // Ou un autre widget d'attente
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: AppText.medium(_event.name),
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
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        passes.length,
                        (index) {
                          return PassSelector(
                            pass: passes[index],
                            selectedCount: selectedPassMap[passes[index].id]!,
                            onAdd: () {
                              _addPass(passes[index].id, passes);
                            },
                            onMinus: () {
                              _removePass(passes[index].id, passes);
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

          // Draggable checkout sheet for selected passes and total price
          CheckoutDraggableSheet(
            totalPrice: totalPrice,
            selectedPass: selectedPassMap,
          ),

          // Top bar for localization selector
          Container(
            width: double.infinity,
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
              ),
            ),
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
    String to =
        Functions.stringToTimeOfDay(_selectedLocalization!.starttimeEvent);
    String from =
        Functions.stringToTimeOfDay(_selectedLocalization!.endtimeEvent);
    if (isMultipleLocalizationt) {
      return Row(
        children: [
          Expanded(
            child: AppText.medium(
              '${DateFormat('EEE dd MMM yyyy \u2022', 'fr_FR').format(
                _selectedLocalization!.dateEvent,
              )}  ${to} à ${from} GMT',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
          ),
          Gap(5),
          Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 1,
              vertical: 1,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(162, 225, 225, 225),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: InkWell(
              child: Center(
                child: Icon(
                  CupertinoIcons.calendar,
                ),
              ),
              onTap: () => Functions.showSimpleBottomSheet(
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
        _selectedLocalization!.dateEvent,
      )}  ${_selectedLocalization!.starttimeEvent} - ${_selectedLocalization!.endtimeEvent} GMT',
      fontSize: 16,
      fontWeight: FontWeight.w300,
      textAlign: TextAlign.center,
    );
  }

  Column _dateSelectorWidget(
          {required List<LocalizationModel> localizations}) =>
      Column(
        children: [
          sheetheader(context: context),
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
                      String subtitle = localizations[index].place ?? '';
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
}
