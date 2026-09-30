# Sked

Мобильное приложение для просмотра расписания **ВолгГТУ** (Волгоградский государственный технический университет).

Расписание не запрашивается по сети — оно лежит в приложении как готовый JSON-ассет и фильтруется на клиенте по группе и дате. Реализованы два рабочих экрана — «Сегодня» и «Неделя» — с переключением светлой/тёмной темы и листанием учебных недель.

- Версия: `1.0.3+4` (`pubspec.yaml:4`)
- Платформа: Android (`applicationId` — `com.rddh.sked`)
- Пакет Dart: `package:sked`

---

## Возможности

| Экран | Что делает |
| --- | --- |
| **Сегодня** | список пар на текущую дату; пустой день → заглушка «Отдыхай» |
| **Неделя** | 6 карточек (Пн–Сб) с парами и датами; автоматическая прокрутка к текущему дню недели |
| **Месяц** | заглушка, экран не реализован |
| **Тема** | переключение светлая/тёмная иконкой палитры в AppBar (по умолчанию — тёмная) |
| **Навигация по неделям** | стрелки `←`/`→` в шапке (доступны только на экране «Неделя») сдвигают текущую дату на ±7 дней и пересчитывают номер учебной недели |

Номер учебной недели считается от **1 сентября**: `getWeekNumber(1, 9, date)` возвращает `1` или `2` (числитель/знаменатель) в зависимости от чётности количества недель от начала семестра.

---

## Стек

| Зависимость | Версия | Зачем |
| --- | --- | --- |
| Flutter / Dart SDK | `>=3.3.1 <4.0.0` (`pubspec.yaml:7`) | платформа |
| `flutter_riverpod` | `^3.0.0` | состояние и DI (`Provider`, `FutureProvider`, `StateProvider` из `flutter_riverpod/legacy.dart`) |
| `scrollable_positioned_list` | `^0.3.8` | программная прокрутка списка недели к текущему дню |
| `floating_bottom_navigation_bar` | `^1.5.2` | плавающий нижний навбар |
| `cupertino_icons` | `^1.0.6` | иконки |
| `flutter_lints` + `custom_lint` + `riverpod_lint` | `^6.0.0` / `^0.8.0` / `^3.0.0` | линт и анализ |
| `flutter_launcher_icons` | `^0.14.4` | генерация иконки запуска из `assets/icon/icon.png` |

Android-часть: Gradle **8.4**, Android Gradle Plugin **8.3.0**, Kotlin **1.7.10** (`android/settings.gradle:22-24`).

---

## Быстрый старт

```bash
flutter pub get
flutter run                  # debug на подключённом устройстве/эмуляторе
flutter analyze              # статический анализ
dart run custom_lint         # правила riverpod_lint
flutter test                 # тесты (см. раздел «Тесты»)
```

Для Android нужен `android/local.properties` с `flutter.sdk` и `sdk.dir` — файл создаётся автоматически при первом `flutter run`.

Пересборка иконки приложения:

```bash
dart run flutter_launcher_icons
```

---

## Структура проекта

