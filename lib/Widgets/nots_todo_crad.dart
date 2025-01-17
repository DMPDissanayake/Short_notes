import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/text_style.dart';

class NotsTodoCrad extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const NotsTodoCrad({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<NotsTodoCrad> createState() => _NotsTodoCradState();
}

class _NotsTodoCradState extends State<NotsTodoCrad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: AppTextStyles.appDescription,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              widget.description,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
