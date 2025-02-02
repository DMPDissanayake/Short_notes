import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/text_style.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String data;
  final String time;
  final bool isDone;
  const HomeCard({
    super.key,
    required this.title,
    required this.data,
    required this.time,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kCardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.appSubtitle.copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "${DateFormat.yMMMMd().format(DateTime.parse(data))} ${DateFormat.Hm().format(DateTime.parse(time))}",
                style: AppTextStyles.appDescriptionSmall.copyWith(
                  fontSize: 15,
                  color: AppColors.kWhiteColor.withOpacity(0.4),
                ),
              )
            ],
          ),
          Icon(
            isDone ? Icons.done_all : Icons.done,
            color: isDone ? AppColors.kFabColor : Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
