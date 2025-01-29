import 'package:flutter/material.dart';
import 'package:short_notes/Helpers/snacbar.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Services/note_service.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;

  const UpdateNotePage({
    super.key,
    required this.note,
  });

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  List<String> catagory = [];
  final NotService notService = NotService();

  //Load Catagores
  Future _loadCategories() async {
    final noteService = NotService();
    catagory = await noteService.getAllCategories();

    setState(() {});
  }

  //form key
  final _formkey = GlobalKey<FormState>();
  //form controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectCatagory = "";

  @override
  void initState() {
    _loadCategories();
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
    _selectCatagory = widget.note.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Nots"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColors.kWhiteColor,
          ),
          onPressed: () {
            AppRouter.router.go("/notes");
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 130.0,
        height: 56.0,
        child: FloatingActionButton(
          onPressed: () {
            //validation set
            if (_formkey.currentState!.validate()) {
              try {
                notService.updateNote(
                  Note(
                    id: widget.note.id,
                    title: _titleController.text,
                    category: _selectCatagory!,
                    content: _contentController.text,
                    date: DateTime.now(),
                  ),
                );
                //Show the snacbar
                AppHelpers.showSnackBar(context, "Not Save Successfull!");

                //Set Routs and filed clearn
                _titleController.clear();
                _contentController.clear();

                AppRouter.router.go("/catagory", extra: _selectCatagory);
              } catch (e) {
                print(e.toString());
              }
            }
          },
          child: Text(
            "Update Note",
            style: AppTextStyles.appDescription,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      //drodown list
                      DropdownButtonFormField<String>(
                        value: _selectCatagory,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        hint: Text(
                          'Select Category',
                          style: TextStyle(
                            color: AppColors.kWhiteColor.withOpacity(0.4),
                            fontSize: 20,
                          ),
                        ),
                        items: catagory.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectCatagory = newValue!;
                          });
                        },
                        dropdownColor: AppColors.kCardColor,
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 18,
                        ),
                        isExpanded: false,
                        decoration: InputDecoration(
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.4),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //title
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a titel";
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 40,
                        ),
                        maxLines: 2,
                        cursorColor: AppColors.kWhiteColor.withOpacity(0.4),
                        cursorWidth: 5.0,
                        cursorHeight: 50,
                        cursorRadius: Radius.circular(5),
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 50,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //container
                      TextFormField(
                        controller: _contentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter content';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 18,
                        ),
                        maxLines: 12,
                        cursorColor: AppColors.kWhiteColor.withOpacity(0.4),
                        cursorWidth: 5.0,
                        cursorHeight: 30,
                        cursorRadius: Radius.circular(5),
                        decoration: InputDecoration(
                          hintText: "Note Content",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: AppColors.kWhiteColor.withOpacity(0.4),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
