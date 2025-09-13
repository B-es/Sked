import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sked/providers/nav_provider.dart';
import 'package:sked/providers/theme_provider.dart';
import 'package:sked/providers/today_provider.dart';
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
              bottomLeft: Radius.circular(25)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => themeBrigthness.state =
                  themeBrigthness.state == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
              icon: Icon(Icons.color_lens_outlined))
        ],
        bottom: PreferredSize(
          preferredSize: Size(50, 40),
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
            child: Text(
              "$weekNumber учебная неделя",
              overflow: TextOverflow.ellipsis,
              style: context.text.appWeekNumberLable,
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
}
