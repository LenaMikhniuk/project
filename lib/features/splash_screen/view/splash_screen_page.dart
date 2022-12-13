import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:this_is_project/features/features.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenCubit(),
      child: const SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashScreenCubit>().getToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashScreenCubit, SplashScreenState>(
      listener: (context, state) {
        if (state.status == SplashScreenStateStatus.navigateToHome) {
          context.go('/home');
        } else {
          context.go('/auth');
        }
      },
      builder: (context, state) {
        return const Scaffold(
          backgroundColor: Colors.amberAccent,
        );
      },
    );
  }
}
