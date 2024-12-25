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
    //required this.isThirdParty,
    required this.userName,
    required this.userFirstname,
    this.userEmail,
    required this.userPhone,
  });
  final String userName;
  final String userFirstname;
  final String? userEmail;
  final String userPhone;
  //final bool isThirdParty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // providers
    final event = ref.watch(selectedEventProvider);
    //final thirdPart = ref.watch(thirdPartyProvider);
    final operator = ref.watch(selectedOperatorProvider);
    final selectedCountry = ref.watch(selectedCountryProvider);
    final selectedPass = ref.watch(selectedPassProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final user = ref.watch(userProvider);
    final selectedTickets = ref.watch(selectedTickedProvider) ?? [];
    int smsFees = 0;
    for (var ticket in selectedTickets) {
      if (ticket.thirdParty != null &&
          (ticket.thirdParty!.recepient == 'SMS' ||
              ticket.thirdParty!.recepient == 'Les deux')) {
        smsFees += 100;
      }
    }
    print(smsFees);

    final int tva =
        int.parse((0.01 * (totalPrice + smsFees)).round().toString());
    int total = totalPrice + tva + smsFees;

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
                    columnTitle: selectedTickets.length == 1
                        ? 'VOTRE BILLET'
                        : 'VOS BILLETS',
                    columnValue: formatSelectedPasses(
                      passes: event!.passes ?? [],
                      selectedPass: selectedPass,
                    ),
                  ),
                  /*   if (thirdPart != null)
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
                      ), */
                  checkoutRowInfos(
                    title: 'SMS',
                    columnTitle: '$smsFees ₣',
                    columnValue: 'Frais d\'envoi de sms',
                  ),
                  checkoutRowInfos(
                    title: 'TVA/HT',
                    columnTitle: '$tva ₣',
                    columnValue: 'Frais de transaction',
                  ),
                  checkoutRowInfos(
                    title: 'TOTAL',
                    columnTitle:
                        '${Functions.numberFormat(total.toString())} ₣',
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
                isSetting: true,
                fontsize: 14,
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

                    for (int i = 0; i < value; i++) {
                      tickets.add({
                        'event_id': event.id,
                        'order_id': order['id'], // À revoir selon votre logique
                        'pass_id': key,
                        'participant_id': user != null ? user.id : null,
                      });
                    }
                  });
                  print(tickets);
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

var orderData = {
  "user_auth":
      true, // toujours true ? (je sais pas à quoi ça sert, tu va m'expliquer)
  "participant_id":
      null, // null si le user n'est pas connecté et non null s'il est connecté (peu import s'il achete pour lui même ou pour quelqu'un d'autre)
  "event_id": 1, // l'id de l'event concerné
  "amount_ht":
      000, // je crois que c'est le montant hors taxes mais j'aurai besoin de comprendre certaines choses (genrs à quel moment y'a des taxes).
  "sms_quantity": 00, // quantité des sms ? besoin de clarification
  "fees": 00, // frais de quoi ?
  "sms_fees": 00, // frais des sms comment c'est calculé ?
  "amount": 000, // montant total de la commande (fees + amount_ht + sms_fees)
  "comments": null, // commentaires du client,
  "tickets": [
    // il peut  avoir plusieurs selection du même pass ou de pass différents alors tickets[] représente ula liste de ces selections
    {
      "pass_id": 1, // l'id du pass selectionné
      "send_to": {
        // send to: null si le user connecté achète pour lui même ou null s'il a décider de ne pas envoyer à qqn (dans ce cas c'est pour lui meme).
        "first_name": "Koffi",
        "last_name": "Jean Paul",
        "phone": "07890000000", // nullable en fonction du choix d'envoi
        "email": "example@gmail.com", // nullable en fonction du choix d'envoi
        "will_receive_by_phone":
            true, // si le user a choisi de transmettre le ticket par sms,
        "will_receive_by_email":
            true, // s'il à choisi de transmettre par email.
        "both": true, // s'il à choisi de transmettre par sms et phone.
      },
    },
    {
      "pass_id": 1, // l'id du pass selectionné
      "send_to":
          null // send to: null si le user connecté achète pour lui même ou null s'il a décider de ne pas envoyer à qqn (dans ce cas c'est pour lui meme).,
    },
    {
      "pass_id": 2, // l'id du pass selectionné
      "send_to": {
        //// send to: null si le user connecté achète pour lui même ou null s'il a décider de ne pas envoyer à qqn (dans ce cas c'est pour lui meme).
        "first_name": "N'DRI",
        "last_name": "Mireille",
        "phone": "07890000000", // nullable en fonction du choix d'envoi
        "email": "example@gmail.com", // nullable en fonction du choix d'envoi
        "will_receive_by_phone":
            true, // si le user a choisi de transmettre le ticket par sms,
        "will_receive_by_email":
            true, // s'il à choisi de transmettre par email.
        "both": true, // s'il à choisi de transmettre par sms et phone.
      },
    }
    // etc ...
  ]
};
