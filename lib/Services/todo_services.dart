import 'package:hive/hive.dart';
import 'package:short_notes/Models/todo_model.dart';

class TodoServices {
  List<Todo> allList = [
    Todo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: true,
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
      isDone: false,
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
  Future<List<Todo>> loadNotes() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<Todo>) {
      return todos.cast<Todo>().toList();
    }
    return [];
  }
}
