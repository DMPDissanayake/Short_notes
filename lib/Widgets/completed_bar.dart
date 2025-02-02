import 'package:flutter/material.dart';
import 'package:short_notes/Helpers/snacbar.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Services/todo_services.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Widgets/todocard.dart';

class CompletedBar extends StatefulWidget {
  final List<Todo> completedTodoList;
  final List<Todo> incompletedTodoList;

  const CompletedBar({
    super.key,
    required this.completedTodoList,
    required this.incompletedTodoList,
  });

  @override
  State<CompletedBar> createState() => _CompletedBarState();
}

class _CompletedBarState extends State<CompletedBar> {
  //mark todo done
  void _markUnTododone(Todo todo) async {
    try {
      final pastTodo = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );
      await TodoServices().checkBok(pastTodo);
      //snacbar
      AppHelpers.showSnackBar(context, "Not Compleated the Task");
      //update
      setState(() {
        widget.completedTodoList.remove(todo);
        widget.incompletedTodoList.add(pastTodo);
      });
      //navigation
      AppRouter.router.go("/todos");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodoList.sort((a, b) => a.time.compareTo(b.time));
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
            itemCount: widget.completedTodoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(widget.completedTodoList[index].id.toString()),
                onDismissed: (direction) {
                  // Store the item before removal
                  final Todo dismissedTodo = widget.completedTodoList[index];
                  setState(() {
                    widget.completedTodoList.removeAt(index);
                  });
                  // Delete the task after updating the list
                  TodoServices().deleteTodo(dismissedTodo);
                  AppHelpers.showSnackBar(context, "Task is Deleted!");
                },
                child: TodoCard(
                  toDo: widget.completedTodoList[index],
                  completed: widget.completedTodoList[index].isDone,
                  checkBox: () =>
                      _markUnTododone(widget.completedTodoList[index]),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
