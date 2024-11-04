import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import 'sheet_header.dart';

class PassDecriptionSheet extends StatelessWidget {
  const PassDecriptionSheet({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sheetheader(context: context, text: 'Description'),
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: AppText.medium(
                    description,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
