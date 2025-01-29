import 'package:flutter/material.dart';
import 'package:short_notes/Helpers/snacbar.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Services/note_service.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';
import 'package:uuid/uuid.dart';

class CreateNote extends StatefulWidget {
  final bool isNewNote;
  const CreateNote({
    super.key,
    required this.isNewNote,
  });

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  List<String> catagory = [];
  final NotService noteService = NotService();

  //Load Catagores
  Future _loadCategories() async {
    final noteService = NotService();
    catagory = await noteService.getAllCategories();

    setState(() {});
  }

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  //form key
  final _formkey = GlobalKey<FormState>();
  //form controller
  final TextEditingController _catagotryController = TextEditingController();
  String? _selectCatagory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
            AppRouter.router.go("/notes");
          },
        ),
        title: Text(
          "Create Note",
          style: AppTextStyles.appSubtitle,
        ),
      ),
      floatingActionButton: SizedBox(
        width: 130.0,
        height: 56.0,
        child: FloatingActionButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              try {
                noteService.addnote(
                  Note(
                    title: _titleController.text,
                    category: widget.isNewNote
                        ? _catagotryController.text
                        : _selectCatagory!,
                    content: _contentController.text,
                    date: DateTime.now(),
                    id: Uuid().v4(),
                  ),
                );

                //Show the snacbar
                AppHelpers.showSnackBar(context, "Not Save Successfull!");

                //Set Routs and filed clearn

                _titleController.clear();
                _contentController.clear();

                AppRouter.router.go("/notes");
              } catch (e) {
                print(e.toString());
                //Show the snacbar
                AppHelpers.showSnackBar(context, "Not Not Save Successfull!");
              }
            }
          },
          child: Text(
            "Save Note",
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
                      //Set condition
                      widget.isNewNote
                          ? TextFormField(
                              controller: _catagotryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a category';
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Category',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.kWhiteColor.withOpacity(0.4),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.4),
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
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                              ),
                            )
                          : DropdownButtonFormField<String>(
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
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.4),
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
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.4),
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
