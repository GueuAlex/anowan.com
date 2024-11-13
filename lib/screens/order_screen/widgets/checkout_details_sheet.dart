import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/pass_model.dart';
import '../../../providers/providers.dart';
import '../../../providers/user.provider.dart';

class CheckoutDetailsSheet extends ConsumerWidget {
  const CheckoutDetailsSheet({
    super.key,
    required this.isThirdParty,
    required this.userName,
    required this.userFirstname,
    this.userEmail,
    required this.userPhone,
  });
  final String userName;
  final String userFirstname;
  final String? userEmail;
  final String userPhone;
  final bool isThirdParty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // providers
    final event = ref.watch(selectedEventProvider);
    final thirdPart = ref.watch(thirdPartyProvider);
    final operator = ref.watch(selectedOperatorProvider);
    final selectedCountry = ref.watch(selectedCountryProvider);
    final selectedPass = ref.watch(selectedPassProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final user = ref.watch(userProvider);

    final int tva = int.parse((0.01 * totalPrice).toStringAsFixed(0));
    int total = 0;
    if (thirdPart != null) {
      if (thirdPart.recepient == 'SMS' || thirdPart.recepient == 'Les deux') {
        total = totalPrice + tva + 100;
      } else {
        total = totalPrice + tva;
      }
    } else {
      total = totalPrice + tva;
    }

    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 247, 247),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Palette.separatorColor,
                  width: 0.8,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.rotate(
                      angle: 0,
                      child: SvgPicture.asset(
                        'assets/icons/le-recu.svg',
                        width: 16,
                        height: 16,
                      ),
                    ),
                    Gap(3),
                    AppText.medium(
                      'Votre commande',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.zero,
                    ),
                  ),
                  child: AppText.medium(
                    'Annuler',
                    fontWeight: FontWeight.w700,
                    color: Palette.appRed,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  checkoutRowInfos(
                    isAsset: true,
                    title: operator != null
                        ? operator.assetPath
                        : 'assets/images/anowan-placeholder.png',
                    columnTitle: 'NUMÉRO DE PAIEMENT',
                    columnValue: '+${selectedCountry!.zipCode} $userPhone',
                  ),
                  checkoutRowInfos(
                    title: 'CONTACT',
                    columnTitle: '${userName} ${userFirstname}',
                    columnValue: '${userEmail ?? ''}',
                  ),
                  checkoutRowInfos(
                    title: 'ACHAT',
                    columnTitle: 'VOS PASSES',
                    columnValue: formatSelectedPasses(
                      passes: event!.passes ?? [],
                      selectedPass: selectedPass,
                    ),
                  ),
                  if (thirdPart != null)
                    if (thirdPart.recepient == 'Les deux')
                      checkoutRowInfos(
                        title: 'ENVOYÉ À',
                        columnTitle: '${thirdPart.name} ${thirdPart.firstname}',
                        columnValue:
                            'E-mail ${thirdPart.email ?? ''} \u2022 SMS ${thirdPart.phone}',
                      )
                    else
                      checkoutRowInfos(
                        title: 'ENVOYÉ À',
                        columnTitle: '${thirdPart.name} ${thirdPart.firstname}',
                        columnValue: thirdPart.recepient == 'SMS'
                            ? 'SMS ${thirdPart.phone ?? ''}'
                            : 'E-mail ${thirdPart.email ?? ''}',
                      ),
                  if (thirdPart != null)
                    if (thirdPart.recepient == 'Les deux' ||
                        thirdPart.recepient == 'SMS')
                      checkoutRowInfos(
                        title: 'SMS',
                        columnTitle: '100 ₣',
                        columnValue: 'Frais d\'envoi de sms',
                      ),
                  checkoutRowInfos(
                    title: 'TVA/HT',
                    columnTitle: '$tva ₣',
                    columnValue: 'Frais de transaction',
                  ),
                  checkoutRowInfos(
                    title: 'TOTAL',
                    columnTitle: '$total ₣',
                    columnValue: '',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          Gap(20),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CustomButton(
                color: Palette.appRed,
                width: double.infinity,
                height: 40,
                radius: 5,
                text: 'Finaliser la commande',
                onPress: () {
                  // create order
                  Map<String, dynamic> order = {
                    'event_id': event.id,
                    'comments': 'ras',
                    'amount_ht': totalPrice,
                    'ticket_quantity':
                        Functions.calculateTotalTickets(selectedPass),
                    'orderable_id': user != null ? user.id : null,
                  };
                  print(order);

                  /// post order
                  /// then create tickets
                  List<Map<String, dynamic>> tickets = [];
                  selectedPass.forEach((key, value) {
                    print('pass id : $key');
                    print('nombre de tickets : $value');
                    tickets.add({
                      'event_id': event.id,
                      'order_id': order['id'], //////// c'est  a revoir
                      'pass_id': key,
                      'participant_id': user != null ? user.id : null,
                    });
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container checkoutRowInfos({
    required title,
    required String columnTitle,
    required String columnValue,
    bool isAsset = false,
    bool isLast = false,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Palette.separatorColor, width: 0.8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: Container(
                padding: const EdgeInsets.all(6),
                constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
                child: isAsset
                    ? Image.asset(title)
                    : AppText.medium(
                        title,
                        color: Color.fromARGB(255, 137, 141, 150),
                        fontWeight: FontWeight.w700,
                      ),
              ),
            ),
            Expanded(
              child: columnValue.trim().isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          columnTitle.toUpperCase(),
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                          textOverflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 137, 141, 150),
                          fontSize: 14,
                          textAlign: TextAlign.right,
                        ),
                        AppText.small(
                          columnValue,
                          color: Color.fromARGB(255, 62, 65, 71),
                          fontSize: 14,
                        )
                      ],
                    )
                  : AppText.medium(
                      columnTitle,
                      maxLine: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      textAlign: TextAlign.left,
                      color: Color.fromARGB(255, 137, 141, 150),
                    ),
            ),
            SizedBox(
              width: 30,
              child: Icon(
                CupertinoIcons.chevron_right,
                color: Color.fromARGB(255, 125, 124, 124),
                size: 16,
              ),
            ),
          ],
        ),
      );

  // Fonction pour formater la sélection de passes
  String formatSelectedPasses({
    required Map<int, int> selectedPass,
    required List<PassModel> passes,
  }) {
    final List<String> passDescriptions = [];

    for (var pass in passes) {
      int count = selectedPass[pass.id] ?? 0;
      if (count > 0) {
        // Gestion de la grammaire pour le singulier/pluriel
        final passText = count > 1 ? 'tickets' : 'ticket';
        passDescriptions.add('($count) $passText ${pass.name}');
      }
    }

    return passDescriptions.join(' - ');
  }
}
