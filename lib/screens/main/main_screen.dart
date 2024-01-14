import 'package:flutter/material.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';
import 'package:siksik_labuyo/screens/main/pages/dashboard/dashboard_page.dart';
import 'package:siksik_labuyo/screens/main/pages/inventory/inventory_page.dart';
import 'package:siksik_labuyo/screens/main/pages/reports/reports_page.dart';
import 'package:siksik_labuyo/screens/main/pages/store/store_page.dart';
import 'package:siksik_labuyo/screens/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageController = PageController();

  int bottomNavBarSelectedIndex = 0;

  @override
  Widget build(BuildContext context) => _MainScreenView(this);

  void onBottomNavBarTap(int value) {
    setState(() {
      bottomNavBarSelectedIndex = value;
      pageController.animateToPage(value,
          duration: const Duration(milliseconds: 300), curve: Easing.standard);
    });
  }

  void openSettings() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ));
  }
}

class _MainScreenView extends WidgetView<MainScreen, _MainScreenState> {
  const _MainScreenView(super.state, {super.key});

  final _views = const [
    DashboardPage(),
    StorePage(),
    InventoryPage(),
    ReportsPage()
  ];

  final _bottomNavBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
    BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
    BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Inventory"),
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Siksik Labuyo"),
        actions: [
          IconButton(
              onPressed: state.openSettings, icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(child: _buildPageView(context)),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: _bottomNavBarItems,
      type: BottomNavigationBarType.fixed,
      currentIndex: state.bottomNavBarSelectedIndex,
      onTap: state.onBottomNavBarTap,
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView(
      controller: state.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: _views,
    );
  }
}
