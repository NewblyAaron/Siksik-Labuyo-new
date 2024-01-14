import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siksik_labuyo/app.dart';
import 'package:siksik_labuyo/models/category.dart';
import 'package:siksik_labuyo/models/creator.dart';
import 'package:siksik_labuyo/models/item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Isar.open([ItemSchema, CategorySchema, CreatorSchema],
      directory: dir.path);

  runApp(const App());
}
