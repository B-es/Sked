import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sked/providers/theme_provider.dart';
import 'package:sked/utils/themes/theme_manager.dart';
import 'package:sked/view/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeBrigthness = ref.watch(themeProvider);
    return MaterialApp(
        title: 'Sked',
        theme: themeBrigthness == Brightness.dark
            ? ThemeManager.dark
            : ThemeManager.light,
        home: MainPage());
  }
}