```
lib/
├── main.dart                          # точка входа: ProviderScope + MaterialApp, выбор темы
├── data/
│   ├── models/
│   │   ├── subject_model.dart         # SubjectModel — одна пара (время, предмет, даты, преподаватели, аудитории, группы)
│   │   └── week_subject_model.dart    # WeekSubjectModel — день недели: dayName, date, List<SubjectModel>
│   └── services/
│       └── data_service.dart          # загрузка assets/formatted.json и фильтрация расписания
├── providers/
│   ├── data_provider.dart             # dataServiceProvider, dataInitializedProvider
│   ├── today_provider.dart            # todayModelsProvider, todayWeekNumberProvider
│   ├── week_provider.dart             # weekModelsProvider, currentDateProvider
│   ├── nav_provider.dart              # navProvider — индекс нижнего навбара
│   └── theme_provider.dart            # themeProvider — Brightness (по умолчанию dark)
├── utils/
│   ├── helpers.dart                   # таблица времени, дни недели, номер учебной недели, даты недели
│   ├── extensions/
│   │   └── build_context_ext.dart     # context.text / context.color / context.isDarkMode
│   └── themes/
│       ├── theme.dart                 # part-сборка темы, basicTheme()
│       ├── theme_manager.dart         # ThemeManager.dark / ThemeManager.light
│       └── src/
│           ├── constants.dart         # fontFamily, titleMedium/displayMedium/labelMedium, AppColors
│           ├── dark_theme.dart        # createDarkTheme()
│           ├── light_theme.dart       # createLightTheme()
│           ├── text_theme.dart        # createTextTheme()
│           ├── theme_colors.dart      # ThemeExtension ThemeColors (light/dark)
│           └── theme_text_styles.dart # ThemeExtension ThemeTextStyles (light/dark)
└── view/
    ├── pages/
    │   ├── main_page.dart             # Scaffold, AppBar с номером недели, FloatingNavbar, IndexedStack
    │   ├── today_page.dart            # список пар на сегодня
    │   └── week_page.dart             # ScrollablePositionedList по дням недели
    └── widgets/
        ├── subject_widget.dart        # плитка пары: время, предмет, аудитория, преподаватель
        ├── week_subject_widget.dart   # карточка дня с вложенным списком пар
        ├── load_indicator.dart        # красный CircularProgressIndicator
        └── place_holder.dart          # заглушка «Отдыхай» для пустого дня

assets/
├── formatted.json                     # само расписание (2473 строки, 98 записей)
├── icon/icon.png                      # исходник иконки приложения
├── images/tile_background.png         # фоновая текстура плитки пары
└── fonts/MPLUSRounded1c-*.ttf         # шрифт M PLUS Rounded 1c (7 начертаний)

test/
├── data_service_test.dart             # загрузка ассета, число записей, выборки на сегодня/неделю
├── helpers_test.dart                  # convertHoursToTime, getWeekdayName, getWeekNumber, generateWeekDaysList
└── widget_test.dart                   # шаблонный counter smoke-тест (не актуален)
```

---

## Формат данных

Источник — `assets/formatted.json`, читается через `rootBundle.loadString` в `lib/data/services/data_service.dart:12-26`. Ожидается объект с ключом `schedule_data` (массив записей):

```json
{
  "schedule_data": [
    {
      "day_of_week": "ПОНЕДЕЛЬНИК",
      "time_slots": ["9-10", "11-12"],
      "week": 1,
      "subject": "СИСТЕМНАЯ ИНЖЕНЕРИЯ",
      "dates": ["15.09", "13.10", "10.11", "08.12"],
      "lecturer": ["проф. Щербаков М.В."],
      "room": ["В-208"],
      "groups": ["САПР-1.1", "САПР-1.4", "САПР-1.3"]
    }
  ]
}
```

| Поле | Тип | Смысл |
| --- | --- | --- |
| `day_of_week` | `String` | день недели прописными: `ПОНЕДЕЛЬНИК` … `ВОСКРЕСЕНЬЕ` |
| `time_slots` | `List<String>` | номера пар в формате `"1-2"`, `"9-10"` — конвертируются в реальное время |
| `week` | `int` | `1` или `2` — числитель/знаменатель |
| `subject` | `String` | название дисциплины |
| `dates` | `List<String>` | конкретные даты занятий `дд.мм` |
| `lecturer` | `List<String>` | преподаватели |
| `room` | `List<String>` | аудитории |
| `groups` | `List<String>` | группы, которым читается пара |

Соответствие номеров пар времени (`lib/utils/helpers.dart:1-8`):

