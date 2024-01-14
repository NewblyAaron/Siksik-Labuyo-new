import 'package:flutter/material.dart';
import 'package:siksik_labuyo/models/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.name),
          Text("${item.stock.toString()}x"),
          Text("\$${item.price.toStringAsFixed(2)}")
        ],
      ),
    );
  }
}
