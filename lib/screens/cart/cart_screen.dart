import 'package:flutter/material.dart';
import 'package:siksik_labuyo/utils/abstracts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) => _CartScreenView(this);
}

class _CartScreenView extends WidgetView<CartScreen, _CartScreenState> {
  const _CartScreenView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Cart Screen"),
      ),
    );
  }
}
