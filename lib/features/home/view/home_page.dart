import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/features/features.dart';
import 'package:this_is_project/translations/locale_keys.g.dart';
import 'package:this_is_project/widgets/dimens/app_dimens.dart';

class HomePage extends StatelessWidget {
  static const path = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimens.s),
                child: FractionallySizedBox(
                  widthFactor: AppDimens.buttonWidthFactor,
                  child: ElevatedButton(
                    onPressed: context.read<AuthCubit>().logout,
                    child: Text(LocaleKeys.logout.tr()),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.xl),
              TextButton(
                onPressed: () => context.pushNamed(ChatPage.path),
                child: Text(LocaleKeys.videoChat.tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
