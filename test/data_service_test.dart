import 'package:flutter/widgets.dart';
import 'package:sked/data/services/data_service.dart';
import 'package:test/test.dart';

void main() {
  group("Загрузка и проверка", () {
    WidgetsFlutterBinding.ensureInitialized();

    final dataService = DataService();
    late final bool res;

    setUpAll(() async {
      res = await dataService.initData();
    });

    test("Инициализация", () async {
      expect(res, true);
    });

    test("Загрузка данных", () async {
      expect(dataService.models.length, 95);
    });

    test("Получение сегодняшних моделей", () async {
      final models = dataService.getTodayModels;
      expect(models.length, 0);
    });

    test("Получение моделей недели", () async {
      final models = dataService.getWeekModels(1);
      expect(models.length, 7);
    });
  });
}
