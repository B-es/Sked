import 'package:flutter/material.dart';
import 'package:sked/data/models/subject_model.dart';
import 'package:sked/utils/extensions/build_context_ext.dart';

import 'place_holder.dart';
import 'subject_widget.dart';

class WeekSubjectsWidget extends StatelessWidget {
  const WeekSubjectsWidget({
    super.key,
    required this.dayName,
    required this.subjects,
  });

  final String dayName;
  final List<SubjectModel> subjects;

  @override
  Widget build(BuildContext context) {
    final borderColor = context.color.borderWeekSubjectColor;
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border(
            top: BorderSide.none, // Нет верхней границы
            left: BorderSide(color: borderColor, width: 2.0),
            right: BorderSide(color: borderColor, width: 2.0),
            bottom: BorderSide(color: borderColor, width: 2.0),
          ),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                dayName,
                style: context.text.appName.copyWith(fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(),
            getSubjectWidgetList(subjects)
          ],
        ),
      ),
    );
  }

  Widget getSubjectWidgetList(List<SubjectModel> subjects) {
    if (subjects.isEmpty) return PlaceHolder();

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: subjects.length,
      itemBuilder: (_, i) => SubjectWidget(
        model: subjects[i],
      ),
    );
  }
}
