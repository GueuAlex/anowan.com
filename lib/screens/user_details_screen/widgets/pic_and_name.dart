import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../providers/user.provider.dart';
import 'user_profile_pic.dart';

class PicAndName extends ConsumerWidget {
  const PicAndName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Row(
      children: [
        UserProfilePic(),
        Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                '${user.name} ${user.firstname}',
                maxLine: 1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 32, 32, 32),
              ),
              AppText.medium(
                '📬 ${user.email!.isNotEmpty ? user.email : user.phone}',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 80, 80, 80),
                maxLine: 1,
              ),
              AppText.medium(
                '📍${user.favoriteLocation!.isNotEmpty ? user.favoriteLocation : 'Inconnue'}',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 80, 80, 80),
                maxLine: 1,
              )
            ],
          ),
        )
      ],
    );
  }
}
