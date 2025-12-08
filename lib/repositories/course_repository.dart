import 'dart:convert';

import 'package:education_app/model/course.dart';
import 'package:flutter/services.dart';

class CourseRepository {
  Future<List<Course>> loadCoursesTrending() async {
    final raw = await rootBundle.loadString('assets/jsons/courses.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;

    return (data['courses'] as List).map((e) => Course.fromJson(e)).toList()
      ..sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
  }

  Future<List<Course>> loadCoursesNew() async {
    final raw = await rootBundle.loadString('assets/jsons/courses.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;

    return (data['courses'] as List).map((e) => Course.fromJson(e)).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
