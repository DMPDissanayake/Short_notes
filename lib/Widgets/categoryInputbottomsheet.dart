import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/text_style.dart';

class CategoryInputBottomSheet extends StatelessWidget {
  final Function() newNote;
  final Function() newCatagory;
  const CategoryInputBottomSheet({
    super.key,
    required this.newNote,
    required this.newCatagory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: newNote,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create the New Note.",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(Icons.keyboard_double_arrow_right_sharp)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: newCatagory,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create the New Catagory.",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(Icons.keyboard_double_arrow_right_sharp)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
