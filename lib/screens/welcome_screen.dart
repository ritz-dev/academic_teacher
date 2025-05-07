import 'package:academic_teacher/screens/api_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  final String appName;
  WelcomeScreen({required this.appName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(appName)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.go('/settings_screen');
            },
          ),
        ],
      ),
      body: ApiScreen(),
    );
  }

}