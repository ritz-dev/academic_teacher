import 'package:academic_teacher/bloc/api_settings/api_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  final String appName;
  SettingsScreen({super.key,required this.appName});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/welcome_screen');
        },
      ),
      title: Center(child: Text("Settings")),
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ApiSettingsBloc,ApiSettingsState>(
          builder: (context, state) {
              if (state is ApiSettingsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ApiSettingsError) {
                return Center(child: Text("Error: ${state.error}"));
              } else if (state is ApiSettingsSuccess) {
                final user = state.user;
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account Information",style: TextStyle(fontWeight: FontWeight.w100,fontSize: 20)),
                      Row(
                        children: [
                          Icon(Icons.person,size: 18),
                          SizedBox(width: 8),
                          Text(user.name),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.email, size: 18),
                          SizedBox(width: 8),
                          Text(user.email),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.work,size: 18),
                          SizedBox(width: 8),
                          Text(user.role),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text("Please wait..."));
            },
          
        )
      ),
      
    );
  }

}

// body: BlocBuilder<ApiSettingsBloc, ApiSettingsState>(
      //   builder: (context, state) {
      //     if (state is ApiSettingsLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is ApiSettingsError) {
      //       return Center(child: Text("Error: ${state.error}"));
      //     } else if (state is ApiSettingsSuccess) {
      //       final user = state.user;
      //       return Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text("User ID: ${user.id}"),
      //             Text("Name: ${user.name}"),
      //             Text("Email: ${user.email}"),
      //           ],
      //         ),
      //       );
      //     }
      //     return const Center(child: Text("Please wait..."));
      //   },
      // ),

