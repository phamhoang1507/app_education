import 'dart:convert';

import 'package:flutter/services.dart';

class WeekdaysRepository {
  Future<List<dynamic>> loadWeekdays() async {
    final raw = await rootBundle.loadString('assets/jsons/weekdays.json');
    final datas = jsonDecode(raw) as List<dynamic>;

    return datas;
  }
}