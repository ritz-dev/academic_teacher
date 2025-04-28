import 'package:academic_teacher/bloc/auth/authentication_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';
import 'package:academic_teacher/data/user_repository.dart';
import 'package:academic_teacher/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:academic_teacher/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthenticationBloc(userRepository))
      ], 
      child: MyApp(userRepository: userRepository),
      )
  );
}

class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  const MyApp({super.key, required this.userRepository});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String appName = '';

  @override
  void initState() {
    super.initState();
    _getAppInfo();
  }

  Future<void> _getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appName = _formatAppName(info.appName);
    });
  }

  String _formatAppName(String name) {
  return name
      .split('_')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthenticationBloc,AuthenticationState>(
      builder: (context,state){
          String initialRoute = (state is Authenticated) ? '/welcome_screen' : '/';
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName.isEmpty ? 'Loading...' : appName,
            initialRoute: initialRoute,
            routes: {
              '/': (context) => MainScreen(appName: appName),
              '/welcome_screen': (context) => WelcomeScreen(appName:appName),
            },
          );
        }
      );
    }
  }
  
  class Authenticated {
  }
