import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/remote_service/remote_service.dart';
import 'package:ticketwave/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/pass_model.dart';
import '../../../model/third_party_model.dart';
import '../../../providers/providers.dart';
import '../../../providers/user.provider.dart';
import '../om/om_otp_screen.dart';
import 'checkout_row_infow.dart';

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
    final totalHt = ref.watch(totalPriceProvider);
    final user = ref.watch(userProvider);
    final selectedTickets = ref.watch(selectedTickedProvider) ?? [];
    final selectedRecepient = ref.watch(selectedRecepientProvider);
    int smsFees = 0;
    int smsQuantity = 0;
    String commandType = 'TICKET';

    /// create participant
    ThirdPartyModel participant = ThirdPartyModel(
      name: userName,
      firstname: userFirstname,
      recepient: user == null ? selectedRecepient : '',
      phone: userPhone,
      email: userEmail,
      zipcode: selectedCountry!.zipCode,
    );

    //
    for (var ticket in selectedTickets) {
      if (ticket.thirdParty == null) {
        ticket.thirdParty = participant;
      }
      if (ticket.thirdParty!.recepient == 'SMS' ||
          ticket.thirdParty!.recepient == 'Les deux') {
        smsFees += 100;
        smsQuantity += 1;
        commandType = 'SMS';
      }
    }

    /*    for (var ticket in selectedTickets) {
      if (ticket.thirdParty != null &&
          (ticket.thirdParty!.recepient == 'SMS' ||
              ticket.thirdParty!.recepient == 'Les deux')) {
        smsFees += 100;
        smsQuantity += 1;
        commandType = 'SMS';
      }
    } */
    //             print(smsFees);

    final int tva = int.parse((0.01 * (totalHt + smsFees)).round().toString());
    int total = totalHt + tva + smsFees;

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
                    columnValue: '+${selectedCountry.zipCode} $userPhone',
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
                onPress: () async {
                  if (operator == null) {
                    Functions.showToast(
                      msg: 'Veuillez sélectionner un opérateur !',
                    );
                    return;
                  }

                  EasyLoading.show();
                  print(operator.methodName);

                  final orderData = {
                    "user_auth": user != null,
                    "participant_id": user != null ? user.id : null,
                    "event_id": event.id,
                    "amount_ht": totalHt,
                    "sms_quantity": smsQuantity,
                    "fees": tva,
                    "sms_fees": smsFees,
                    "amount": total,
                    "comments": '',
                    // participant data
                    "participant":
                        user == null ? formatParticipant(participant) : null,
                    // transaction data
                    "transaction_phone": userPhone,
                    "payment_method": operator.methodName,
                    "command_type": commandType,
                    // tickets data
                    "tickets": formatTickets(selectedTickets),
                  };

                  print(orderData);
                  EasyLoading.dismiss();

                  return;

                  try {
                    final r = await RemoteService()
                        .postSomethings(api: 'orders', data: orderData)
                        .timeout(const Duration(minutes: 1));

                    if (r.statusCode == 200 || r.statusCode == 201) {
                      final json = jsonDecode(r.body);
                      String orderCode =
                          json['data']['order_unique_code'].toString();
                      String transaId =
                          json['data']['order_unique_code'].toString();

                      final callback = dotenv.env['CALLBACK_URL']!;

                      Map<String, dynamic> checkoutData = {
                        "idFromClient": transaId,
                        "additionnalInfos": {
                          "recipientEmail": userEmail,
                          "recipientFirstName": userFirstname,
                          "recipientLastName": userName,
                          "destinataire": userPhone, //???
                          "otp": null
                        },
                        "amount": total,
                        "callback": callback,
                        "recipientNumber": userPhone,
                        "serviceCode": _getServiceCode(operator.methodName)
                      };

                      if (operator.methodName == 'OM') {
                        EasyLoading.dismiss();
                        Navigator.pushNamed(
                          context,
                          OmOtpScreen.routeName,
                          arguments: checkoutData,
                        );
                        return;
                      }
                      //WAVE checkout process
                      if (operator.methodName == 'WALLET') {
                        final appBase = dotenv.env['APP_BASE']!;
                        String returnUrl =
                            "${appBase}orders/$orderCode/payment?initiation_id=$transaId";
                        String errorUrl =
                            "${appBase}orders/$orderCode/sms-cancelled";
                        Map<String, dynamic> checkout_params = {
                          "client_reference": transaId,
                          "amount": total,
                          "currency": "XOF",
                          "error_url": event.free ? errorUrl : returnUrl,
                          "success_url": returnUrl,
                        };
                        final wavetoken = dotenv.env['WAVE_AUTH']!;
                        final wr = await RemoteService().postSomethings(
                          api: '',
                          url: 'https://api.wave.com/v1/checkout/sessions',
                          data: checkout_params,
                          token: wavetoken,
                        );
                        if (wr.statusCode == 200 || wr.statusCode == 201) {
                          final json = jsonDecode(wr.body);
                          String url = json["wave_launch_url"];
                          EasyLoading.dismiss();
                          Functions.launchUri(url: url);
                          return;
                        } else {
                          EasyLoading.dismiss();
                          Functions.showToast(
                              msg: 'Veuillez réessayer plus tard.');
                          return;
                        }
                      }
                      EasyLoading.dismiss();
                    } else {
                      EasyLoading.dismiss();
                      Functions.showToast(
                          msg:
                              'Erreur : ${r.statusCode}. Veuillez réessayer plus tard.');
                    }
                  } on TimeoutException {
                    EasyLoading.dismiss();
                    Functions.showToast(
                        msg:
                            'Temps de connexion dépassé. Vérifiez votre connexion internet.');
                  } on SocketException {
                    EasyLoading.dismiss();
                    Functions.showToast(
                        msg:
                            'Pas de connexion Internet. Vérifiez votre réseau.');
                  } catch (e) {
                    EasyLoading.dismiss();
                    Functions.showToast(
                        msg: 'Une erreur s\'est produite. Veuillez réessayer.');
                    debugPrint('Erreur: $e');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Map<String, dynamic> formatParticipant(ThirdPartyModel participant) {
    return {
      "first_name": participant.name,
      "last_name": participant.firstname,
      "phone": participant.phone,
      "email": participant.email,
      "zip_code": participant.zipcode,
      /*  "will_receive_by_phone": participant.recepient.contains("SMS"),
      "will_receive_by_email": participant.recepient.contains("E-mail"),
      "both": participant.recepient == "Les deux", */
    };
  }

//////// Fonction pour formater les données des tickets
  List<Map<String, dynamic>> formatTickets(
      List<SelectedTickeModel> selectedTickets) {
    return selectedTickets.map((ticket) {
      return {
        "pass_id": ticket.passId,
        "send_to": ticket.thirdParty != null
            ? {
                "first_name": ticket.thirdParty!.name,
                "last_name": ticket.thirdParty!.firstname,
                "phone": ticket.thirdParty!.phone,
                "email": ticket.thirdParty!.email,
                "zip_code": '+${ticket.thirdParty!.zipcode}',
                "will_receive_by_phone":
                    ticket.thirdParty!.recepient.contains("SMS"),
                "will_receive_by_email":
                    ticket.thirdParty!.recepient.contains("E-mail"),
                "both": ticket.thirdParty!.recepient == "Les deux",
              }
            : null, // Si le ticket est pour l'utilisateur lui-même
      };
    }).toList();
  }

  _getServiceCode(methodName) {
    switch (methodName) {
      case 'OM':
        return dotenv.env['OM_SERVICE_CODE']!;
      case 'MOMO':
        return dotenv.env['MTN_SERVICE_CODE']!;
      case 'FLOOZ':
        return dotenv.env['MOOV_SERVICE_CODE']!;
      case 'WALLET':
        return dotenv.env['WAVE_SERVICE_CODE']!;
      default:
        return dotenv.env['OM_SERVICE_CODE']!;
    }
  }

  Future<void> createTouchPointCheckoutSession({
    required Map<String, dynamic> data,
  }) async {
    debugPrint('transaction started');
    final agencyCode = dotenv.env['TOUCHPOINT_AGENCY_CODE']!;
    final loginAgent = dotenv.env['TOUCHPOINT_LOGIN_AGENT']!;
    final passwordAgent = dotenv.env['TOUCHPOINT_PASSWORD_AGENT']!;
    final username = dotenv.env['TOUCHPOINT_USERNAME']!;
    final password = dotenv.env['TOUCHPOINT_PASSWORD']!;

    final url =
        "https://apidist.gutouch.net/apidist/sec/touchpayapi/$agencyCode/transaction?loginAgent=$loginAgent&passwordAgent=$passwordAgent";
    var headers = {
      'Origin':
          'https://custom-origin.com', // Définir une origine personnalisée
      'Content-Type': 'application/json',
      'Authorization':
          'Basic ${base64Encode(utf8.encode('$username:$password'))}',
    };
    // try {
    print(data);
    print(url);
    print(headers);

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    /* .timeout(const Duration(minutes: 1)); */

    print('operation status code: ${response.statusCode}');
    print('operation status code: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('Transaction successful: $responseData');
    } else {
      print('Transaction failed: ${response.statusCode} - ${response.body}');
    }
    /*  } catch (e) {
      print('Error occurred: $e');
    } */
  }

/*   Future<String?> createTransaction({
    required String orderCode,
    required int amount,
    required String phone,
  }) async {
    try {
      Map<String, dynamic> transactionData = {
        "amount": amount,
        "transaction_phone": phone,
        "status": "INITIATED", // ------
        "payment_date": DateTime.now().toIso8601String(),
        "command_id": orderCode,
        "command_type": "string",
        "transaction_id": "string",
        "payment_method": "string",
        "description": "string",
        "currency": "string",
        "payable_id": "number",
        "payable_type": "string",
        "customer_country": "string"
      };
      final tr = await RemoteService()
          .postSomethings(api: 'transactions', data: transactionData)
          .timeout(const Duration(seconds: 30));

      EasyLoading.dismiss();

      if (tr.statusCode == 200 || tr.statusCode == 201) {
        final json = jsonDecode(tr.body);
        return json['unique_code'].toString();
      } else {
        Functions.showToast(msg: 'Erreur Veuillez réessayer plus tard.');
        return null;
      }
    } on TimeoutException {
      EasyLoading.dismiss();
      Functions.showToast(
          msg:
              'Temps de connexion dépassé. Vérifiez votre connexion internet.');
    } on SocketException {
      EasyLoading.dismiss();
      Functions.showToast(
          msg: 'Pas de connexion Internet. Vérifiez votre réseau.');
    } catch (e) {
      EasyLoading.dismiss();
      Functions.showToast(
          msg: 'Une erreur s\'est produite. Veuillez réessayer.');
      debugPrint('Erreur: $e');
    }
    return null;
  } */
}
