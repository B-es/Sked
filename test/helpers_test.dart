import 'package:flutter/widgets.dart';
import 'package:sked/data/services/data_service.dart';
import 'package:sked/utils/helpers.dart';
import 'package:test/test.dart';

void main() {
  group("Полезные функции", () {
    WidgetsFlutterBinding.ensureInitialized();
    test("Конвертация номеров часов во время", () async {
      List<String> hours = ["3-4"];
      final result = convertHoursToTime(hours);

      expect(result, ("10:10", "11:40"));
    });

    test("Получение название дня недели по номеру", () async {
      final result = getWeekdayName(1);
      expect(result, "ПОНЕДЕЛЬНИК");
    });

    test("Получение номера учебной недели", () async {
      final result = getWeekNumber(1, 9, DateTime(2025, 9, 13));
      expect(result, 2);
    });

    test("Получение  списка дней с понедельника по субботу на основе дня",
        () async {
      final date = DateTime(2025, 9, 20);
      final result = generateWeekDaysList(date);
      expect(result.length, 6);
      expect(result[0], "15.09");
    });
  });
}
