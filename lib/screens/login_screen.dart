import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:velvet_app/blocs/auth/auth_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_event.dart';
import 'package:velvet_app/blocs/auth/auth_state.dart';
import 'package:velvet_app/screens/register_screen.dart';
import 'package:velvet_app/utils/pages_navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailContoller = TextEditingController();

  final TextEditingController passwordContoller = TextEditingController();

  @override
  void dispose() {
    emailContoller.dispose();
    passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 48, 40),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Lottie.asset('assets/lottie/login-icon.json', height: 130),

                  Container(
                    padding: EdgeInsets.all(12.0),
                    height: 410,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Login
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text('Login',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 161, 48, 40),
                                  fontSize: 35)),
                        ),

                        // email
                        TextField(
                          controller: emailContoller,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        SizedBox(height: 15),

                        // password
                        TextField(
                          controller: passwordContoller,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                        ),

                        SizedBox(height: 20),

                        BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                          if (state is Authenticated) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => PagesNavigator()),
                                (route) => false);
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)));
                          }
                        }, builder: (context, state) {
                          if (state is AuthLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 161, 48, 40),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                if (emailContoller.text.isEmpty ||
                                    passwordContoller.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please enter name, email, and password')));
                                } else {
                                  context.read<AuthBloc>().add(LoginRequsted(
                                        email: emailContoller.text,
                                        password: passwordContoller.text,
                                      ));
                                }
                              },
                              child: Text('Login'));
                        }),

                        // Go to register
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Not a member yet? '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
