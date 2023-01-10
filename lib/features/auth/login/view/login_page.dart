import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/components/dimens/app_dimens.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';
import 'package:this_is_project/components/common_widgets/auth_form.dart';
import 'package:this_is_project/features/features.dart';
import 'package:this_is_project/translations/locale_keys.g.dart';

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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.m),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthForm(
                    label: LocaleKeys.username.tr(),
                    onChanged: (value) {
                      context.read<LoginPageCubit>().onNameChanged(value);
                    },
                  ),
                  const SizedBox(height: AppDimens.m),
                  AuthForm(
                    label: LocaleKeys.password.tr(),
                    onChanged: (value) {
                      context.read<LoginPageCubit>().onPasswordChanged(value);
                    },
                  ),
                  const SizedBox(height: AppDimens.xl),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginPageCubit>().login();
                    },
                    child: state.status == Status.loading
                        ? const CircularProgressIndicator()
                        : Text(LocaleKeys.login.tr()),
                  ),
                  const SizedBox(height: AppDimens.xl),
                  TextButton(
                    child: Text(LocaleKeys.signUp.tr().toUpperCase()),
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
