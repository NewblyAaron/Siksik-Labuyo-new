import 'package:flutter/material.dart';

abstract class WidgetView<model, controller> extends StatelessWidget {
  final controller state;

  model get widget => (state as State).widget as model;

  const WidgetView(this.state, {super.key});

  @override
  Widget build(BuildContext context);
}

abstract class StatelessView<model> extends StatelessWidget {
  final model widget;

  const StatelessView(this.widget, {super.key});

  @override
  Widget build(BuildContext context);
}
