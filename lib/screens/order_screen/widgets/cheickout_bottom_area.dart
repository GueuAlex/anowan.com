import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/checkout_method.dart';
import '../../../widgets/custom_button.dart';

class CheckBottomArea extends StatefulWidget {
  const CheckBottomArea({
    super.key,
    required this.size,
    required this.onPress,
    required this.totalPrice,
  });

  final Size size;
  final VoidCallback onPress;
  final int totalPrice;

  @override
  State<CheckBottomArea> createState() => _CheckBottomAreaState();
}

class _CheckBottomAreaState extends State<CheckBottomArea> {
  CheckoutMethod _selectedMethod = CheckoutMethod.checkoutMethods.first;
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: widget.size.height * 0.3,
      width: widget.size.width,
      decoration: BoxDecoration(
        //color: Palette.greyColor.withOpacity(0.03),
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Palette.separatorColor,
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Gap(15),
                  AppText.small('TOTAL'),

                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    //width: 150,
                    child: AppText.medium(
                      '${widget.totalPrice} FCFA',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                    width: 50, height: 2, color: Palette.separatorColor),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: CheckoutMethod.checkoutMethods
                        .map(
                          (e) => _methodButton(e),
                        )
                        .toList(),
                  ),
                  Gap(20),
                  CustomButton(
                    color: Palette.primaryColor,
                    width: double.infinity,
                    height: 35,
                    radius: 5,
                    text: 'Commander',
                    onPress: /* () => Navigator.pushNamed(
                      context,
                      CheckoutScreen.routeName,
                    ), */
                        widget.onPress,
                  ),
                  Gap(10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Powered by',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: ' anowan.com',
                          style: TextStyle(
                            // color: Palette.appRed,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: '\nsecure payment with '),
                        TextSpan(
                          text: 'CinetPay',
                          style: TextStyle(
                            color: Color.fromARGB(255, 4, 109, 67),
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _methodButton(CheckoutMethod e) {
    bool isSelected = _selectedMethod == e;
    return Container(
      width: 70,
      height: 50,
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: isSelected ? Palette.primaryColor : Palette.separatorColor,
            width: 5),
        image: DecorationImage(
          image: AssetImage(e.asset),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = e),
        child: Container(
          color:
              isSelected ? Colors.black.withOpacity(0.2) : Colors.transparent,
        ),
      ),
    );
  }
}
