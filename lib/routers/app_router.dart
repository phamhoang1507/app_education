import 'package:education_app/screens/course_page.dart';
import 'package:education_app/screens/forget_pass_page.dart';
import 'package:education_app/screens/home_page.dart';
import 'package:education_app/screens/login_page.dart';
import 'package:education_app/screens/profile_page.dart';
import 'package:education_app/screens/register_page.dart';
import 'package:education_app/screens/subject_page.dart';
import 'package:education_app/screens/terms_page.dart';
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
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/subject',
      name: 'subject',
      builder: (context, state) => const SubjectPage(),
    ),
    GoRoute(
      path: '/courses',
      name: 'courses',
      builder: (context, state) => const CoursePage(),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsPage(),
    ),
  ],
);
