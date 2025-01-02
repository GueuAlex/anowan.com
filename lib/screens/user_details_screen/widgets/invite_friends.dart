import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Palette.appRed.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Palette.appRed.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          AppText.large(
            'Gagnez un Ticket!',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          SizedBox(height: 8),
          // Subtitle
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              children: [
                TextSpan(text: 'Invitez vos amis à'),
                TextSpan(
                  text: ' télécharger anowan.com',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text:
                        ' et participez à un tirage au sort pour gagner un ticket gratuit pour le prochain événement !'),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Invite Button
          Container(
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
              color: Palette.appRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                // Logique d'invitation
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Anowan logo (remplacer par l'image du logo)
                  Image.asset(
                    'assets/images/anowan-invite-2.png',
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  // Invite Text
                  AppText.medium(
                    'Inviter mes amis dès maintenant',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
