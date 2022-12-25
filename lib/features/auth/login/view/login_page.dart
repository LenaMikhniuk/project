import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';
import 'package:this_is_project/features/common_widgets/auth_form.dart';

import '../../../features.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPageCubit(
        MockAuthImpl(),
      ),
      child: const AuthPageView(),
    );
  }
}

class AuthPageView extends StatelessWidget {
  const AuthPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          context.go('/home');
        } else if (state.status == Status.logout) {
          context.go('/login');
        }
      },
      builder: (context, state) {
        if (state.status == Status.inital) {
          return Scaffold(
            backgroundColor: Colors.blue.shade50,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthForm(
                    label: 'Enter a username',
                    onChanged: (value) {
                      context.read<LoginPageCubit>().onNameChanged(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthForm(
                    label: 'Enter your password',
                    onChanged: (value) {
                      context.read<LoginPageCubit>().onPasswordChanged(value);
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginPageCubit>().login();
                    },
                    child: const Text('Login!'),
                  ),
                  const SizedBox(height: 32),
                  TextButton(
                    child: Text('Sign up'.toUpperCase()),
                    onPressed: () => context.push('/register'),
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
