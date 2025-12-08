import 'dart:convert';

import 'package:education_app/model/instructor.dart';
import 'package:flutter/services.dart';

class InstructorRepository {
  Future<List<Instructor>> loadInstructor() async{
    final raw = await rootBundle.loadString('assets/jsons/instructor.json');
    final datas = jsonDecode(raw) as List<dynamic>;

    return datas.map((e) => Instructor.fromJson(e)).toList();
  }
}