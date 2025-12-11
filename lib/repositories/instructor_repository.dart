import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/model/instructor.dart';
import 'package:flutter/services.dart';

class InstructorRepository {
  final _db = FirebaseFirestore.instance;
  Future<List<Instructor>> loadInstructor() async {
    final raw = await rootBundle.loadString('assets/jsons/instructor.json');
    final datas = jsonDecode(raw) as List<dynamic>;

    return datas.map((e) => Instructor.fromJson(e)).toList();
  }

  Future<List<Instructor>> getInstructors() async {
    try {
      final query = await _db.collection('instructor').orderBy('rating', descending: true).orderBy('reviewCount', descending: true).get();
      final instructors = query.docs
          .map((e) => Instructor.fromJson(e))
          .toList();
      return instructors;
    } catch (e) {
      print('Lỗi: $e');
      return List.empty();
    }
  }
}
