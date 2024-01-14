import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:siksik_labuyo/models/item.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/screens/cart/cart_screen.dart';
import 'package:siksik_labuyo/widgets/item_card.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {
  late final Isar _db;
  late final List<Item> items;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _StorePageView(this);
  }

  @override
  void initState() {
    super.initState();

    _db = Isar.getInstance()!;
    items = _db.items.where().findAllSync();
  }

  void openBag() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartScreen(),
        ));
  }
}

class _StorePageView extends WidgetView<StorePage, _StorePageState> {
  const _StorePageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: state.openBag,
        heroTag: null,
        child: const Icon(Icons.shopping_bag),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            padding: const EdgeInsets.all(8),
            itemCount: state.items.length,
            itemBuilder: (context, index) => ItemCard(item: state.items[index]),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchBar(
            trailing: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
            hintText: "Search items",
          ),
        ),
      ],
    );
  }
}
