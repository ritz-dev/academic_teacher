import 'package:academic_teacher/screens/login_screen.dart';
import 'package:academic_teacher/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class PanelScreen extends StatelessWidget {
  const PanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LoginScreen(appName: "Academin Teacher"),
        )
      ]
    );
  }
}
