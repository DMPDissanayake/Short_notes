import 'package:flutter/material.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Services/todo_services.dart';
import 'package:short_notes/Utils/colors.dart';
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
  late TabController _tabController;
  TodoServices todoServices = TodoServices();
  //allList
  late List<Todo> allTodoList = [];
  late List<Todo> inCompletedeTodoList = [];
  late List<Todo> completedeTodoList = [];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _isNewUser();
    super.initState();
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
    final List<Todo> todoList = await todoServices.loadNotes();
    setState(() {
      //Set All todo
      allTodoList = todoList;
      //incompeted todos
      inCompletedeTodoList = allTodoList.where((test) => !test.isDone).toList();
      //compeled todos
      completedeTodoList = allTodoList.where((test) => test.isDone).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        onPressed: () {},
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
          ),
          CompletedBar(),
        ],
      ),
    );
  }
}
