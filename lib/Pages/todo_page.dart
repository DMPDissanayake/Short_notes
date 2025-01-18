import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/routers.dart';

class ToDoPapp extends StatefulWidget {
  const ToDoPapp({super.key});

  @override
  State<ToDoPapp> createState() => _ToDoPappState();
}

class _ToDoPappState extends State<ToDoPapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColors.kWhiteColor,
          ),
          onPressed: () {
            AppRouter.router.go("/");
          },
        ),
      ),
    );
  }
}
