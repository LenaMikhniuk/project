import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/widgets/dimens/app_dimens.dart';
import 'package:this_is_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:this_is_project/widgets/common_widgets/auth_form.dart';
import 'package:this_is_project/features/features.dart';
import 'package:this_is_project/translations/locale_keys.g.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginPageCubit(
              authRepository: AuthRepositoryFirebase(),
              authCubit: context.read<AuthCubit>(),
            ),
        child: const LoginPageView());
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error.toString(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
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
                      ? const CircularProgressIndicator.adaptive()
                      : Text(LocaleKeys.login.tr().toUpperCase()),
                ),
                const SizedBox(height: AppDimens.xl),
                TextButton(
                  child: Text(LocaleKeys.signUp.tr().toUpperCase()),
                  onPressed: () => context.pushNamed(RegisterPage.path),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
