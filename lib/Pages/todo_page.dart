import 'package:flutter/material.dart';
import 'package:short_notes/Helpers/snacbar.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Pages/todo_data.dart';
import 'package:short_notes/Services/todo_services.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';
import 'package:short_notes/Widgets/completed_bar.dart';
import 'package:short_notes/Widgets/todo_tab.dart';

class ToDoPapp extends StatefulWidget {
  const ToDoPapp({super.key});

  @override
  State<ToDoPapp> createState() => _ToDoPappState();
}

class _ToDoPappState extends State<ToDoPapp>
    with SingleTickerProviderStateMixin {
  //Set Variable
  late TabController _tabController;
  TodoServices todoServices = TodoServices();
  //allList
  late List<Todo> allTodoList = [];
  late List<Todo> inCompletedeTodoList = [];
  late List<Todo> completedeTodoList = [];
  final TextEditingController _todoControler = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _isNewUser();
    super.initState();
  }

  @override
  void dispose() {
    _todoControler.dispose();

    super.dispose();
  }

//check the isNew user
  void _isNewUser() async {
    final bool isNewUse = await todoServices.isNewUser();
    if (isNewUse) {
      await todoServices.createInitialToDo();
    }
    _loadedTodoList();
  }

//loaded the todo lits
  Future<void> _loadedTodoList() async {
    final List<Todo> todoList = await todoServices.loadTodo();
    print(allTodoList.length);
    setState(() {
      //Set All todo
      allTodoList = todoList;
      //incompeted todos
      inCompletedeTodoList = allTodoList.where((test) => !test.isDone).toList();
      //compeled todos
      completedeTodoList = allTodoList.where((test) => test.isDone).toList();
    });
  }

  //Add new todo
  void _addNew() async {
    if (_todoControler.text.isNotEmpty) {
      final addNew = Todo(
        title: _todoControler.text,
        date: DateTime.now(),
        time: DateTime.now(),
        isDone: false,
      );
      try {
        await TodoServices().addNewTask(addNew);
        _loadedTodoList();
        if (TodoData.of(context) != null) {
          TodoData.of(context)!.onTodosChanged(allTodoList);
        }
        //appsnacbar
        AppHelpers.showSnackBar(context, "Task is Added");
        //clear the text filed
        _todoControler.clear();
        Navigator.pop(context);
        print("done");
      } catch (e) {
        print(e.toString());
      }
    }
  }

  //Messge model
  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Text(
              "Add New Task",
              style: AppTextStyles.appSubtitle,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: _todoControler,
                  maxLength: 22, // Limits input to 50 characters
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a Task";
                    } else if (value.length > 22) {
                      return "Task cannot exceed 22 characters";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: AppColors.kWhiteColor.withOpacity(0.4),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: AppColors.kWhiteColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addNew();
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.kFabColor,
              ),
              child: Text(
                "Add the Task",
                style: AppTextStyles.appDescription.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.kCardColor,
              ),
              child: Text(
                "Cancel",
                style: AppTextStyles.appDescription.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColors.kWhiteColor,
          ),
          onPressed: () {
            AppRouter.router.go("/");
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "ToDo",
                style: AppTextStyles.appDescription,
              ),
            ),
            Tab(
              child: Text(
                "Compelted",
                style: AppTextStyles.appDescription,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMessageModel(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            side: BorderSide(
              color: AppColors.kWhiteColor,
              width: 2,
            )),
        backgroundColor: AppColors.kFabColor,
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(
            incompletedTodoList: inCompletedeTodoList,
            compledTodoList: completedeTodoList,
          ),
          CompletedBar(
            completedTodoList: completedeTodoList,
            incompletedTodoList: inCompletedeTodoList,
          ),
        ],
      ),
    );
  }
}
