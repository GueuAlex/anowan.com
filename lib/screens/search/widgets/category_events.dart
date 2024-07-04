import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:ticketwave/widgets/envent_card_column.dart';

import '../../../config/app_text.dart';
import '../../../model/category_model.dart';

Widget categoryEvents({
  required String category,
  required Size size,
  required BuildContext context,
}) {
  CategoryModel? _category = CategoryModel.categories.firstWhereOrNull(
    (c) => c.libelle == category,
  );

  if (_category != null && _category.events.length > 0) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.small(
          _category.libelle,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        //AppText.small(_),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _category.events
                .map(
                  (event) => eventCardColumn(
                    event: event,
                    size: size,
                    context: context,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  return Container();
}
