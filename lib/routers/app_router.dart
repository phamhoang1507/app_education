import 'package:education_app/screens/forget_pass.dart';
import 'package:education_app/screens/home_page.dart';
import 'package:education_app/screens/login_page.dart';
import 'package:education_app/screens/register_page.dart';
import 'package:education_app/screens/welcome_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/forget',
      name: 'forget',
      builder: (context, state) => const ForgetPassPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
