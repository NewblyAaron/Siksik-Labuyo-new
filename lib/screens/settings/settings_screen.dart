import 'package:flutter/material.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  late bool darkMode;

  @override
  Widget build(BuildContext context) => _SettingsView(this);

  @override
  void initState() {
    super.initState();

    darkMode = App.of(context).isDarkMode; 
  }

  void toggleDarkMode(bool value) {
    App.of(context).changeTheme(darkMode ? ThemeMode.light : ThemeMode.dark);

    setState(() => darkMode = App.of(context).isDarkMode);
  }
}

class _SettingsView extends WidgetView<SettingsScreen, _SettingsState> {
  const _SettingsView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          value: state.darkMode,
          onChanged: state.toggleDarkMode,
          thumbIcon: MaterialStateProperty.resolveWith((states) {
            if (states.any((element) => element == MaterialState.selected)) {
              return const Icon(Icons.nightlight);
            } else {
              return const Icon(Icons.sunny);
            }
          }),
          title: const Text("Dark Mode"),
          subtitle: const Text("Enable dark mode theme."),
        )
      ],
    );
  }
}
