// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SubjectModel {
  final List<String> timeSlots;
  final String dayOfWeek;
  final int week;
  final String subject;
  final List<String> dates;
  final List<String> lecturer;
  final List<String> room;
  final List<String> groups;

  const SubjectModel({
    required this.timeSlots,
    required this.dayOfWeek,
    required this.week,
    required this.subject,
    required this.dates,
    required this.lecturer,
    required this.room,
    required this.groups,
  });

  SubjectModel copyWith({
    List<String>? timeSlots,
    String? dayOfWeek,
    int? week,
    String? subject,
    List<String>? dates,
    List<String>? lecturer,
    List<String>? room,
    List<String>? groups,
  }) {
    return SubjectModel(
      timeSlots: timeSlots ?? this.timeSlots,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      week: week ?? this.week,
      subject: subject ?? this.subject,
      dates: dates ?? this.dates,
      lecturer: lecturer ?? this.lecturer,
      room: room ?? this.room,
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time_slots': timeSlots,
      'day_of_week': dayOfWeek,
      'week': week,
      'subject': subject,
      'dates': dates,
      'lecturer': lecturer,
      'room': room,
      'groups': groups,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      timeSlots: List<String>.from((map['time_slots'].cast<String>())),
      dayOfWeek: map['day_of_week'] as String,
      week: map['week'] as int,
      subject: map['subject'] as String,
      dates: List<String>.from((map['dates'].cast<String>())),
      lecturer: List<String>.from((map['lecturer'].cast<String>())),
      room: List<String>.from((map['room'].cast<String>())),
      groups: List<String>.from((map['groups'].cast<String>())),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubjectModel(timeSlots: $timeSlots, dayOfWeek: $dayOfWeek, week: $week, subject: $subject, dates: $dates, lecturer: $lecturer, room: $room, groups: $groups)';
  }

  @override
  bool operator ==(covariant SubjectModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.timeSlots, timeSlots) &&
        other.dayOfWeek == dayOfWeek &&
        other.week == week &&
        other.subject == subject &&
        listEquals(other.dates, dates) &&
        listEquals(other.lecturer, lecturer) &&
        listEquals(other.room, room) &&
        listEquals(other.groups, groups);
  }

  @override
  int get hashCode {
    return timeSlots.hashCode ^
        dayOfWeek.hashCode ^
        week.hashCode ^
        subject.hashCode ^
        dates.hashCode ^
        lecturer.hashCode ^
        room.hashCode ^
        groups.hashCode;
  }
}
