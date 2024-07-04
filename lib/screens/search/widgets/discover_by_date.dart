import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import 'custom_date_picker.dart';

class DiscoversByDate extends StatefulWidget {
  const DiscoversByDate({
    super.key,
  });

  @override
  State<DiscoversByDate> createState() => _DiscoversByDateState();
}

class _DiscoversByDateState extends State<DiscoversByDate> {
  String? selectedDateRange;

  String getToday() {
    // le tag au "aujourd'huit" doit executer cette fonction
    final today = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(today);
  }

  String getTomorrow() {
    // le tag au "demain" doit executer cette fonction
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return DateFormat('yyyy-MM-dd').format(tomorrow);
  }

  String getThisWeekend() {
    // le tag au "ce weekend" doit executer cette fonction
    final today = DateTime.now();
    final saturday = today.add(Duration(days: 6 - today.weekday));
    final sunday = saturday.add(Duration(days: 1));
    return "${DateFormat('yyyy-MM-dd').format(saturday)} - ${DateFormat('yyyy-MM-dd').format(sunday)}";
  }

  Future<void> pickDateRange(BuildContext context) async {
    // le tag au "choisir la date" doit executer cette fonction
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDateRange =
            "${DateFormat('yyyy-MM-dd').format(picked.start)} - ${DateFormat('yyyy-MM-dd').format(picked.end)}";
      });
    }
  }

  void _onTagTap(String tag) {
    String result;
    switch (tag) {
      case 'Aujourd\'huit':
        {
          result = getToday();
          print(result);
          ;
        }

        break;
      case 'Demain':
        result = getTomorrow();
        break;
      case 'Ce weekend':
        result = getThisWeekend();
        break;
      case 'Choisir la date':
        showCustomDateRangePicker(context);
        return;
      default:
        result = 'All upcoming';
    }
    setState(() {
      selectedDateRange = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AppText.medium(
            'Découvrir des évènements par date',
            fontSize: (size.width * 0.042),
            fontWeight: FontWeight.w500,
          ),
        ),
        // affichage des tags
        // affichage des tags
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            buildTag('Aujourd\'huit'),
            buildTag('Demain'),
            buildTag('Ce weekend'),
            buildTag('Choisir la date'),
            buildTag('All upcoming'),
          ],
        ),
      ],
    );
  }

  Widget buildTag(String label) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Palette.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => _onTagTap(label),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.medium(
              label,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            Gap(5),
            Icon(
              FluentIcons.chevron_right_12_regular,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
