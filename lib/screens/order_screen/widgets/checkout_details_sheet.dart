import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/pass_model.dart';
import '../../../model/third_party_model.dart';
import '../../../providers/checkout_state.provider.dart';
import '../../../providers/providers.dart';
import '../../../providers/user.provider.dart';
import '../../../remote_service/remote_service.dart';
import '../../../widgets/custom_button.dart';
import '../om/om_otp_screen.dart';
import 'checkout_row_infow.dart';
import 'checkout_sucess.dart';

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
    // state provider
    final state = ref.watch(checkoutState);
    // state.state = true;

    // final isComplete = ref.watch(checkoutState);

    // print(state.state);
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

    final int tva = int.parse((0.01 * (totalHt + smsFees)).round().toString());
    int total = totalHt + tva + smsFees;

    final size = MediaQuery.of(context).size;

// if checkout completed
    if (state) {
      return CheckoutSucces();
    }
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        /*  borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ), */
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Container(
            width: double.infinity,
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
                  columnTitle: '${Functions.numberFormat(total.toString())} ₣',
                  columnValue: '',
                  isLast: true,
                ),
                Gap(20),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                          "participant": user == null
                              ? formatParticipant(participant)
                              : null,
                          // transaction data
                          "transaction_phone": userPhone,
                          "payment_method": operator.methodName,
                          "command_type": commandType,
                          // tickets data
                          "tickets": formatTickets(selectedTickets),
                        };

                        /* print(orderData);
                    EasyLoading.dismiss();
            
                    return; */

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

                            Map<String, dynamic> checkoutData = {
                              "order_type": commandType,
                              "order_code": orderCode,
                              "phone_number": userPhone,
                              "amount": total,
                              "method_payment": operator.methodName,
                            };

                            //if OM then go otp screen
                            if (operator.methodName == 'OM') {
                              EasyLoading.dismiss();
                              //Navigator.pop(context)
                              Navigator.pushNamed(
                                context,
                                OmOtpScreen.routeName,
                                arguments: checkoutData,
                              );
                              return;
                            }
                            //if WAVE then process by wave checkout
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
                                url:
                                    'https://api.wave.com/v1/checkout/sessions',
                                data: checkout_params,
                                token: wavetoken,
                              );
                              if (wr.statusCode == 200 ||
                                  wr.statusCode == 201) {
                                EasyLoading.dismiss();
                                ref.read(checkoutState.notifier).state = true;
                                final json = jsonDecode(wr.body);
                                String url = json["wave_launch_url"];

                                Functions.launchUri(url: url);
                                return;
                              } else {
                                EasyLoading.dismiss();
                                Functions.showToast(
                                    msg: 'Veuillez réessayer plus tard.');
                                return;
                              }
                            }
                            final res = await RemoteService().postSomethings(
                              api: 'touchpoint/checkout/session',
                              data: checkoutData,
                            );
                            if (res.statusCode == 200 ||
                                res.statusCode == 201) {
                              ref.read(checkoutState.notifier).state = true;
                              EasyLoading.dismiss();
                              return;
                            } else {
                              EasyLoading.dismiss();
                              Functions.showToast(
                                  msg:
                                      'Une erreur s\'est produite. Veuillez réessayer plus tard.');
                              return;
                            }
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
                              msg:
                                  'Une erreur s\'est produite. Veuillez réessayer.');
                          debugPrint('Erreur: $e');
                        }
                      },
                    ),
                  ),
                ),
              ],
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
}
