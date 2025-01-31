import 'package:flutter/material.dart';
import 'package:short_notes/Helpers/snacbar.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Services/todo_services.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Widgets/todocard.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodoList;
  final List<Todo> compledTodoList;

  const TodoTab({
    super.key,
    required this.incompletedTodoList,
    required this.compledTodoList,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  //mark todo done
  void _markTododone(Todo todo) async {
    try {
      final upDateTodo = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );

      await TodoServices().checkBok(upDateTodo);

      //sncbar
      AppHelpers.showSnackBar(context, "Complieted the Task");
      //remove the update task
      setState(() {
        widget.incompletedTodoList.remove(todo);
        widget.compledTodoList.add(upDateTodo);
      });
      //navigator
      AppRouter.router.go("/todos");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.incompletedTodoList.sort((a, b) => a.time.compareTo(b.time));
    });
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
                checkBox: () =>
                    _markTododone(widget.incompletedTodoList[index]),
              );
            },
          ))
        ],
      ),
    );
  }
}
