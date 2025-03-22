import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_event.dart';
import 'package:velvet_app/blocs/auth/auth_state.dart';
import 'package:velvet_app/blocs/product/product_bloc.dart';
import 'package:velvet_app/blocs/product/product_event.dart';
import 'package:velvet_app/repositories/auth_repository.dart';
import 'package:velvet_app/repositories/product_repository.dart';
import 'package:velvet_app/screens/login_screen.dart';
import 'package:velvet_app/utils/pages_navigator.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          AuthBloc(repository: AuthRepository())..add(CheckLoginStatus()),
    ),
    BlocProvider(
      create: (context) =>
          ProductBloc(repository: ProductRepository())..add(LoadProducts()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Authenticated) {
          return PagesNavigator();
        } else if (state is UnAuthenticated) {
          return LoginScreen();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      }),
    );
  }
}
