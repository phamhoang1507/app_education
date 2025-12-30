import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/screens/course_page.dart';
import 'package:education_app/screens/filter_page.dart';
import 'package:education_app/screens/forget_pass_page.dart';
import 'package:education_app/screens/home_page.dart';
import 'package:education_app/screens/list_tutors_page.dart';
import 'package:education_app/screens/login_page.dart';
import 'package:education_app/screens/policy_page.dart';
import 'package:education_app/screens/profile_page.dart';
import 'package:education_app/screens/register_page.dart';
import 'package:education_app/screens/subject_page.dart';
import 'package:education_app/screens/terms_page.dart';
import 'package:education_app/screens/welcome_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: NavigationManager.welcomePath,
  routes: [
    GoRoute(
      path: NavigationManager.welcomePath,
      name: NavigationManager.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: NavigationManager.loginPath,
      name: NavigationManager.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: NavigationManager.forgetPasswordPath,
      name: NavigationManager.forgetPassword,
      builder: (context, state) => const ForgetPassPage(),
    ),
    GoRoute(
      path: NavigationManager.registerPath,
      name: NavigationManager.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: NavigationManager.homePath,
      name: NavigationManager.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'filter',
          name: NavigationManager.filter,
          builder: (context, state) => const FilterPage(),
          routes: [
            GoRoute(
              path: 'list',
              name: NavigationManager.listFilter,
              builder: (context, state) {
                final args = state.extra as Map<String, dynamic>;
                return ListTutorsPage(items: args['data']);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NavigationManager.profilePath,
      name: NavigationManager.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: NavigationManager.subjectPath,
      name: NavigationManager.subject,
      builder: (context, state) => const SubjectPage(),
    ),
    GoRoute(
      path: NavigationManager.coursesPath,
      name: NavigationManager.courses,
      builder: (context, state) => const CoursePage(),
    ),
    GoRoute(
      path: NavigationManager.termsPath,
      name: NavigationManager.terms,
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: NavigationManager.policyPath,
      name: NavigationManager.policy,
      builder: (context, state) => const PolicyPage(),
    ),
  ],
);
