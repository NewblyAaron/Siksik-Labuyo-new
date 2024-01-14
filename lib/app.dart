import 'package:flutter/material.dart';
import 'package:siksik_labuyo/screens/main/main_screen.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  // ignore: library_private_types_in_public_api
  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  void changeTheme(ThemeMode themeMode) =>
      setState(() => _themeMode = themeMode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: AppTheme.mainTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      title: "Siksik Labuyo",
      home: const MainScreen(),
    );
  }
}

class AppTheme {
  static final mainTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true);
  static final darkTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, brightness: Brightness.dark),
      useMaterial3: true);
}
