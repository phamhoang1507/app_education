import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @allCourses.
  ///
  /// In en, this message translates to:
  /// **'All Courses'**
  String get allCourses;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newest;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'(not set)'**
  String get notSet;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @percentTotal.
  ///
  /// In en, this message translates to:
  /// **'% total'**
  String get percentTotal;

  /// No description provided for @avgTime.
  ///
  /// In en, this message translates to:
  /// **'Avg. Time'**
  String get avgTime;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @noUsers.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsers;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueWithFacebook;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @confirmEmail.
  ///
  /// In en, this message translates to:
  /// **'Confirm Email'**
  String get confirmEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @errorPleaseEnterEmailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password!'**
  String get errorPleaseEnterEmailAndPassword;

  /// No description provided for @errorPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t entered a password'**
  String get errorPasswordEmpty;

  /// No description provided for @emailNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Emails do not match'**
  String get emailNotMatch;

  /// No description provided for @passwordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordNotMatch;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Confirm Account Deletion'**
  String get confirmDeleteAccount;

  /// No description provided for @deleteAccountPermanentWarning.
  ///
  /// In en, this message translates to:
  /// **'Your account will be permanently deleted and cannot be recovered.'**
  String get deleteAccountPermanentWarning;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @liveSubjectTutoring.
  ///
  /// In en, this message translates to:
  /// **'Live Subject Tutoring'**
  String get liveSubjectTutoring;

  /// No description provided for @allSubjects.
  ///
  /// In en, this message translates to:
  /// **'All Subjects'**
  String get allSubjects;

  /// No description provided for @trendingCourses.
  ///
  /// In en, this message translates to:
  /// **'Trending Courses'**
  String get trendingCourses;

  /// No description provided for @topInstructorOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Top Instructor of the Week'**
  String get topInstructorOfWeek;

  /// No description provided for @topNewCourses.
  ///
  /// In en, this message translates to:
  /// **'Top New Courses'**
  String get topNewCourses;

  /// No description provided for @getLifetime.
  ///
  /// In en, this message translates to:
  /// **'Get Lifetime'**
  String get getLifetime;

  /// No description provided for @deal.
  ///
  /// In en, this message translates to:
  /// **'Deal'**
  String get deal;

  /// No description provided for @accessAllCourses.
  ///
  /// In en, this message translates to:
  /// **'Access to all on-demand courses'**
  String get accessAllCourses;

  /// No description provided for @redeemNow.
  ///
  /// In en, this message translates to:
  /// **'Redeem Now'**
  String get redeemNow;

  /// No description provided for @errorLoadUser.
  ///
  /// In en, this message translates to:
  /// **'Failed to load user'**
  String get errorLoadUser;

  /// No description provided for @noPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'No phone number'**
  String get noPhoneNumber;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @tutorBookings.
  ///
  /// In en, this message translates to:
  /// **'Tutor Bookings'**
  String get tutorBookings;

  /// No description provided for @myCourses.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get myCourses;

  /// No description provided for @ratingReviews.
  ///
  /// In en, this message translates to:
  /// **'Rating & Reviews'**
  String get ratingReviews;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @errorEmptyEmailPass.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password!'**
  String get errorEmptyEmailPass;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get errorInvalidCredentials;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @inputPassword.
  ///
  /// In en, this message translates to:
  /// **'Input password'**
  String get inputPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseEnterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid password'**
  String get pleaseEnterValidPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @errorPhoneLength.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 10-11 digits'**
  String get errorPhoneLength;

  /// No description provided for @errorPhoneDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain only digits'**
  String get errorPhoneDigitsOnly;

  /// No description provided for @errorPhoneStartZero.
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with 0'**
  String get errorPhoneStartZero;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get errorInvalidPhone;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @loginWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Login with Phone Number'**
  String get loginWithPhone;

  /// No description provided for @loginWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Login with Email'**
  String get loginWithEmail;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @inputEmail.
  ///
  /// In en, this message translates to:
  /// **'Input email'**
  String get inputEmail;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @loginSecurity.
  ///
  /// In en, this message translates to:
  /// **'Login & Security'**
  String get loginSecurity;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @noUser.
  ///
  /// In en, this message translates to:
  /// **'No user found'**
  String get noUser;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Your account will be permanently deleted and cannot be recovered.'**
  String get deleteAccountWarning;

  /// No description provided for @errorMissingPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get errorMissingPassword;

  /// No description provided for @deleteAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get deleteAccountSuccess;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet.'**
  String get errorConnection;

  /// No description provided for @errorInvalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format. Please check again!'**
  String get errorInvalidEmailFormat;

  /// No description provided for @inputName.
  ///
  /// In en, this message translates to:
  /// **'Input Name'**
  String get inputName;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @errorPasswordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password entered does not match.'**
  String get errorPasswordNotMatch;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @liveTutoring.
  ///
  /// In en, this message translates to:
  /// **'Live Tutoring'**
  String get liveTutoring;

  /// No description provided for @allLiveSubjectTutoring.
  ///
  /// In en, this message translates to:
  /// **'All Live Subject Tutoring'**
  String get allLiveSubjectTutoring;

  /// No description provided for @welcomeToEducatory.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Educatory'**
  String get welcomeToEducatory;

  /// No description provided for @educatoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Your go-to platform for live sessions and on-demand courses. We\'re excited to help you learn and grow!'**
  String get educatoryDescription;

  /// No description provided for @liveSessionWithTeachers.
  ///
  /// In en, this message translates to:
  /// **'Live Session with Teachers'**
  String get liveSessionWithTeachers;

  /// No description provided for @liveSessionDescription.
  ///
  /// In en, this message translates to:
  /// **'Join live with top teachers. Session-based study with real-time feedback and support.'**
  String get liveSessionDescription;

  /// No description provided for @engageWithQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Engage with Quizzes'**
  String get engageWithQuizzes;

  /// No description provided for @quizzesDescription.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge with interactive quizzes. Track your progress and reinforce your learning!'**
  String get quizzesDescription;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @tutorCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Tutor} other{{count} Tutors}}'**
  String tutorCount(int count);

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @errorDefault.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorDefault;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Login information is incorrect or expired. Please check and try again.'**
  String get errorInvalidCredential;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account does not exist.'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get errorWrongPassword;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait 1 minute.'**
  String get errorTooManyRequests;

  /// No description provided for @errorExpiredActionCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code has expired. Please request a new one.'**
  String get errorExpiredActionCode;

  /// No description provided for @errorInvalidPhoneFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number. Must start with 0 or +'**
  String get errorInvalidPhoneFormat;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @lookingFor.
  ///
  /// In en, this message translates to:
  /// **'I\'m looking for'**
  String get lookingFor;

  /// No description provided for @tutors.
  ///
  /// In en, this message translates to:
  /// **'Tutors'**
  String get tutors;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @selectSubject.
  ///
  /// In en, this message translates to:
  /// **'Select Subject'**
  String get selectSubject;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @timeslots.
  ///
  /// In en, this message translates to:
  /// **'Timeslots'**
  String get timeslots;

  /// No description provided for @tutoringExperience.
  ///
  /// In en, this message translates to:
  /// **'Tutoring Experience'**
  String get tutoringExperience;

  /// No description provided for @selectExperience.
  ///
  /// In en, this message translates to:
  /// **'Select Experience'**
  String get selectExperience;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @starsAndUp.
  ///
  /// In en, this message translates to:
  /// **'{rating} Stars and up'**
  String starsAndUp(Object rating);

  /// No description provided for @hourlyRate.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate'**
  String get hourlyRate;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @filteredResults.
  ///
  /// In en, this message translates to:
  /// **'Filtered Results'**
  String get filteredResults;

  /// No description provided for @allTutors.
  ///
  /// In en, this message translates to:
  /// **'All Tutors'**
  String get allTutors;

  /// No description provided for @noTutorsFound.
  ///
  /// In en, this message translates to:
  /// **'No tutors found'**
  String get noTutorsFound;

  /// No description provided for @pricePerHour.
  ///
  /// In en, this message translates to:
  /// **'\${price}/hr'**
  String pricePerHour(Object price);

  /// No description provided for @errorSelectAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one day'**
  String get errorSelectAtLeastOneDay;

  /// No description provided for @errorSelectAtLeastOneTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one time slot during the day'**
  String get errorSelectAtLeastOneTimeSlot;

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{time}hr'**
  String durationHours(Object time);

  /// No description provided for @noCoursesFound.
  ///
  /// In en, this message translates to:
  /// **'No courses found'**
  String get noCoursesFound;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