| Пары | Начало | Конец |
| --- | --- | --- |
| 1-2 | 8:30 | 10:00 |
| 3-4 | 10:10 | 11:40 |
| 5-6 | 11:50 | 13:20 |
| 7-8 | 13:40 | 15:10 |
| 9-10 | 15:20 | 16:50 |
| 11-12 | 17:00 | 18:30 |

### Фильтрация

Всё расписание фильтруется локально в `DataService`:

- группа задана константой `final String groupName = "САПР-1.1";` (`lib/data/services/data_service.dart:28`) — запись попадает в выборку, только если `model.groups.contains(groupName)`;
- `getTodayModels(DateTime now)` — записи, у которых в `dates` есть `дд.мм` текущего дня;
- `getWeekModels(int week, DateTime now)` — по каждому дню Пн–Сб: совпадение `dayOfWeek`, `week` и даты из `generateWeekDaysList(now)`; всегда возвращает 6 элементов (`WeekSubjectModel`), даже если пар нет.

**Чтобы сменить группу** — правьте `groupName`; чтобы обновить расписание — заменяйте `assets/formatted.json`, код при этом не меняется.

---

## Архитектура

Однонаправленный поток: ассет → сервис → провайдеры → виджеты.

```
assets/formatted.json
        │  rootBundle.loadString
        ▼
DataService.initData() ──► dataInitializedProvider (FutureProvider<bool>)
        │                            │
        │                   сегодня: watch
        │                   неделя:  read
        ▼                            ▼
todayModelsProvider           weekModelsProvider
(List<SubjectModel>)          (List<WeekSubjectModel>)
        │                            │
        ▼                            ▼
   TodayPage                    WeekPage
        └──────────┬─────────────────┘
                   ▼
         MainPage (IndexedStack)
                   ▲
        navProvider │ themeProvider │ currentDateProvider (StateProvider<DateTime>)
```

Ключевые решения:

- `ProviderScope` поднимается в `main.dart:9`, выше `MaterialApp`; тема приложения читается из `themeProvider` (`lib/main.dart:17-22`).
- `dataInitializedProvider` — единственный `FutureProvider`, который грузит файл; `todayModelsProvider` и `weekModelsProvider` зависят от него и бросают `Exception('Data service not initialized')`, если ассет не загрузился.
- Текущая дата живёт в `currentDateProvider` (`lib/providers/week_provider.dart:24`); смена недели — это просто запись новой даты `±7` дней в этот провайдер (`lib/view/pages/main_page.dart:136-159`), все зависимые провайдеры пересчитываются автоматически.
- Кэш `DataService` — поле `late final List<SubjectModel> models;`, заполняется один раз в `initData()`.
- UI не знает о форматировании данных: конвертация номеров пар во время и имена дней недели — в `helpers.dart`.

---

## Темы и стили

- `ThemeManager.dark` / `ThemeManager.light` (`lib/utils/themes/theme_manager.dart`) собирают `ThemeData` из `createDarkTheme()` / `createLightTheme()`.
- Кастомные значения вынесены в `ThemeExtension`:
  - `ThemeColors` — `backgroundSubjectColor`, `borderWeekSubjectColor`, `arrowColor` (`lib/utils/themes/src/theme_colors.dart`);
  - `ThemeTextStyles` — `appTitle`, `appDisplay`, `appLabel`, `appSubLabel`, `appWeekNumberLable`, `appName` (`lib/utils/themes/src/theme_text_styles.dart`).
- Доступ из виджетов — через extension `BuildContextExt` (`lib/utils/extensions/build_context_ext.dart`):

  ```dart
  context.text.appName        // TextStyle из активной темы
  context.color.arrowColor    // Color из активной темы
  context.isDarkMode
  ```

- Палитра — `AppColors` в `lib/utils/themes/src/constants.dart:12-22` (акцент `softRed` = `#C51616`, фоны `softGrey` `#141414` / `lightDark` `#1b1b1b` / `lighterDark` `#272727`).
- Плитки пар рисуются поверх текстуры `assets/images/tile_background.png` с прозрачностью `0.7` (`lib/view/widgets/subject_widget.dart:28-40`).

