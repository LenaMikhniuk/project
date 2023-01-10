import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/components/colors/app_colors.dart';
import 'package:this_is_project/components/dimens/app_dimens.dart';
import 'package:this_is_project/domain/repositories/register/register.dart';
import 'package:this_is_project/components/common_widgets/auth_form.dart';
import 'package:this_is_project/features/features.dart';
import 'package:this_is_project/translations/locale_keys.g.dart';

const _minPasswordLenght = 3;
const _mandatoryCharacters = {'#', '\$', '%', '&', '*', '!'};

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(MockRegister()),
      child: RegisterPageContent(),
    );
  }
}

class RegisterPageContent extends StatelessWidget {
  RegisterPageContent({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.width / 2;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStateStatus.success) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            elevation: 0,
            leading: const BackButton(color: AppColors.buttonColor),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: AppDimens.l,
            ),
            child: Column(
              children: [
                AuthForm(
                  label: LocaleKeys.username.tr().toUpperCase(),
                  onChanged: (value) => context.read<RegisterCubit>().onNameChanged(value),
                ),
                const SizedBox(height: AppDimens.m),
                Form(
                  key: _formKey,
                  child: AuthForm(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.emptyPassword.tr();
                      } else if (value.length < _minPasswordLenght) {
                        return LocaleKeys.shortPassword.tr();
                      } else if (!_containsMandatoryCharacters(value)) {
                        return LocaleKeys.noSpecificChatacters.tr();
                      } else {
                        return null;
                      }
                    },
                    label: LocaleKeys.password.tr().toUpperCase(),
                    onChanged: (value) => context.read<RegisterCubit>().onPasswordChanged(value),
                    obscureText: state.hidePassword,
                    suffixIcon: IconButton(
                      color: AppColors.prymaryTextColor,
                      icon: Icon(
                        state.hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => context.read<RegisterCubit>().togglePasswordVisibility(state.hidePassword),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.xl),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().registerUser();
                    }
                  },
                  child: Text(
                    LocaleKeys.signUp.tr().toUpperCase(),
                    style: const TextStyle(color: AppColors.lightTextColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _containsMandatoryCharacters(String value) {
    bool result = false;

    for (final character in value.characters) {
      result = _mandatoryCharacters.contains(character);
    }
    return result;
  }
}
