import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

import '../config/functions.dart';
import '../config/palette.dart';
import '../model/event_model.dart';
import '../providers/user.provider.dart';
import 'login_sheet.dart';

class AddForiteButton extends ConsumerWidget {
  const AddForiteButton({
    super.key,
    required this.event,
  });
  final EventModel event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return GestureDetector(
      onTap: () async {
        if (user == null) {
          await Functions.showSimpleBottomSheet(
            ctxt: context,
            widget: LoginSheet(
              text:
                  'Créer un pour ajouter des évènements à vos favorits et retrouver facilement vos évènements préférés.',
            ),
          );
          return;
        }
        // EasyLoading.show();
        if (event.isBookmarked(ref))
          return await ref
              .read(userProvider.notifier)
              .removeBookmarkedEvent(event.id.toString());

        return await ref
            .read(userProvider.notifier)
            .addBookmarkedEvent(event.id.toString());
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Palette.blackColor.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: event.isBookmarked(ref)
              ? Icon(
                  CupertinoIcons.bookmark_fill,
                  color: Palette.appRed,
                  size: 20,
                )
              : Icon(
                  CupertinoIcons.bookmark,
                  color: Palette.whiteColor,
                  size: 20,
                ),
        ),
      ),
    );
  }
}
