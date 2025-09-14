// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sked/data/models/subject_model.dart';

class WeekSubjectModel {
  final String dayName;
  final List<SubjectModel> subjects;
  final String date;

  const WeekSubjectModel({
    required this.dayName,
    required this.subjects,
    required this.date,
  });

  WeekSubjectModel copyWith({
    String? dayName,
    List<SubjectModel>? subjects,
    String? date,
  }) {
    return WeekSubjectModel(
      dayName: dayName ?? this.dayName,
      subjects: subjects ?? this.subjects,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayName': dayName,
      'subjects': subjects.map((x) => x.toMap()).toList(),
      'date': date,
    };
  }

  factory WeekSubjectModel.fromMap(Map<String, dynamic> map) {
    return WeekSubjectModel(
      dayName: map['dayName'] as String,
      subjects: List<SubjectModel>.from(
        (map['subjects'] as List<int>).map<SubjectModel>(
          (x) => SubjectModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeekSubjectModel.fromJson(String source) =>
      WeekSubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeekSubjectModel(dayName: $dayName, subjects: $subjects, date: $date)';

  @override
  bool operator ==(covariant WeekSubjectModel other) {
    if (identical(this, other)) return true;

    return other.dayName == dayName &&
        listEquals(other.subjects, subjects) &&
        other.date == date;
  }

  @override
  int get hashCode => dayName.hashCode ^ subjects.hashCode ^ date.hashCode;
}
