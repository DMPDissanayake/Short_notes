import 'package:flutter/material.dart';

class CompletedBar extends StatefulWidget {
  const CompletedBar({super.key});

  @override
  State<CompletedBar> createState() => _CompletedBarState();
}

class _CompletedBarState extends State<CompletedBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("CompletedBar"),
      ),
    );
    ;
  }
}
