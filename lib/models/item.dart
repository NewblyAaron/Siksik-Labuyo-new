import 'package:isar/isar.dart';
import 'package:siksik_labuyo/models/category.dart';
import 'package:siksik_labuyo/models/creator.dart';

part 'item.g.dart';

@collection
class Item {
  Item(
      {required this.name,
      required this.creatorId,
      this.categoryId,
      required this.price,
      required this.stock});

  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String name;

  @Index()
  late int? categoryId;

  @Index()
  late int creatorId;

  @Index()
  late double price;

  @Index()
  late int stock;

  Category? get category => categoryId != null
      ? (Isar.getInstance()!).categorys.getSync(categoryId!)
      : null;
  Creator get creator => (Isar.getInstance()!).creators.getSync(creatorId)!;
}
