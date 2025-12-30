import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/model/course.dart';
import 'package:education_app/repositories/course_repository.dart';
import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/utilities/all_card.dart';
import 'package:education_app/utilities/common_variables.dart';
import 'package:education_app/widgets/form_search.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late String selectedValue = 'new';
  Future<List<Course>>? courses;

  @override
  void initState() {
    courses = CourseRepository().getCoursesNew();
    super.initState();
  }

  Future<void> fetchCourses() async {
    final repo = CourseRepository();
    switch (selectedValue) {
      case 'new':
        courses = repo.getCoursesNew();
        break;
      case 'trending':
        courses = repo.getCoursesTrending();
        break;
      case 'price':
        courses = repo.getCoursesPrice();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n!;
    final List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(value: 'new', child: Text(l10n.newest)),
      DropdownMenuItem(value: 'trending', child: Text(l10n.trending)),
      DropdownMenuItem(value: 'price', child: Text(l10n.price)),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leadingWidth: 40,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp),
          color: Colors.black,
          onPressed: () => context.nav.pop(context),
        ),
        title: Text(
          l10n.allCourses,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: commonPaddingAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormSearch(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.allCourses,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(l10n.sort),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: selectedValue,
                          items: items,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                            fetchCourses();
                          },
                          underline: SizedBox(),
                          icon: Icon(Icons.keyboard_arrow_down, size: 20),
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                          dropdownColor: Colors.white,
                          menuMaxHeight: 300,
                          borderRadius: BorderRadius.circular(12),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<Course>>(
                  future: courses,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Lỗi: ${snapshot.error}'));
                    }
                    final List<Course> courses = snapshot.data ?? [];
                    if (courses.isEmpty) {
                      return Center(child: Text(l10n.noData));
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: courses
                            .map((course) => _buildCardCourse(context, course))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardCourse(BuildContext context, Course course) {
    final sizeImage = MediaQuery.of(context).size.width * 0.38;
    return Container(
      padding: EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(course.image),
                fit: BoxFit.cover,
              ),
            ),
            width: sizeImage,
            height: sizeImage,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: buildCourseDescription(context, course),
            ),
          ),
        ],
      ),
    );
  }
}
