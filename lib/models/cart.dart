import 'package:siksik_labuyo/models/item.dart';

class Cart {
  final List _items = [];

  int get totalItems => _items.length;
  double get totalPrice => throw (UnimplementedError());
}

class CartItem {
  CartItem({required this.item, required this.quantity});

  final Item item;
  int quantity;

  double get totalPrice => throw (UnimplementedError());
}
