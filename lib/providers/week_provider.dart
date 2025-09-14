import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sked/data/models/week_subject_model.dart';
import 'package:sked/providers/data_provider.dart';
import 'package:sked/utils/helpers.dart';

final weekModelsProvider = FutureProvider<List<WeekSubjectModel>>((ref) async {
  final isInitialized = await ref.read(dataInitializedProvider.future);
  final dataService = ref.read(dataServiceProvider);

  if (!isInitialized) {
    throw Exception('Data service not initialized');
  }

  DateTime date = ref.watch(currentDateProvider);

  int weekNumber = getWeekNumber(1, 9, date);

  final data = dataService.getWeekModels(weekNumber, date);

  return data;
});

final currentDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
