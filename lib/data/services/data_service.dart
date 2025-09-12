import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sked/data/models/subject_model.dart';

class DataService {
  final String jsonDataPath = "assets/formatted.json";
  late final List<SubjectModel> models;

  Future<bool> initData() async {
    try {
      final String jsonString = await rootBundle.loadString(jsonDataPath);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> rowData = jsonData['schedule_data'] ?? [];
      models = [
        for (Map<String, dynamic> object in rowData)
          SubjectModel.fromMap(object)
      ];
      return true;
    } catch (e) {
      print('Ошибка чтения файла: $e');
      return false;
    }
  }

  final String groupName = "САПР-1.1";

  List<SubjectModel> get getTodayModels {
    DateTime now = DateTime.now();
    List<SubjectModel> resModels = [];
    for (final SubjectModel model in models) {
      final bool isContained = model.dates.contains("${now.day}.${now.month}");
      final bool isSapr11 = model.groups.contains(groupName);
      if (isContained && isSapr11) resModels.add(model);
    }

    return resModels;
  }
}
