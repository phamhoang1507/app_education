import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/model/subject.dart';
import 'package:flutter/services.dart';

class SubjectRepository {
  final _db = FirebaseFirestore.instance;
  Future<List<Subject>> loadSubject() async {
    final raw = await rootBundle.loadString('assets/jsons/subjects.json');
    final subjects = jsonDecode(raw) as List<dynamic>;

    return subjects.map((e) => Subject.fromJson(e)).toList();
  }

  Future<List<Subject>> getSubject() async {
    try {
      final query = await _db.collection('subjects').get();
      final subjects = query.docs.map((e) => Subject.fromJson(e)).toList();

      return subjects;
    } catch (e) {
      print('Lỗi: $e');
      return List.empty();
    }
  }
}
