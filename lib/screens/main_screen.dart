import 'package:academic_teacher/screens/panel_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String appName;
 const MainScreen({super.key, required this.appName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appName),
      ),
      body: Center(
        child: Column(
            children: [
              Expanded(child: PanelScreen())
            ],
        ),
      ),
    );
  }
}