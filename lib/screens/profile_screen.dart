import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_event.dart';
import 'package:velvet_app/blocs/auth/auth_state.dart';
import 'package:velvet_app/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        alignment: Alignment.center,
                        content: Text(
                          'Are you sure want to Logout?',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(LogoutRequested());

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                            ],
                          )
                        ],
                      ));
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Authenticated) {
            return Center(
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(state.user.avatar),
                  ),

                  SizedBox(height: 10),

                  // Profile Name
                  Text(
                    state.user.name,
                    style: TextStyle(fontSize: 30),
                  ),

                  SizedBox(height: 10),

                  // Profile Role
                  Text(
                    state.user.role,
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(height: 10),

                  // Profile Email
                  Text(
                    state.user.email,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
          return Text('Not Logged In');
        }),
      ),
    );
  }
}
