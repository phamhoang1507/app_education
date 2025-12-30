import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationManager {
  // Singleton pattern
  static final NavigationManager _instance = NavigationManager._internal();
  factory NavigationManager() => _instance;
  NavigationManager._internal();

  // Route names constants
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgetPassword = 'forget';
  static const String home = 'home';
  static const String filter = 'filter';
  static const String listFilter = 'listFilter';
  static const String profile = 'profile';
  static const String subject = 'subject';
  static const String courses = 'courses';
  static const String terms = 'terms';
  static const String policy = 'policy';
  static const String notificationSettings = 'notification-settings';

  // Route paths constants
  static const String welcomePath = '/welcome';
  static const String loginPath = '/login';
  static const String registerPath = '/register';
  static const String forgetPasswordPath = '/forget';
  static const String homePath = '/home';
  static const String filterPath = '/home/filter';
  static const String listFilterPath = '/home/filter/list';
  static const String profilePath = '/profile';
  static const String subjectPath = '/subject';
  static const String coursesPath = '/courses';
  static const String termsPath = '/terms';
  static const String policyPath = '/policy';

  // Navigation methods

  /// Navigate to Welcome page
  void toWelcome(BuildContext context) {
    context.goNamed(welcome);
  }

  /// Navigate to Login page
  void toLogin(BuildContext context) {
    context.goNamed(login);
  }

  /// Navigate to Register page
  void toRegister(BuildContext context) {
    context.pushNamed(register);
  }

  /// Navigate to Forget Password page
  void toForgetPassword(BuildContext context) {
    context.goNamed(forgetPassword);
  }

  /// Navigate to Home page
  void toHome(BuildContext context) {
    context.goNamed(home);
  }

  /// Navigate to Filter page
  void toFilter(BuildContext context) {
    context.push(filterPath);
  }

  /// Navigate to ListFilter page
  void tolistFilter(BuildContext context, List<dynamic> data) {
    context.push(listFilterPath, extra: {'data': data});
  }

  /// Navigate to Profile page
  void toProfile(BuildContext context) {
    context.pushNamed(profile);
  }

  /// Navigate to Subject page
  void toSubject(BuildContext context) {
    context.pushNamed(subject);
  }

  /// Navigate to Courses page
  void toCourses(BuildContext context) {
    context.pushNamed(courses);
  }

  /// Navigate to Terms page
  void toTerms(BuildContext context) {
    context.pushNamed(terms);
  }

  /// Navigate to Policy page
  void toPolicy(BuildContext context) {
    context.pushNamed(policy);
  }

  /// Navigate to Notification Settings page
  void toNotificationSettings(BuildContext context) {
    context.pushNamed(notificationSettings);
  }

  /// Push a new route (can go back)
  void push(BuildContext context, String routeName, {Object? extra}) {
    context.pushNamed(routeName, extra: extra);
  }

  /// Replace current route (can't go back)
  void replace(BuildContext context, String routeName, {Object? extra}) {
    context.pushReplacementNamed(routeName, extra: extra);
  }

  /// Go to route (reset navigation stack)
  void go(BuildContext context, String routeName, {Object? extra}) {
    context.goNamed(routeName, extra: extra);
  }

  /// Pop current route
  void pop(BuildContext context, {dynamic result}) {
    if (context.canPop()) {
      context.pop(result);
    }
  }

  /// Pop until a specific route
  void popUntil(BuildContext context, String routeName) {
    while (context.canPop()) {
      context.pop();
      if (GoRouterState.of(context).name == routeName) {
        break;
      }
    }
  }

  /// Check if can pop
  bool canPop(BuildContext context) {
    return context.canPop();
  }

  /// Navigate with parameters
  void pushWithParams(
    BuildContext context,
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Object? extra,
  }) {
    context.pushNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// Navigate and clear all previous routes
  void clearAndPush(BuildContext context, String routeName) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(routeName);
  }

  /// Show dialog helper
  Future<T?> showDialogRoute<T>(BuildContext context, Widget dialog) {
    return showDialog<T>(context: context, builder: (context) => dialog);
  }

  /// Show bottom sheet helper
  Future<T?> showBottomSheetRoute<T>(BuildContext context, Widget sheet) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => sheet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

// Extension for easier access
extension NavigationManagerExtension on BuildContext {
  NavigationManager get nav => NavigationManager();
}
