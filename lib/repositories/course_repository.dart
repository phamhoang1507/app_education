import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/model/course.dart';
import 'package:flutter/services.dart';

class CourseRepository {
  final _db = FirebaseFirestore.instance;
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

  Future<List<Course>> getCoursesTrending() async {
    try {
      final query = await _db
          .collection('courses')
          .orderBy('reviewCount', descending: true)
          .get();
      final courses = query.docs.map((e) => Course.fromJson(e)).toList();
      return courses;
    } catch (e) {
      print('Lỗi: $e');
      return List.empty();
    }
  }

  Future<List<Course>> getCoursesNew() async {
    try {
      final query = await _db
          .collection('courses')
          .orderBy('createdAt', descending: true)
          .get();
      final courses = query.docs.map((e) => Course.fromJson(e)).toList();
      return courses;
    } catch (e) {
      print('Lỗi: $e');
      return List.empty();
    }
  }

  Future<List<Course>> getCoursesPrice() async {
    try {
      final query = await _db
          .collection('courses')
          .orderBy('price', descending: true)
          .get();
      final courses = query.docs.map((e) => Course.fromJson(e)).toList();
      return courses;
    } catch (e) {
      print('Lỗi: $e');
      return List.empty();
    }
  }
}
