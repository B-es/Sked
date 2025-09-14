import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sked/providers/nav_provider.dart';
import 'package:sked/providers/theme_provider.dart';
import 'package:sked/providers/today_provider.dart';
import 'package:sked/providers/week_provider.dart';
import 'package:sked/utils/extensions/build_context_ext.dart';
import 'package:sked/utils/themes/theme.dart';
import 'package:sked/view/pages/today_page.dart';
import 'package:sked/view/pages/week_page.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final _pages = [
    TodayPage(),
    WeekPage(),
    Scaffold(
      body: Center(
        child: Text(
          "TODO: ХЕР ВАМ ДВАЖДЫ",
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navProvider);
    final weekNumber = ref.watch(todayWeekNumberProvider);
    final themeBrigthness = ref.watch(themeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sked",
          style: context.text.appName,
        ),
        shadowColor: AppColors.softRed,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => themeBrigthness.state =
                themeBrigthness.state == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark,
            icon: Icon(Icons.color_lens_outlined)),
        bottom: PreferredSize(
          preferredSize: Size(50, 50),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: context.color.backgroundSubjectColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                navIndex == 1
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                            onPressed: () {
                              leftClick(ref);
                            },
                            icon: Icon(
                              Icons.arrow_left,
                              color: context.color.arrowColor,
                            )),
                      )
                    : SizedBox(
                        width: 50,
                        height: 50,
                      ),
                Text(
                  "$weekNumber учебная неделя",
                  overflow: TextOverflow.ellipsis,
                  style: context.text.appWeekNumberLable,
                ),
                navIndex == 1
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                            onPressed: () {
                              rightClick(ref);
                            },
                            icon: Icon(
                              Icons.arrow_right,
                              color: context.color.arrowColor,
                            )),
                      )
                    : SizedBox(
                        width: 50,
                        height: 50,
                      ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      body: IndexedStack(
        index: navIndex,
        children: _pages,
      ),
      bottomNavigationBar: FloatingNavbar(
        iconSize: 18,
        fontSize: 10,
        margin: EdgeInsets.zero,
        onTap: (int val) {
          ref.read(navProvider.notifier).state = val;
        },
        currentIndex: navIndex,
        items: [
          FloatingNavbarItem(icon: Icons.today_rounded, title: "Сегодня"),
          FloatingNavbarItem(icon: Icons.view_week_rounded, title: "Неделя"),
          FloatingNavbarItem(icon: Icons.calendar_month, title: "Месяц")
        ],
      ),
    );
  }

  void rightClick(WidgetRef ref) {
    final notif = ref.read(currentDateProvider.notifier);
    final currentDate = notif.state;
    int dayCount = 7;
    final newDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + dayCount,
    );
    notif.state = newDate;
  }

  void leftClick(WidgetRef ref) {
    final notif = ref.read(currentDateProvider.notifier);
    final currentDate = notif.state;
    int dayCount = 7;
    final newDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day - dayCount,
    );

    notif.state = newDate;
  }
}
