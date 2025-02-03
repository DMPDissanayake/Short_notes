import 'package:flutter/material.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Pages/todo_data.dart';
import 'package:short_notes/Services/note_service.dart';
import 'package:short_notes/Services/todo_services.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';
import 'package:short_notes/Widgets/home_Card.dart';
import 'package:short_notes/Widgets/nots_todo_crad.dart';
import 'package:short_notes/Widgets/progress_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotService notService = NotService();
  final TodoServices todoServices = TodoServices();
  List<Note> allNote = [];
  List<Todo> allTodo = [];

  //Check the new user
  void _isNewUser() async {
    final bool isNewUser =
        await notService.isNewUser() || await TodoServices().isNewUser();
    if (isNewUser) {
      await notService.createInitialNotes();
      await todoServices.createInitialToDo();
    }
    _loadNotes();
    _loadTodos();
  }

  //load note list
  Future<void> _loadNotes() async {
    final List<Note> loadedNote = await notService.loadNotes();
    setState(() {
      allNote = loadedNote;
    });
  }

  //load Todos list
  Future<void> _loadTodos() async {
    final List<Todo> loadedTodo = await todoServices.loadTodo();
    setState(() {
      allTodo = loadedTodo;
    });
  }

  @override
  void initState() {
    _isNewUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: allTodo,
      onTodosChanged: (todos) {
        setState(() {
          allTodo = todos;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "NoteSphere",
            style: AppTextStyles.appTitle,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: AppConstants.kDefaultPadding,
              ),
              ProgressCard(
                completTask: allTodo.where((test) => test.isDone).length,
                totalCompletTask: allTodo.length,
              ),
              SizedBox(
                height: AppConstants.kDefaultPadding * 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push("/notes");
                    },
                    child: NotsTodoCrad(
                      icon: Icons.bookmark_add_outlined,
                      title: 'Notes',
                      description: "${allNote.length.toString()} Notes",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push("/todos");
                    },
                    child: NotsTodoCrad(
                      icon: Icons.today_outlined,
                      title: 'To-Do List',
                      description: "${allTodo.length.toString()} Notes",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppConstants.kDefaultPadding * 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Progress",
                    style: AppTextStyles.appSubtitle,
                  ),
                  Text(
                    "See All",
                    style: AppTextStyles.appSubtitle,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              allTodo.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Your are not add the Task!!.",
                          style: AppTextStyles.appSubtitle.copyWith(
                            fontSize: 18,
                            color: AppColors.kWhiteColor.withOpacity(0.4),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            AppRouter.router.push("/todos");
                          },
                          child: const Text("Add Task"),
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                      itemCount: allTodo.length,
                      itemBuilder: (context, index) {
                        final Todo todo = allTodo[index];
                        return HomeCard(
                          title: todo.title,
                          data: todo.date.toString(),
                          time: todo.date.toString(),
                          isDone: todo.isDone,
                        );
                      },
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
