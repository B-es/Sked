import 'package:flutter/widgets.dart';
import 'package:sked/data/services/data_service.dart';
import 'package:test/test.dart';

void main() {
  group("Загрузка и проверка", () {
    WidgetsFlutterBinding.ensureInitialized();
    test("Инициализация", () async {
      final dataService = DataService();
      final bool res = await dataService.initData();

      expect(res, true);
    });

    test("Загрузка данных", () async {
      final dataService = DataService();
      await dataService.initData();
      expect(dataService.models.length, 95);
    });

    test("Получение сегодняшних моделей", () async {
      final dataService = DataService();
      await dataService.initData();
      final models = dataService.getTodayModels;
      expect(models.length, 0);
    });
  });
}
