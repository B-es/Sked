import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sked/providers/today_provider.dart';
import 'package:sked/view/widgets/load_indicator.dart';
import 'package:sked/view/widgets/place_holder.dart';
import 'package:sked/view/widgets/subject_widget.dart';

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayModelsAsync = ref.watch(todayModelsProvider);

    return todayModelsAsync.when(
        loading: () => LoadIndicator(),
        error: (error, stackTrace) => Text("Ошибка: $error"),
        data: (models) {
          if (models.isEmpty) {
            return PlaceHolder();
          }

          return ListView.builder(
              itemCount: models.length,
              itemBuilder: (_, i) => SubjectWidget(model: models[i]));
        });
  }
}
