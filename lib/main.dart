import 'package:academic_teacher/bloc/api_settings/api_settings_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';
import 'package:academic_teacher/data/user_repository.dart';
import 'package:academic_teacher/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:academic_teacher/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'router/app_router.dart';

void main() {
  final UserRepository userRepository = UserRepository();
  final authBloc = AuthenticationBloc(userRepository: userRepository);
  

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(value: authBloc),
        BlocProvider<ApiSettingsBloc>(create: (context) => ApiSettingsBloc(),),
      ], 
      child: MyApp(
          userRepository: userRepository,
          authBloc: authBloc
        ),
      )
  );
}

class MyApp extends StatefulWidget {

  final UserRepository userRepository;
  final AuthenticationBloc authBloc;

  const MyApp({super.key, required this.userRepository, required this.authBloc});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter appRouter;
  String appName = '';

  @override
  void initState() {
    super.initState();
    appRouter = AppRouter(widget.authBloc);
    _getAppInfo();
    _fetchUser();
  }

  Future<void> _getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appName = _formatAppName(info.appName);
    });
  }

  Future<void> _fetchUser() async {
    // Fetch the authenticated user once the app is initialized
    context.read<ApiSettingsBloc>().add(FetchAuthenticatedUser());
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

      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Auth GoRouter App',
        routerConfig: appRouter.router,
      );
         
       
    }
  }
  