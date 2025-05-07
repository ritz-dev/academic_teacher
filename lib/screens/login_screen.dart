import 'package:academic_teacher/bloc/auth/authentication_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_event.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';
import 'package:academic_teacher/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  final String appName;

  LoginScreen({required this.appName});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(
    text: "superadmin@example.com",
  );
  final _passwordController = TextEditingController(text: 'superpassword');
  final _formKey = GlobalKey<FormState>();
  String? _token;
  String? _message;

  @override
  void initState() {
    super.initState();
    // Check if the user is already authenticated
    context.read<AuthenticationBloc>().add(AuthenticationCheckRequested());
    Future.delayed(Duration(seconds: 2), () async {
      final authState = context.read<AuthenticationBloc>().state;
      print('Current Auth State: $authState');

      // Wait until the AuthenticationBloc has updated the state
      if (authState is Authenticated) {
        // Use GoRouter to navigate to the home screen
        GoRouter.of(context).go('/welcome_screen');
      } else if (authState is Unauthenticated ||
          authState is AuthenticationFailure) {
        // Use GoRouter to navigate to the login screen
        GoRouter.of(context).go('/login');
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 70),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 50.0,
            ),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blueAccent, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text('Welcome to ${widget.appName}!'),
                SizedBox(height: 10),
                Text('Login Form'),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is AuthenticationFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Login Failed: ${state.error}'),
                              ),
                            );
                          } else if (state is Authenticated) {
                            setState(() {
                              _token = state.token;
                            });
                            // Navigator.pushReplacement(
                            //   context,
                            //   Navigator.pushReplacementNamed(context, '/welcome_screen') as Route<Object?>
                            // );
                            context.go('/welcome_screen');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Success')),
                            );
                          } else if (state is Unauthenticated) {
                            setState(() {
                              _token = state.token;
                              _message = '';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logout...')),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthenticationLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return _buildLoginButton(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        debugPrint('_Token is $_token');
        final isAuthenticated = _token != null && _token!.isNotEmpty;
        debugPrint('Is Authenticated is $isAuthenticated');
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isAuthenticated ? Colors.redAccent : Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              if (isAuthenticated) {
                debugPrint('Authentication Logout');
                context.read<AuthenticationBloc>().add(LogoutRequested());
              } else {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  debugPrint(
                    'Dispatching LoginRequested event with email: $email',
                  );
                  context.read<AuthenticationBloc>().add(
                    LoginRequested(email, password),
                  );
                }
              }
            },
            child: Text(
              isAuthenticated ? 'Logout' : 'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
