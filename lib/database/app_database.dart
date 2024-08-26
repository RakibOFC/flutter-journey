import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import './model/user_entity.dart';
import 'dao/task_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users], daos: [TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;
}
