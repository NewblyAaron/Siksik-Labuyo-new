import 'package:flutter/material.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/tabviews/categories_tabview.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/tabviews/creators_tabview.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/tabviews/items_tabview.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController tabController;

  int tabSelectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _InventoryPageView(this);
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: tabSelectedIndex);
    tabController.addListener(() => tabSelectedIndex = tabController.index);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}

class _InventoryPageView
    extends WidgetView<InventoryPage, _InventoryPageState> {
  const _InventoryPageView(super.state, {super.key});

  final List<Tab> _tabs = const [
    Tab(
        icon: Icon(Icons.sell),
        text: "Items",
        iconMargin: EdgeInsets.only(top: 2, bottom: 2)),
    Tab(
        icon: Icon(Icons.category),
        text: "Categories",
        iconMargin: EdgeInsets.only(top: 2, bottom: 2)),
    Tab(
        icon: Icon(Icons.person),
        text: "Creators",
        iconMargin: EdgeInsets.only(top: 2, bottom: 2))
  ];

  final List<Widget> _views = const [
    ItemsTabView(),
    CategoriesTabView(),
    CreatorsTabView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Expanded(child: _buildTabBar(context))],
        ),
      ),
      body: _buildTabView(context),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(controller: state.tabController, tabs: _tabs);
  }

  Widget _buildTabView(BuildContext context) {
    return TabBarView(controller: state.tabController, children: _views);
  }
}
