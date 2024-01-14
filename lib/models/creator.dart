import 'package:isar/isar.dart';

part 'creator.g.dart';

@collection
class Creator {
  Creator({required this.name});

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String name;

  @override
  String toString() => name;
}
