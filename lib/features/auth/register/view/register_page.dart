import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/domain/repositories/register/register.dart';
import 'package:this_is_project/features/common_widgets/auth_form.dart';
import 'package:this_is_project/features/features.dart';

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
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStateStatus.success) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.amber.shade100,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.amber.shade100,
            leading: const BackButton(color: Colors.indigo),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 85, horizontal: 25),
            child: Column(
              children: [
                AuthForm(
                  label: 'Your username'.toUpperCase(),
                  onChanged: (value) => context.read<RegisterCubit>().onNameChanged(value),
                  style: const TextStyle(color: Colors.indigo),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: AuthForm(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please Enter your password';
                      } else if (value.length < _minPasswordLenght) {
                        return 'Your password should be longer!';
                      } else if (!_containsMandatoryCharacters(value)) {
                        return 'Your password should contain specific characters';
                      } else {
                        return null;
                      }
                    },
                    label: 'Your password'.toUpperCase(),
                    onChanged: (value) => context.read<RegisterCubit>().onPasswordChanged(value),
                    style: const TextStyle(color: Colors.indigo),
                    obscureText: state.hidePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => context.read<RegisterCubit>().togglePasswordVisibility(state.hidePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().registerUser();
                    }
                  },
                  child: Text(
                    'sign up!'.toUpperCase(),
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
