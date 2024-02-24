import 'package:beauty/views/tag.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty',
      theme: buildTheme(Brightness.light, const ColorScheme.light()),
      darkTheme: buildTheme(Brightness.dark, const ColorScheme.dark()),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const TagView(),
    );
  }

  ThemeData buildTheme(Brightness brightness, ColorScheme colorScheme) {
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      useMaterial3: true, // 启用 Material 3
      fontFamily: "LXGWWenKai", // 设置全局字体
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
