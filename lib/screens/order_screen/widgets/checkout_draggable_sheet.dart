import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/widgets/customAnimateSlide.dart';
import 'package:ticketwave/widgets/custom_button.dart';
import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/pass_model.dart';
import 'checkout_form.dart';
import 'text_midle.dart';

class CheckoutDraggableSheet extends ConsumerStatefulWidget {
  const CheckoutDraggableSheet({
    super.key,
    required this.totalPrice,
    required this.selectedPass,
  });
  final int totalPrice;
  final Map<int, int> selectedPass;

  @override
  _CheckoutDraggableSheetState createState() => _CheckoutDraggableSheetState();
}

class _CheckoutDraggableSheetState
    extends ConsumerState<CheckoutDraggableSheet> {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();
  late double screenHeight;
  bool isMaxHeight = false;
  String _selectedMethod = '';

  //final user = ref.watch(userProvider);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double currentExtent = _scrollController.size;
      double maxExtent = 1.0;
      setState(() {
        isMaxHeight = currentExtent >= maxExtent * 0.8;
      });
    });
  }

  void printSelectedPasses() {
    PassModel.passList.forEach((pass) {
      print(
          'Pour le pass ${pass.id}, voici le nombre sélectionné : ${widget.selectedPass[pass.id] ?? 0}');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Providers

    screenHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 1.0,
      snap: true,
      snapSizes: const [1],
      shouldCloseOnMinExtent: true,
      controller: _scrollController,
      builder: (BuildContext context, scrollSheetController) {
        return Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 0.8,
                color: Palette.separatorColor,
              ),
            ),
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
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            controller: scrollSheetController,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      isMaxHeight ? _maxHeightWidget(size) : _minHeightWidget(),
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

  Widget _minHeightWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 65,
                ),
                child: textMidleLine(),
              ),
              Row(
                children: [
                  Expanded(
                    child: _checkoutMethodContainer(
                      asset: 'assets/icons/carte-cvv.svg',
                      text: 'Carte de crédit',
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: _checkoutMethodContainer(
                      asset: 'assets/icons/echanger.svg',
                      text: 'Mobile Money',
                      isRotated: true,
                    ),
                  )
                ],
              ),
              Gap(10),
              CustomButton(
                color: Palette.appRed,
                width: double.infinity,
                height: 40,
                radius: 5,
                text:
                    'Payer ${Functions.numberFormat(widget.totalPrice.toString())} ₣',
                onPress: _handlePayment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _checkoutMethodContainer({
    required String asset,
    required String text,
    bool isRotated = false,
  }) {
    bool isSelected = _selectedMethod == text;
    return InkWell(
      onTap: () => setState(() {
        _selectedMethod = text;
      }),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.3,
            color: !isSelected ? Palette.separatorColor : Palette.appRed,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isRotated
                    ? SvgPicture.asset(
                        asset,
                        colorFilter: ColorFilter.mode(
                          !isSelected ? Palette.separatorColor : Palette.appRed,
                          BlendMode.srcIn,
                        ),
                      )
                    : Transform.rotate(
                        angle: -0.5,
                        child: SvgPicture.asset(
                          asset,
                          colorFilter: ColorFilter.mode(
                            !isSelected
                                ? Palette.separatorColor
                                : Palette.appRed,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                Icon(
                  FluentIcons.checkmark_circle_16_filled,
                  color: !isSelected ? Palette.separatorColor : Palette.appRed,
                )
              ],
            ),
            Gap(5),
            AppText.medium(
              text,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _maxHeightWidget(Size size) {
    return CustomeAnimatedSlide(
      child: Container(
        margin: EdgeInsets.only(top: kToolbarHeight),
        height: size.height,
        width: double.infinity,
        child: CheckoutForm(
          onCancel: _backToSelection,
        ),
      ),
    );
  }

  void _backToSelection() {
    setState(() {
      isMaxHeight = false;
    });

    _scrollController.animateTo(
      0.35,
      duration: Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }

  void _goToDragableMaxChild() {
    _scrollController.animateTo(
      1,
      duration: Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }

  void _handlePayment() {
    String errorMessage = "";

    if (widget.selectedPass.values.every((count) => count == 0)) {
      errorMessage = "Aucun pass n'est sélectionné.";
    } else if (_selectedMethod.isEmpty) {
      errorMessage = "Aucun moyen de paiement n'est sélectionné.";
    } else if (_selectedMethod == "Carte de crédit") {
      errorMessage = "Carte de crédit est momentanement indisponible.";
    } else {
      _goToDragableMaxChild();
      return;
    }

    // Afficher le message d'erreur
    // Functions.getSnackbar(messageText: errorMessage);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