---

## Утилиты (`lib/utils/helpers.dart`)

| Функция | Назначение |
| --- | --- |
| `(String, String)? convertHoursToTime(List<String> timeSlots)` | по номерам пар возвращает `(начало, конец)` |
| `const daysOfWeek` | список дней недели прописными, начиная с понедельника |
| `String getWeekdayName(int weekday)` | `1..7` → название дня, иначе `ArgumentError` |
| `int getWeekNumber(int startDay, int startMonth, DateTime date)` | номер учебной недели `1`/`2` от старта обучения (для проекта — `getWeekNumber(1, 9, date)`) |
| `List<String> generateWeekDaysList(DateTime now)` | 6 дат `дд.мм` с понедельника текущей недели по субботу |

> `convertHoursToTime` использует `!` при обращении к `_mapHours`, поэтому незнакомый слот времени («13-14») приведёт к исключению.

---

## Тесты

```bash
flutter test
```

- `test/data_service_test.dart` — проверяет, что ассет читается (`initData() == true`), что в файле ожидаемое число записей, и что `getTodayModels` / `getWeekModels(1, now)` возвращают корректное количество элементов. **Тест завязан на текущий ассет: он ждёт `95` записей, а в `assets/formatted.json` их `98`; ожидание `getTodayModels(...).length == 0` выполняется только вне дат семестра (`01.09`–`22.12`).** При обновлении расписания эти числа надо править вместе с файлом.
- `test/helpers_test.dart` — `convertHoursToTime(["3-4"]) == ("10:10", "11:40")`, `getWeekdayName(1) == "ПОНЕДЕЛЬНИК"`, `getWeekNumber(1, 9, DateTime(2025, 9, 13)) == 2`, `generateWeekDaysList(DateTime(2025, 9, 20))` начинается с `"15.09"`.
- `test/widget_test.dart` — остался от Flutter-шаблона: ищет счётчик `'0'`/`'1'` и `Icons.add`, которых в приложении нет, и поднимает `App` без `ProviderScope`. Тест заведомо падает — его стоит либо удалить, либо переписать под реальные экраны.

---

## Сборка релиза (Android)

```bash
flutter build apk --release
# или
flutter build appbundle --release
```

`minSdkVersion`/`targetSdkVersion` берутся из Flutter (`flutter.minSdkVersion`), иконка запуска — `launcher_icon` (см. `flutter_launcher_icons` в `pubspec.yaml:28-32`). Release-сборка сейчас подписывается **debug-ключами** (`android/app/build.gradle:54-60`), для публикации нужен собственный `signingConfig`.

---

## Известные ограничения и TODO

- Экран «Месяц» — заглушка в `lib/view/pages/main_page.dart:19-26`.
- Группа захардкожена (`groupName`), дата старта семестра (`1 сентября`) тоже — параметризация не вынесена в настройки.
- `currentDateProvider` инициализируется `DateTime.now()` один раз при старте и не обновляется при переходе через полночь или возврате приложения из фона.
- `WeekSubjectModel.fromMap` кастует `map['subjects'] as List<int>` (`lib/data/models/week_subject_model.dart:43`) — десериализация из JSON сломается; на практике вызывается только `toMap`.
- `floating_bottom_navigation_bar` объявлен в `dev_dependencies`, хотя импортируется в продакшн-коде (`lib/view/pages/main_page.dart:1`) — место в `dependencies`.
- В `pubspec.yaml` подключены только 2 из 7 начертаний `MPLUSRounded1c` (Regular, Medium).
- `print('Ошибка чтения файла: $e')` в `lib/data/services/data_service.dart:23` — ошибка загрузки только логируется, пользователю показывается `Text("Ошибка: $error")` из страниц.
- Лицензия в репозитории не указана.
