import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/models/creator.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/forms/creator_form.dart';

class CreatorsTabView extends StatefulWidget {
  const CreatorsTabView({super.key});

  @override
  State<CreatorsTabView> createState() => _CreatorsTabViewState();
}

class _CreatorsTabViewState extends State<CreatorsTabView> {
  late final Isar _db;
  late final StreamSubscription creatorStream;
  late List<Creator> creators;

  @override
  Widget build(BuildContext context) => _CreatorsTabView(this);

  @override
  void initState() {
    super.initState();

    _db = Isar.getInstance()!;
    creators = _db.creators.where().findAllSync();
    creatorStream = _db.creators.watchLazy().listen((event) {
      setState(() => creators = _db.creators.where().findAllSync());
    });
  }

  @override
  void dispose() {
    super.dispose();
    creatorStream.cancel();
  }

  void openForm() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
        child: const CreatorForm(),
      ),
    );
  }
}

class _CreatorsTabView
    extends WidgetView<CreatorsTabView, _CreatorsTabViewState> {
  const _CreatorsTabView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: state.openForm,
        heroTag: null,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (state.creators.isEmpty) {
      return const Center(
        child: Text("No entries!"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(state.creators[index].name),
          ),
        );
      },
      itemCount: state.creators.length,
    );
  }
}
