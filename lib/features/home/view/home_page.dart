import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/features/auth/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.logout) {
              context.go('/auth');
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              child: const Text('Logout'),
              onPressed: () => context.read<AuthCubit>().logout(),
            );
          },
        ),
      ),
    );
  }
}
