import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sked/data/services/data_service.dart';

final dataServiceProvider = Provider<DataService>((ref) {
  return DataService();
});

final dataInitializedProvider = FutureProvider<bool>((ref) async {
  final dataService = ref.read(dataServiceProvider);
  return await dataService.initData();
});
