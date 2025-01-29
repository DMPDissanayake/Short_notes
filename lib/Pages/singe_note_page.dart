import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';

class SingeNotePage extends StatelessWidget {
  final Note note;
  const SingeNotePage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    //set DateTime
    final dateFormat = DateFormat.yMMMd().format(note.date);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Note",
          style: AppTextStyles.appSubtitle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColors.kWhiteColor,
          ),
          onPressed: () {
            AppRouter.router.go("/notes");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              note.title,
              style: AppTextStyles.appTitle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              dateFormat,
              style: AppTextStyles.appDescriptionSmall,
            ),
            Text(
              note.category,
              style: AppTextStyles.appDescription.copyWith(
                fontSize: 18,
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              note.content,
              style: AppTextStyles.appDescription.copyWith(
                fontSize: 18,
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
