import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/features/auth/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/translations/locale_keys.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.logout) {
            context.go('/auth');
          } else if (state.status == AuthStatus.loading) {
            CircularProgressIndicator();
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(LocaleKeys.logout.tr()),
                onPressed: () => context.read<AuthCubit>().logout(),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () => context.push('/videoChat'),
                child: Text(LocaleKeys.videoChat.tr()),
              ),
            ],
          );
        },
      ),
    );
  }
}
