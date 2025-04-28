import 'package:academic_teacher/bloc/auth/authentication_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  String apiUrl = "academic-years";
  String requestType = "GET"; // Default request type
  String microService = "academic";
  String apiCrud = "list";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTextAPIButton(context),
    );
  }

  Widget _buildTextAPIButton(BuildContext context){
    String? selectedMethodValue;
    String? selectedTitleValue;
    String? selectedItemValue;
    final List<String> methods = ['GET','POST'];
    final List<String> titles = ['academic','finance','user_management'];
    final List<String> items = ['list','create','update','delete'];
    return BlocBuilder<AuthenticationBloc,AuthenticationState>(
      builder: (context,state){
         final _token = state.token;
        return Container(
          width: 600,
          child: Row(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedMethodValue,
                          hint: Text('Select method'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMethodValue = newValue;
                            });
                          },
                          items: methods.map((String method) {
                            return DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            );
                          }).toList(),
                        ),
                                
                        DropdownButton<String>(
                          value: selectedTitleValue,
                          hint: Text('Select title'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTitleValue = newValue;
                            });
                          },
                          items: titles.map((String title) {
                            return DropdownMenuItem<String>(
                              value: title,
                              child: Text(title),
                            );
                          }).toList(),
                        ),
                    
                        DropdownButton<String>(
                          value: selectedItemValue,
                          hint: Text('Select item'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItemValue = newValue;
                            });
                          },
                          items: items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                 Expanded(
                  flex: 2,
                  child: Text("Welcome")
                )
              ],
          ),
        );
    });
  }
}