import 'package:flutter/cupertino.dart';
import 'package:short_notes/Models/todo_model.dart';

class TodoData extends InheritedWidget {
  final List<Todo> todos;
  final Function(List<Todo>) onTodosChanged;

  const TodoData({
    required this.todos,
    required this.onTodosChanged,
    required Widget child,
  }) : super(child: child);

  // ignore: empty_constructor_bodies
  static TodoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoData>();
  }

  @override
  bool updateShouldNotify(TodoData oldWidget) {
    return oldWidget.todos != todos;
  }
}
