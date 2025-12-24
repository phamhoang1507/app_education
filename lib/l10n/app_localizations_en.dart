// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get allCourses => 'All Courses';

  @override
  String get sort => 'Sort';

  @override
  String get noData => 'No data';

  @override
  String get error => 'Error';

  @override
  String get newest => 'New';

  @override
  String get trending => 'Trending';

  @override
  String get price => 'Price';

  @override
  String get settings => 'Settings';

  @override
  String get notSet => '(not set)';

  @override
  String get journal => 'Journal';

  @override
  String get home => 'Home';

  @override
  String get percentTotal => '% total';

  @override
  String get avgTime => 'Avg. Time';

  @override
  String get sortBy => 'Sort by';

  @override
  String get noUsers => 'No users found';

  @override
  String get userId => 'User ID';

  @override
  String get department => 'Department';

  @override
  String get or => 'OR';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get confirmEmail => 'Confirm Email';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get errorPleaseEnterEmailAndPassword =>
      'Please enter both email and password!';

  @override
  String get errorPasswordEmpty => 'You haven\'t entered a password';

  @override
  String get emailNotMatch => 'Emails do not match';

  @override
  String get passwordNotMatch => 'Passwords do not match';

  @override
  String get confirmDeleteAccount => 'Confirm Account Deletion';

  @override
  String get deleteAccountPermanentWarning =>
      'Your account will be permanently deleted and cannot be recovered.';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get liveSubjectTutoring => 'Live Subject Tutoring';

  @override
  String get allSubjects => 'All Subjects';

  @override
  String get trendingCourses => 'Trending Courses';

  @override
  String get topInstructorOfWeek => 'Top Instructor of the Week';

  @override
  String get topNewCourses => 'Top New Courses';

  @override
  String get getLifetime => 'Get Lifetime';

  @override
  String get deal => 'Deal';

  @override
  String get accessAllCourses => 'Access to all on-demand courses';

  @override
  String get redeemNow => 'Redeem Now';

  @override
  String get errorLoadUser => 'Failed to load user';

  @override
  String get noPhoneNumber => 'No phone number';

  @override
  String get messages => 'Messages';

  @override
  String get tutorBookings => 'Tutor Bookings';

  @override
  String get myCourses => 'My Courses';

  @override
  String get ratingReviews => 'Rating & Reviews';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get errorEmptyEmailPass => 'Please enter both email and password!';

  @override
  String get errorInvalidCredentials => 'Email or password is incorrect';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get inputPassword => 'Input password';

  @override
  String get password => 'Password';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get pleaseEnterValidPassword => 'Please enter a valid password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get pleaseEnterPhone => 'Please enter your phone number';

  @override
  String get errorPhoneLength => 'Phone number must be 10-11 digits';

  @override
  String get errorPhoneDigitsOnly => 'Phone number must contain only digits';

  @override
  String get errorPhoneStartZero => 'Phone number must start with 0';

  @override
  String get errorInvalidPhone => 'Invalid phone number';

  @override
  String get continueText => 'Continue';

  @override
  String get loginWithPhone => 'Login with Phone Number';

  @override
  String get loginWithEmail => 'Login with Email';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get inputEmail => 'Input email';

  @override
  String get email => 'Email';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get payment => 'Payment';

  @override
  String get support => 'Support';

  @override
  String get loginSecurity => 'Login & Security';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get noUser => 'No user found';

  @override
  String get deleteAccountWarning =>
      'Your account will be permanently deleted and cannot be recovered.';

  @override
  String get errorMissingPassword => 'Please enter your password';

  @override
  String get deleteAccountSuccess => 'Account deleted successfully';

  @override
  String get errorConnection => 'Connection error. Please check your internet.';

  @override
  String get errorInvalidEmailFormat =>
      'Invalid email format. Please check again!';

  @override
  String get inputName => 'Input Name';

  @override
  String get name => 'Name';

  @override
  String get pleaseEnterName => 'Please enter your name';

  @override
  String get errorPasswordNotMatch => 'Password entered does not match.';

  @override
  String get signup => 'Signup';

  @override
  String get liveTutoring => 'Live Tutoring';

  @override
  String get allLiveSubjectTutoring => 'All Live Subject Tutoring';

  @override
  String get welcomeToEducatory => 'Welcome to Educatory';

  @override
  String get educatoryDescription =>
      'Your go-to platform for live sessions and on-demand courses. We\'re excited to help you learn and grow!';

  @override
  String get liveSessionWithTeachers => 'Live Session with Teachers';

  @override
  String get liveSessionDescription =>
      'Join live with top teachers. Session-based study with real-time feedback and support.';

  @override
  String get engageWithQuizzes => 'Engage with Quizzes';

  @override
  String get quizzesDescription =>
      'Test your knowledge with interactive quizzes. Track your progress and reinforce your learning!';

  @override
  String get skip => 'Skip';

  @override
  String tutorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tutors',
      one: '1 Tutor',
    );
    return '$_temp0';
  }

  @override
  String get beginner => 'Beginner';

  @override
  String get errorDefault => 'An error occurred. Please try again.';

  @override
  String get errorInvalidCredential =>
      'Login information is incorrect or expired. Please check and try again.';

  @override
  String get errorUserNotFound => 'Account does not exist.';

  @override
  String get errorWrongPassword => 'Incorrect password.';

  @override
  String get errorTooManyRequests => 'Too many attempts. Please wait 1 minute.';

  @override
  String get errorExpiredActionCode =>
      'Verification code has expired. Please request a new one.';

  @override
  String get errorInvalidPhoneFormat =>
      'Invalid phone number. Must start with 0 or +';

  @override
  String get search => 'Search';
}
