import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/functions.dart';
import '../config/palette.dart';
import '../model/event_model.dart';
import '../providers/user.provider.dart';
import 'login_sheet.dart';

class BookmarkEvent extends ConsumerWidget {
  const BookmarkEvent({
    super.key,
    required this.event,
    this.size = 20,
  });
  final EventModel event;
  final double size;

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
      child: event.isBookmarked(ref)
          ? Icon(
              CupertinoIcons.bookmark_fill,
              color: Palette.appRed,
              size: size,
            )
          : Icon(
              CupertinoIcons.bookmark,
              color: const Color.fromARGB(
                255,
                105,
                105,
                105,
              ),
              size: size,
            ),
    );
  }
}
