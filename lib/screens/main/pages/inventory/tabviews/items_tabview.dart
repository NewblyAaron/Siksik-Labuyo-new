import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:siksik_labuyo/models/item.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/forms/item_form.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/widgets/item_card.dart';

class ItemsTabView extends StatefulWidget {
  const ItemsTabView({super.key});

  @override
  State<ItemsTabView> createState() => _ItemsTabViewState();
}

class _ItemsTabViewState extends State<ItemsTabView> {
  late final Isar _db;
  late final List<Item> items;

  @override
  Widget build(BuildContext context) => _ItemsTabView(this);

  @override
  void initState() {
    super.initState();

    _db = Isar.getInstance()!;
    items = _db.items.where().findAllSync();
  }

  void openForm() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
        child: const ItemForm(),
      ),
    );
  }
}

class _ItemsTabView extends WidgetView<ItemsTabView, _ItemsTabViewState> {
  const _ItemsTabView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: state.openForm,
        heroTag: null,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(8),
      itemCount: state.items.length,
      itemBuilder: (context, index) => ItemCard(item: state.items[index]),
    );
  }
}
