import 'package:flutter/material.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Widgets/todocard.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodoList;
  const TodoTab({
    super.key,
    required this.incompletedTodoList,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.kDefaultPadding),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.incompletedTodoList.length,
            itemBuilder: (context, index) {
              return TodoCard(
                toDo: widget.incompletedTodoList[index],
                completed: widget.incompletedTodoList[index].isDone,
              );
            },
          ))
        ],
      ),
    );
  }
}
