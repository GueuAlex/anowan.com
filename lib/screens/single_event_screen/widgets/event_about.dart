import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';

class EventAbout extends StatelessWidget {
  const EventAbout({
    super.key,
    required this.html,
    required this.shortHtml,
  });
  final String html;
  final String shortHtml;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            'A propos de cet événement',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Gap(12),
          HtmlWidget(
            shortHtml,
            renderMode: RenderMode.column,
            textStyle: TextStyle(fontSize: 14),
          ),
          Gap(8),
          InkWell(
            onTap: () => _showFullDescriptio(
              context: context,
              html: html,
            ),
            child: AppText.medium(
              'En savoir plus',
              color: Palette.appRed,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  void _showFullDescriptio(
      {required BuildContext context, required String html}) {
    Functions.showSimpleBottomSheet(
      ctxt: context,
      widget: FullDescriptionBottomSheet(
        description: html,
      ),
    );
  }
}

class FullDescriptionBottomSheet extends StatelessWidget {
  const FullDescriptionBottomSheet({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: HtmlWidget(
                  description,
                  renderMode: RenderMode.column,
                  textStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          //écrir une phrase attrayante et accrocheur
          Container(
            width: double.infinity,
            color: Colors.grey.withOpacity(0.15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SafeArea(
              child: CustomButton(
                color: Palette.appRed,
                width: double.infinity,
                height: 45,
                radius: 3,
                text: 'Ok',
                onPress: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: Palette.separatorColor,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          AppText.medium(
            'A propos de cet événement',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.xmark,
                  color: Color.fromARGB(255, 20, 20, 20),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
