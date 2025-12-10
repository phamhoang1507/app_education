import 'package:education_app/model/course.dart';
import 'package:education_app/model/instructor.dart';
import 'package:education_app/model/subject.dart';
import 'package:education_app/model/user.dart';
import 'package:education_app/repositories/course_repository.dart';
import 'package:education_app/repositories/instructor_repository.dart';
import 'package:education_app/repositories/subject_repository.dart';
import 'package:education_app/services/auth_service.dart';
import 'package:education_app/widgets/button_icon_text.dart';
import 'package:education_app/widgets/tilte_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

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
                context.go('/login');
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
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 1,
                                height: 24,
                                color: Colors.grey,
                                margin: const EdgeInsets.only(right: 8.0),
                              ),
                              SvgPicture.asset(
                                'assets/images/adjustments-horizontal.svg',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TilteSlider(
                  title: 'Live Subject Tutoring',
                  textName: "All Subjects",
                  datas: subjectRepo.loadSubject(),
                  slide: (data) => _buildSubjectCard(data as Subject),
                ),
                SizedBox(height: 50),
                _buildBannerSection(context),
                SizedBox(height: 15),
                TilteSlider(
                  title: 'Trending Courses',
                  textName: "All Courses",
                  datas: courseRepo.loadCoursesTrending(),
                  slide: (data) => _buildCourseCard(data as Course),
                ),
                SizedBox(height: 15),
                TilteSlider(
                  title: 'Top Instructor of the Week',
                  datas: instructorRepo.loadInstructor(),
                  slide: (data) => _buildInstructorCard(data as Instructor),
                ),
                SizedBox(height: 15),
                TilteSlider(
                  title: 'Top New Courses',
                  textName: "All Courses",
                  datas: courseRepo.loadCoursesNew(),
                  slide: (data) => _buildCourseCard(data as Course),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context) {
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
                          'Get Lifetime ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Deal',
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
                      'Access to all on-demand courses',
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
                    'Redeem Now',
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

  Widget _buildSubjectCard(Subject subject) {
    return Container(
      width: 170,
      height: 90,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [HexColor(subject.startColor), HexColor(subject.endColor)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: HexColor(subject.endColor).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(getIcon(subject.icon), size: 80),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Icon(
                    getIcon(subject.icon),
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      ' - ${subject.tutorCount} Tutor',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 230,
          height: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(course.image, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        Text(
          course.title,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(course.instructor),
            Text(' - '),
            Text(course.duration),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: 230,
          height: 1,
          color: Colors.grey,
          margin: const EdgeInsets.only(right: 8.0),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 230,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${course.price.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(" \$${course.originalPrice.toStringAsFixed(0)}"),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: HexColor('FB923C')),
                  Text(course.rating.toString()),
                  SizedBox(width: 5),
                  Text(
                    '(${NumberFormat('#,###').format(course.reviewCount).toString()})',
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: !course.level.contains('Beginner')
                ? Color(0xFFE7D5FF)
                : HexColor('#DCFCE7'),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(course.level),
        ),
      ],
    );
  }

  Widget _buildInstructorCard(Instructor instructor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      width: 170,
      height: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipOval(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                child: Image.asset(instructor.image),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            instructor.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            instructor.subject,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _openLeftMenu(BuildContext context) {
    final auth = AuthServices();
    final user = FirebaseAuth.instance.currentUser!;
    final myUser = auth.getUser(user.uid);
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
                    return Center(child: Text("Không tải được user"));
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
                                  backgroundImage: data.photoURL != null
                                      ? NetworkImage(data.photoURL!)
                                      : null,
                                  child: data.photoURL == null
                                      ? Icon(Icons.account_circle_sharp)
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
                                  data.phoneNumber ?? "Không số điện thoại",
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
                                SizedBox(height: 15,),
                                ButtonIconText(
                                  text: 'Home',
                                  icon: Icons.home_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: 'Messages',
                                  icon: Icons.chat_bubble_outline,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: 'Tutor Bookings',
                                  icon: Icons.list_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: 'My Courses',
                                  icon: Icons.menu_book_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: 'Rating & Reviews',
                                  icon: Icons.star_border_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: 'Profile',
                                  icon: Icons.person_outline_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                ButtonIconText(
                                  text: 'Logout',
                                  icon: Icons.logout_outlined,
                                  color: Colors.white,
                                  onTap: () {
                                    Navigator.pop(context);
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

  IconData getIcon(String icon) {
    switch (icon) {
      case 'calculate':
        return Icons.calculate;
      case 'architecture':
        return Icons.architecture;
      case 'science':
        return Icons.science;
      case 'flash_on':
        return Icons.flash_on;
      default:
        return Icons.computer;
    }
  }
}
