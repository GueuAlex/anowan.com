import 'package:flutter/cupertino.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

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
