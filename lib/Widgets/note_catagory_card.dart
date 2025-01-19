import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/text_style.dart';

class NoteCatagoryCard extends StatelessWidget {
  final String title;
  final String description;

  final Future Function() editNote;
  final Future Function() removeNote;

  const NoteCatagoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.editNote,
    required this.removeNote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: editNote,
                  icon: Icon(
                    Icons.edit,
                    size: 25,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: removeNote,
                  icon: Icon(
                    Icons.delete,
                    size: 25,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Text(
              title,
              maxLines: 1, // Limits text to a single line
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.appSubtitle,
            ),
            Text(
              description,
              maxLines: 5, // Limits text to a 5
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
