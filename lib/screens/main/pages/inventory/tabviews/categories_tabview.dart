import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/models/category.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/forms/category_form.dart';

class CategoriesTabView extends StatefulWidget {
  const CategoriesTabView({super.key});

  @override
  State<CategoriesTabView> createState() => _CategoriesTabViewState();
}

class _CategoriesTabViewState extends State<CategoriesTabView> {
  late final Isar _db;
  late final StreamSubscription categoryStream;
  late List<Category> categories;

  @override
  Widget build(BuildContext context) => _CategoriesTabView(this);

  @override
  void initState() {
    super.initState();

    _db = Isar.getInstance()!;
    categories = _db.categorys.where().findAllSync();
    categoryStream = _db.categorys.watchLazy().listen((event) {
      setState(() => categories = _db.categorys.where().findAllSync());
    });
  }

  @override
  void dispose() {
    super.dispose();
    categoryStream.cancel();
  }

  void openForm() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
        child: const CategoryForm(),
      ),
    );
  }
}

class _CategoriesTabView
    extends WidgetView<CategoriesTabView, _CategoriesTabViewState> {
  const _CategoriesTabView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: state.openForm,
        heroTag: null,
        child: const Icon(Icons.library_add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (state.categories.isEmpty) {
      return const Center(
        child: Text("No entries!"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(state.categories[index].name),
          ),
        );
      },
      itemCount: state.categories.length,
    );
  }
}
