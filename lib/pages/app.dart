import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polytech_visits_web/pages/auth/bloc/auth_bloc.dart';

import '../widgets/custom_snackbar.dart';
import 'auth/auth_page.dart';
import 'home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polytech Visits',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc()..add(EventAuthInitial())),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is StateAuthRejected) {
              showCustomSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is StateAuthConfirmed) {
              return const HomePage();
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
