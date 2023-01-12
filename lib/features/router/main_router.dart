import 'package:go_router/go_router.dart';
import 'package:this_is_project/features/features.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: SplashScreen.path,
  routes: <RouteBase>[
    GoRoute(
      path: SplashScreen.path,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: LoginPage.path,
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: RegisterPage.path,
          name: RegisterPage.path,
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    ),
    GoRoute(
        path: HomePage.path,
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: ChatPage.path,
            name: ChatPage.path,
            builder: (context, state) => const ChatPage(),
          ),
        ]),
  ],
);
