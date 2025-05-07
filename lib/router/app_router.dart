import 'dart:async';

import 'package:academic_teacher/bloc/auth/authentication_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';
import 'package:academic_teacher/screens/login_screen.dart';
import 'package:academic_teacher/screens/settings_screen.dart';
import 'package:academic_teacher/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppRouter{
  final AuthenticationBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter( 
    refreshListenable: GoRouterRefreshBloc(authBloc.stream),
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/login',
         builder: (context, state) {
            // final appName = state.pathParameters['appName'] ?? '';
            return LoginScreen(appName: "Academic Teacher");
          },
        ),

        GoRoute(
          path: '/welcome_screen',
          builder: (context,state) {
            // final appName = state.pathParameters['appName'] ?? '';
            return WelcomeScreen(appName: "Welcome");
          }
        ),

        GoRoute(
          path: '/settings_screen',
          builder:(context,state){
            return SettingsScreen(appName: "Settings");
          }
        )
      ], 

      redirect: (context, state) {
        final authState = authBloc.state;
        debugPrint('Matched location: ${state.matchedLocation}');
        
        if (authState is AuthenticationInitial || authState is AuthenticationLoading) {
          return '/login';
        }

        if (authState is Unauthenticated || authState is AuthenticationFailure) {
          return '/login';
        }

        // state.matchedLocation == '/login' || 

        if (authState is AuthenticationSuccess && (state.matchedLocation == '/' || state.matchedLocation == '/login')) {
            return '/welcome_screen';
        }

        return null;
      },
    );

  Future<void> initAppName() async {
    final info = await PackageInfo.fromPlatform();
    final appName = _formatAppName(info.appName);
    print(appName); // Now it's safe to use
  }

  String _formatAppName(String name) {
    return name
        .split('_')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class GoRouterRefreshBloc extends ChangeNotifier {
  GoRouterRefreshBloc(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
