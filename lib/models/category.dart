import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category {
  Category({required this.name});

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String name;

  @override
  String toString() => name;
}
