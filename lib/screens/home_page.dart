import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/main.dart';
import 'package:education_app/model/course.dart';
import 'package:education_app/model/instructor.dart';
import 'package:education_app/model/subject.dart';
import 'package:education_app/model/user.dart';
import 'package:education_app/repositories/course_repository.dart';
import 'package:education_app/repositories/instructor_repository.dart';
import 'package:education_app/repositories/subject_repository.dart';
import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/services/auth_service.dart';
import 'package:education_app/utilities/all_card.dart';
import 'package:education_app/widgets/button_icon_text.dart';
import 'package:education_app/widgets/form_search.dart';
import 'package:education_app/widgets/tilte_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final subjectRepo = SubjectRepository();
    final courseRepo = CourseRepository();
    final instructorRepo = InstructorRepository();
    final l10n = context.l10n;
    final local = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            _openLeftMenu(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                if (local == Locale('en')) {
                  MyApp.setLocale(context, Locale('vi'));
                } else {
                  MyApp.setLocale(context, Locale('en'));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  local == Locale('vi') ? '🇬🇧' : '🇻🇳',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          // 🔔 Nút thông báo có badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                print('noti');
              },
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -6, end: -4),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFF9547ED), // tím nhạt
                  padding: EdgeInsets.all(5),
                ),
                badgeContent: const Text(
                  '5',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12, left: 4),
            child: GestureDetector(
              onTap: () {
                print('cart');
                context.nav.toLogin(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  child: Form(
                    child: FormSearch(
                      onTap: () {
                        context.nav.toFilter(context);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TilteSlider(
                  title: l10n.liveSubjectTutoring,
                  textName: l10n.allSubjects,
                  datas: subjectRepo.getSubject(),
                  slide: (data) => buildSubjectCard(context, data as Subject),
                  onTap: () {
                    context.nav.toSubject(context);
                  },
                ),
                SizedBox(height: 50),
                buildBannerSection(context),
                SizedBox(height: 15),
                TilteSlider(
                  title: l10n.trendingCourses,
                  textName: l10n.allCourses,
                  datas: courseRepo.getCoursesTrending(),
                  slide: (data) => buildCourseCard(context, data as Course),
                  onTap: () {
                    context.nav.toCourses(context);
                  },
                ),
                SizedBox(height: 15),
                TilteSlider(
                  title: l10n.topInstructorOfWeek,
                  datas: instructorRepo.getInstructors(),
                  slide: (data) => buildInstructorCard(data as Instructor),
                ),
                SizedBox(height: 15),
                TilteSlider(
                  title: l10n.topNewCourses,
                  textName: l10n.allCourses,
                  datas: courseRepo.getCoursesNew(),
                  slide: (data) => buildCourseCard(context, data as Course),
                  onTap: () {
                    context.nav.toCourses(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBannerSection(BuildContext context) {
    final l10n = context.l10n!;
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEC4899), Color(0xFF9547ED)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 10,
            bottom: 0,
            child: SizedBox(
              width: 150,
              height: 185,
              child: ClipRect(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/banner.png'),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.getLifetime,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          l10n.deal,
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFFFD700),
                            decorationThickness: 2,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      l10n.accessAllCourses,
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    l10n.redeemNow,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openLeftMenu(BuildContext context) {
    final auth = AuthServices();
    final user = FirebaseAuth.instance.currentUser!;
    final myUser = auth.getUser(user.uid);
    final l10n = context.l10n;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondary, child) {
        final slide = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        return SlideTransition(
          position: slide,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: double.infinity,
              color: Colors.white,
              child: FutureBuilder<UserModel?>(
                future: myUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Scaffold(
                            backgroundColor: HexColor('#FFFFFF'),
                            body: Container(),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Scaffold(backgroundColor: HexColor('#0F172A')),
                        ),
                      ],
                    );
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text(l10n.errorLoadUser));
                  }
                  final data = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Scaffold(
                          backgroundColor: HexColor('#FFFFFF'),
                          body: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 30,
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 40),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage: data.photoURL != null
                                      ? NetworkImage(data.photoURL!)
                                      : null,
                                  child: data.photoURL == null
                                      ? Icon(
                                          Icons.account_circle_sharp,
                                          size: 80,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  data.displayName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  data.email,
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  data.phoneNumber ?? l10n.noPhoneNumber,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Scaffold(
                          backgroundColor: HexColor('#0F172A'),
                          body: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                ButtonIconText(
                                  text: l10n.home,
                                  icon: Icons.home_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: l10n.messages,
                                  icon: Icons.chat_bubble_outline,
                                  color: Colors.white,
                                  onTap: () {},
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: l10n.tutorBookings,
                                  icon: Icons.list_outlined,
                                  color: Colors.white,
                                  onTap: () {},
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: l10n.myCourses,
                                  icon: Icons.menu_book_outlined,
                                  color: Colors.white,
                                  onTap: () {},
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: l10n.ratingReviews,
                                  icon: Icons.star_border_outlined,
                                  color: Colors.white,
                                  onTap: () {},
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: l10n.profile,
                                  icon: Icons.person_outline_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    context.nav.toProfile(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: l10n.logout,
                                  icon: Icons.logout_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    auth.signOut();
                                    context.nav.toLogin(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
