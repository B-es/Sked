import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sked/providers/week_provider.dart';
import 'package:sked/view/widgets/load_indicator.dart';
import 'package:sked/view/widgets/place_holder.dart';
import 'package:sked/view/widgets/week_subject_widget.dart';

class WeekPage extends ConsumerStatefulWidget {
  const WeekPage({super.key});

  @override
  ConsumerState<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends ConsumerState<WeekPage> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final AsyncValue weekModelsAsync = ref.watch(weekModelsProvider);
    final currentDate = ref.watch(currentDateProvider);

    return weekModelsAsync.when(
        loading: () => LoadIndicator(),
        error: (error, stackTrace) => Text("Ошибка: $error"),
        data: (models) {
          if (models.isEmpty) {
            return PlaceHolder();
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (itemScrollController.isAttached) {
              itemScrollController.scrollTo(
                index:
                    currentDate.weekday - 1 == 6 ? 0 : currentDate.weekday - 1,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubicEmphasized,
              );
            }
          });

          return Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: ScrollablePositionedList.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemScrollController: itemScrollController,
              itemCount: models.length,
              itemBuilder: (_, i) => WeekSubjectsWidget(
                model: models[i],
              ),
            ),
          );
        });
  }
}
