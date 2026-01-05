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

  Future<List<Course>> getCoursesByKeys(
    int? subjectId,
    int? level,
    int rate,
    int fromPrice,
    int toPrice,
    int ?duration,
    int ?released,
  ) async {
    try {
      final hourrange = duration != null ? getHourRange(duration) : null;
      final fromDate = released != null ? getReleasedDate(released) : null;
      final query = await _db
          .collection('courses')
          .where('subjectId', isEqualTo: subjectId)
          .where('level', isEqualTo: level)
          .where('rating', isGreaterThanOrEqualTo: rate)
          .where('price', isGreaterThanOrEqualTo: fromPrice)
          .where('price', isLessThanOrEqualTo: toPrice)
          .where('duration', isGreaterThanOrEqualTo: hourrange?['min'])
          .where('duration', isLessThan: hourrange?['max'])
          .where('createdAt', isGreaterThanOrEqualTo: fromDate)
          .orderBy('rating', descending: true)
          .orderBy('reviewCount', descending: true)
          .get();
      final courses = query.docs.map((e) => Course.fromJson(e)).toList();
      return courses;
    } catch (e) {
      print('Lỗi: $e');
      return List.empty();
    }
  }

  Map<String, double> getHourRange(int id) {
    double min = 0;
    double max = 24;

    switch (id) {
      case 1:
        min = 0;
        max = 1;
        break;
      case 2:
        min = 1;
        max = 3;
        break;
      case 3:
        min = 3;
        max = 6;
        break;
      case 4:
        min = 6;
        max = 24;
        break;
    }

    return {'min': min, 'max': max};
  }

  Timestamp getReleasedDate(int id) {
    final now = DateTime.now().toUtc();
    DateTime targetDate;

    switch (id) {
      case 1:
        targetDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case 2:
        targetDate = DateTime(now.year, now.month - 6, now.day);
        break;
      case 3:
        targetDate = DateTime(now.year - 1, now.month, now.day);
        break;
      case 4:
        targetDate = DateTime(now.year - 100, now.month, now.day);
        break;
      default:
        targetDate = now;
    }

    return Timestamp.fromDate(targetDate);
  }
}
