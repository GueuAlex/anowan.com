import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../providers/user.provider.dart';
import '../../user_details_screen/user_details_screen.dart';

Widget profilLogo({required BuildContext context, required WidgetRef ref}) {
  final user = ref.watch(userProvider);
  if (user == null) return const SizedBox();
  return Container(
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    //padding: const EdgeInsets.all(3),
    width: 35,
    height: 35,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Palette.primaryColor.withOpacity(0.3),
      border: Border.all(
        width: 2,
        color: Palette.primaryColor.withOpacity(0.6),
      ),
    ),
    child: InkWell(
      onTap: () => Navigator.of(context).pushNamed(UserDetailsScreen.routeName),
      child: Center(
        child: AppText.large(
          '${user.name[0]}',
          fontSize: 21.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
