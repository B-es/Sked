import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sked/data/models/subject_model.dart';
import 'package:sked/providers/data_provider.dart';
import 'package:sked/utils/helpers.dart';

final todayModelsProvider = FutureProvider<List<SubjectModel>>((ref) async {
  final isInitialized = await ref.watch(dataInitializedProvider.future);
  final dataService = ref.read(dataServiceProvider);

  if (!isInitialized) {
    throw Exception('Data service not initialized');
  }

  return dataService.getTodayModels;
});

final todayWeekNumberProvider = StateProvider<int>((ref) {
  return getWeekNumber(1, 9);
});
