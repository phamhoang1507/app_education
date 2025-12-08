import 'dart:convert';

import 'package:education_app/model/subject.dart';
import 'package:flutter/services.dart';

class SubjectRepository {
  Future<List<Subject>> loadSubject() async {
    final raw = await rootBundle.loadString('assets/jsons/subjects.json');
    final subjects = jsonDecode(raw) as List<dynamic>;

    return subjects.map((e) => Subject.fromJson(e)).toList();
  }
}