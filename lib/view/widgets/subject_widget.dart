import 'package:flutter/material.dart';
import 'package:sked/data/models/subject_model.dart';
import 'package:sked/utils/extensions/build_context_ext.dart';
import 'package:sked/utils/helpers.dart';
import 'package:sked/utils/themes/theme.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({super.key, required this.model});

  final SubjectModel model;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: model.subject,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Stack(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                color: context.color.backgroundSubjectColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Opacity(
                  opacity: .7,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/tile_background.png"),
                      ),
                    ),
                    child: createTile(context),
                  ),
                ),
              ),
            ),
            createTile(context),
          ],
        ),
      ),
    );
  }

  Widget createTile(BuildContext context) {
    final times = convertHoursToTime(model.timeSlots);
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                times?.$1 ?? "",
                overflow: TextOverflow.ellipsis,
                style: context.text.appDisplay,
              ),
              Text(
                times?.$2 ?? "",
                overflow: TextOverflow.ellipsis,
                style: context.text.appSubLabel,
              ),
            ],
          ),
          VerticalDivider()
        ],
      ),
      title: Text(
        model.subject,
        overflow: TextOverflow.ellipsis,
        style: context.text.appDisplay,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final room in model.room)
                Text(
                  room,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.appLabel,
                ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final lecturer in model.lecturer)
                Text(
                  lecturer,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.appLabel,
                ),
            ],
          ),
        ],
      ),
      onTap: () {
        onTap(context);
      },
    );
  }

  void onTap(BuildContext context) {}
}
