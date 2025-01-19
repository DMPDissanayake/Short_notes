import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/text_style.dart';

class NotesCard extends StatelessWidget {
  final String catecatagory;
  final int noOfNotes;

  const NotesCard({
    super.key,
    required this.catecatagory,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            catecatagory,
            style: AppTextStyles.appSubtitle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$noOfNotes Notes",
            style: AppTextStyles.appBody.copyWith(
              color: AppColors.kWhiteColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
