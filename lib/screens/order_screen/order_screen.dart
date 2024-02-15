import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/model/pass_model.dart';
import 'package:ticketwave/screens/checkout_screen/checkout_screen.dart';
import 'package:ticketwave/widgets/alert_1.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../config/palette.dart';
import '../../widgets/app_bar_leading.dart';
import '../../widgets/customAnimateSlide.dart';

class OrderScreen extends StatefulWidget {
  static String routeName = 'order_screen';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  //////////
  List<PassModel> selectedPass = [];
  ////////////////
  @override
  void initState() {
    PassModel.eventList.sort(
      (a, b) => a.price.compareTo(b.price),
    );
    selectedPass.add(PassModel.eventList.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppText.medium('Abidjan Rhum Festival 2023'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: AppBarLeading(),
      ),
      bottomNavigationBar: CustomeAnimatedSlide(
        child: CheckBottomArea(size: size),
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
                      AppText.medium(
                        '${DateFormat('EEE. dd MMM. yyyy \u2022 HH:mm - 22:00', 'fr_FR').format(
                          DateTime.now(),
                        )} GMT',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
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
                              onAdd: () {
                                print('onAdd');
                              },
                              onMinus: () {
                                print('onMinus');
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

class PassSeclector extends StatelessWidget {
  const PassSeclector({
    super.key,
    required this.pass,
    required this.onAdd,
    required this.onMinus,
  });
  final PassModel pass;
  final VoidCallback onAdd;
  final VoidCallback onMinus;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Palette.primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    AppText.medium(
                      pass.name,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(8),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Palette.secondaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => Functions.showBottomSheet(
                            ctxt: context,
                            widget: PassDecriptionSheet(),
                            size: size),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.question,
                            color: Palette.secondaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  AddButton(
                    color: Palette.primaryColor.withOpacity(0.15),
                    icon: CupertinoIcons.minus,
                    onPressed: onMinus,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: AppText.large('1'),
                  ),
                  AddButton(
                    color: Palette.primaryColor,
                    icon: CupertinoIcons.add,
                    incoColor: Colors.white,
                    onPressed: onAdd,
                  ),
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          AppText.medium(
            '${pass.price} FCFA',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          Gap(8),
          AppText.small(
            'Les ventes se terminent dans un jour',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          )
        ],
      ),
    );
  }
}

class PassDecriptionSheet extends StatelessWidget {
  const PassDecriptionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
            AppText.medium('Description complete de ce pass et ses avantages'),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
    this.incoColor = Colors.grey,
  });
  final Color color;
  final Color incoColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Icon(
            icon,
            color: incoColor,
          ),
        ),
      ),
    );
  }
}

class CheckBottomArea extends StatelessWidget {
  const CheckBottomArea({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: 1,
      width: size.width,
      decoration: BoxDecoration(
        color: Palette.greyColor.withOpacity(0.03),
        border: Border(
          top: BorderSide(
            width: 2,
            color: Palette.greyColor.withOpacity(0.2),
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Alert1(alert: 'Bientôt epuisé !'),
                  //Gap(15),

                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    //width: 150,
                    child: AppText.medium('2000 FCFA'),
                  ),
                ],
              ),
              Gap(8),
              CustomButton(
                color: Palette.primaryColor,
                width: double.infinity,
                height: 35,
                radius: 5,
                text: 'Commander',
                onPress: () => Navigator.pushNamed(
                  context,
                  CheckoutScreen.routeName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
