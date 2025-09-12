import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sked/providers/today_provider.dart';
import 'package:sked/subject_widget.dart';
import 'package:sked/utils/extensions/build_context_ext.dart';
import 'package:sked/utils/themes/theme.dart';

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayModelsAsync = ref.watch(todayModelsProvider);

    return todayModelsAsync.when(
        loading: () => CircularProgressIndicator(
              color: Colors.red,
            ),
        error: (error, stackTrace) => Text("Ошибка: $error"),
        data: (models) {
          if (models.isEmpty) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Отдыхай",
                  style: context.text.appName,
                ),
                Icon(
                  Icons.psychology,
                  color: context.text.appName.color,
                ),
              ],
            ));
          }

          return ListView.builder(
              itemCount: models.length,
              itemBuilder: (_, i) => SubjectWidget(model: models[i]));
        });
  }
}
