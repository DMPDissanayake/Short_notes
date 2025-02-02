import 'package:hive/hive.dart';
import 'package:short_notes/Models/todo_model.dart';

class TodoServices {
  List<Todo> allList = [
    Todo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: true,
    ),
  ];

  // Create the database reference for notes
  final _myBox = Hive.box("todos");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // Method to create the initial notes if the box is empty
  Future<void> createInitialToDo() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", allList);
    }
  }

  //List Load
  Future<List<Todo>> loadTodo() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<Todo>().toList();
    }
    return [];
  }

  //check box
  Future<void> checkBok(Todo todo) async {
    try {
      final dynamic todolist = await _myBox.get("todos");
      final int index = todolist.indexWhere((test) => test.id == todo.id);
      todolist[index] = todo;

      await _myBox.put("todos", todolist);
    } catch (e) {
      print(e.toString());
    }
  }

  //Add the new TodoTask
  Future<void> addNewTask(Todo todo) async {
    try {
      final dynamic todolist = await _myBox.get("todos");
      todolist.add(todo);
      await _myBox.put("todos", todolist);
    } catch (e) {
      print(e.toString());
    }
  }

  //delete Todo
  Future<void> deleteTodo(Todo todo) async {
    try {
      final dynamic allTodo = await _myBox.get("todos");
      allTodo.remove(todo);
      await _myBox.put("todos", allTodo);
    } catch (e) {
      print(e.toString());
    }
  }
}
