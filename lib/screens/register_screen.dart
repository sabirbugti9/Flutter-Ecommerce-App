import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:velvet_app/blocs/auth/auth_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_event.dart';
import 'package:velvet_app/blocs/auth/auth_state.dart';
import 'package:velvet_app/screens/login_screen.dart';
import 'package:velvet_app/utils/pages_navigator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameContoller = TextEditingController();

  final TextEditingController emailContoller = TextEditingController();

  final TextEditingController passwordContoller = TextEditingController();

  @override
  void dispose() {
    nameContoller.dispose();
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
                    height: 480,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Register
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text('Register',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 161, 48, 40),
                                  fontSize: 35)),
                        ),

                        // name
                        TextField(
                          controller: nameContoller,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),

                        SizedBox(height: 15),

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
                                if (nameContoller.text.isEmpty ||
                                    emailContoller.text.isEmpty ||
                                    passwordContoller.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please enter name, email, and password')));
                                } else {
                                  context
                                      .read<AuthBloc>()
                                      .add(RegisterRequested(
                                        name: nameContoller.text,
                                        email: emailContoller.text,
                                        password: passwordContoller.text,
                                      ));
                                }
                              },
                              child: Text('Register'));
                        }),

                        // Go to register
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already a member yet? '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  'Login Now',
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
