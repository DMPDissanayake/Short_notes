import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/text_style.dart';

class ProgressCard extends StatefulWidget {
  final int completTask;
  final int totalCompletTask;
  const ProgressCard({
    super.key,
    required this.completTask,
    required this.totalCompletTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    //presentage mark
    double calculationValue = widget.totalCompletTask != 0
        ? (widget.completTask / widget.totalCompletTask) * 100
        : 0;
    return Container(
      padding: EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appSubtitle,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  "You have completed ${widget.completTask} out of ${widget.totalCompletTask} tasks.\nkeep up the progress!",
                  style: AppTextStyles.appDescriptionSmall,
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.21,
                height: MediaQuery.of(context).size.width * 0.21,
                decoration: BoxDecoration(
                  gradient: AppColors().kPrimaryGradient,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  "${calculationValue.toStringAsFixed(0)}%",
                  style: AppTextStyles.appSubtitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
