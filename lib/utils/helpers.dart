const Map<String, (String, String)> _mapHours = {
  "1-2": ("8:30", "10:00"),
  "3-4": ("10:10", "11:40"),
  "5-6": ("11:50", "13:20"),
  "7-8": ("13:40", "15:10"),
  "9-10": ("15:20", "16:50"),
  "11-12": ("17:00", "18:30"),
};

(String, String)? convertHoursToTime(final List<String> timeSlots) {
  final first = _mapHours[timeSlots.first]!.$1;
  final last = _mapHours[timeSlots.last]!.$2;

  return (first, last);
}

const days = [
  'ПОНЕДЕЛЬНИК', // 1
  'ВТОРНИК', // 2
  'СРЕДА', // 3
  'ЧЕТВЕРГ', // 4
  'ПЯТНИЦА', // 5
  'СУББОТА', // 6
  'ВОСКРЕСЕНЬЕ' // 7
];

String getWeekdayName(int weekday) {
  if (weekday >= 1 && weekday <= 7) {
    return days[weekday - 1];
  } else {
    throw ArgumentError('Weekday must be between 1 and 7');
  }
}

int getWeekNumber(int startDay, int startMonth) {
  final now = DateTime.now();
  final startDate = DateTime(now.year, startMonth, startDay);

  // Разница в днях от начала обучения
  final difference = now.difference(startDate).inDays;

  if (difference < 0) {
    // Если дата еще не наступила, считаем от предыдущего года
    final prevStartDate = DateTime(now.year - 1, startMonth, startDay);
    final prevDifference = now.difference(prevStartDate).inDays;
    return (prevDifference ~/ 7) % 2 + 1;
  }

  // Вычисляем номер недели (1 или 2)
  return (difference ~/ 7) % 2 + 1;
}
