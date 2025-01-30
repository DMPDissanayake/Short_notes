import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/text_style.dart';

class TodoCard extends StatefulWidget {
  final Todo toDo;
  final bool completed;
  const TodoCard({
    super.key,
    required this.toDo,
    required this.completed,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  //chekbox
  // bool _chekbox = false;
  //SetDateTime

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kCardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  widget.toDo.title,
                  style: AppTextStyles.appSubtitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ("${widget.toDo.date.day}/${widget.toDo.date.month}/${widget.toDo.date.year}"),
                      style: AppTextStyles.appDescriptionSmall.copyWith(
                        fontSize: 15,
                        color: AppColors.kWhiteColor.withOpacity(0.4),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      ("${widget.toDo.time.hour}:${widget.toDo.time.minute}"),
                      style: AppTextStyles.appDescriptionSmall.copyWith(
                        fontSize: 15,
                        color: AppColors.kWhiteColor.withOpacity(0.4),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Checkbox(
              value: widget.completed,
              onChanged: (bool? value) {
                setState(() {});
              },
            )
          ],
        ));
  }
}
