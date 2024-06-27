import 'package:flutter/material.dart';
import 'package:nutrisee/core/data/model/task_day/task_day.dart';
import 'package:nutrisee/core/utils/datetime_extension.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class ItemDay extends StatefulWidget {
  final TaskDay data;
  const ItemDay({super.key, required this.data});

  @override
  State<ItemDay> createState() => _ItemDayState();
}

class _ItemDayState extends State<ItemDay> {
  @override
  Widget build(BuildContext context) {
    String todayDate = DateTime.now().dateFormat('DD');
    String todaySelected = DateTime.now().dateFormat('yyyy-MM-dd');
    Color bgDate;
    Color textDate;
    bool useBorder = false;
    if (widget.data.selected == true ||
        widget.data.date.toString() == todaySelected) {
      useBorder = true;
    }

    if (widget.data.date.dateFormat('EEE') == 'Sun') {
      bgDate = Colors.redAccent;
      textDate = Colors.red;
    } else if (widget.data.date.dateFormat('EEE') == 'Sat') {
      bgDate = Colors.yellowAccent;
      textDate = Colors.yellow;
    } else if (widget.data.date.dateFormat('DD') == todayDate) {
      bgDate = Colors.greenAccent;
      textDate = Colors.green;
    } else {
      bgDate = Colors.blueGrey;
      textDate = Colors.black;
    }

    return Container(
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgDate,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: useBorder ? AppColors.textBlack : Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.data.date.dateFormat('EEE'),
            style: context.textTheme.bodyMedium?.copyWith(
              color: textDate,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.data.date.dateFormat('dd'),
            style: context.textTheme.bodyLarge?.copyWith(
              color: textDate,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
