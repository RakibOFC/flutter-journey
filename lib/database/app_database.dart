import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_journey/database/model/db_entities.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Command
// $ flutter pub run build_runner build
// $ dart run build_runner build
part 'app_database.g.dart';

@DriftDatabase(tables: [User])
class AppDatabase extends _$AppDatabase {

  static AppDatabase instance() => AppDatabase();

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}