import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:this_is_project/features/features.dart';
import 'package:this_is_project/features/router/main_router.dart';
import 'package:this_is_project/widgets/colors/app_colors.dart';
import 'package:this_is_project/features/auth/domain/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('pl'),
      ],
      path: 'assets/translations/',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepoInstance: MockAuthRepositoryImpl2()),
      child: Builder(builder: (context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.initial) {
              goRouter.go(SplashScreen.path);
            } else if (state.status == AuthStatus.unauthenticated) {
              goRouter.go(LoginPage.path);
            } else {
              goRouter.go(HomePage.path);
            }
          },
          child: MaterialApp.router(
            routerConfig: goRouter,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              textTheme: GoogleFonts.fjallaOneTextTheme(),
              scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
            ),
          ),
        );
      }),
    );
  }
}
