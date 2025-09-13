import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sked/data/models/subject_model.dart';
import 'package:sked/providers/data_provider.dart';
import 'package:sked/utils/helpers.dart';

final weekModelsProvider =
    FutureProvider.family<Map<String, List<SubjectModel>>, DateTime>(
        (ref, final DateTime date) async {
  final isInitialized = await ref.read(dataInitializedProvider.future);
  final dataService = ref.read(dataServiceProvider);

  if (!isInitialized) {
    throw Exception('Data service not initialized');
  }

  final data = dataService.getWeekModels(getWeekNumber(1, 9, date));
  print(data);
  return data;
});

final currentDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
