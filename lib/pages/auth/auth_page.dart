import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polytech_visits_web/services/auth_repository.dart';

import '../../utils/styles/color_palette.dart';
import '../../utils/styles/styles.dart';
import '../../widgets/custom_full_width_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_field.dart';
import 'bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final repository = AuthRepository();

  @override
  void initState() {
    loginController.text = 'thanos';
    passwordController.text = '123456ak';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.main,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/logo_white.png',
                        fit: BoxFit.fitWidth,
                      )),
                  const SizedBox(height: 50),
                  Text('Авторизация',
                      style: ProjectStyles.textStyle_22Bold
                          .copyWith(color: ColorPalette.secondary)),
                  const SizedBox(height: 10),
                  customTextFormField(
                    () {},
                    controller: loginController,
                    hintText: 'Логин',
                  ),
                  customTextFormField(() {},
                      controller: passwordController, hintText: 'Пароль'),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is StateAuthLoading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: ColorPalette.secondary,
                        ));
                      }
                      return const SizedBox();
                    },
                  ),
                  customFullWidthButton(
                    () {
                      if (context.read<AuthBloc>().state is StateAuthLoading) {
                        return;
                      } else {
                        if (loginController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          context.read<AuthBloc>().add(EventAuthLogin(
                              loginController.text, passwordController.text));
                        } else {
                          showCustomSnackBar(context, 'Заполните все поля!');
                        }
                      }
                    },
                    title: 'Войти',
                    backgroundColor: ColorPalette.secondary,
                    textColor: ColorPalette.main,
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
