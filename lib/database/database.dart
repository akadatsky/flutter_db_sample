import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:test_db/database/users_table.dart' as users;
import 'package:test_db/utils/logger.dart';
import 'package:path/path.dart';

const String dbName = 'my_package_name.db';

const tables = [
  users.createTableQuery,
];

Future<Database> provideDb() async {
  final path = await initDb();
  return await openDatabase(
    path,
    version: 5,
    onCreate: onDbCreate,
    onUpgrade: onDbUpgrade,
    onConfigure: onDbConfigure,
    onOpen: (db) async {
      await db.execute('PRAGMA foreign_keys = ON;');
    },
  );
}

Future<String> initDb() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, dbName);

  if (!(await Directory(dirname(path)).exists())) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      Log().d(tag: 'exception', message: e.toString());
    }
  }
  return path;
}


FutureOr<void> onDbCreate(Database db, int version) async {
  for (var table in tables) {
    db.execute(table);
  }
}

FutureOr<void> onDbConfigure(Database db) async {
  await db.execute('PRAGMA foreign_keys = OFF;');
}

FutureOr<void> onDbUpgrade(
  Database db,
  int oldVersion,
  int newVersion,
) async {
  try {
    if (oldVersion < 3) {
      throw UnsupportedError(
        'Too old version of db. Need to be handled by recreation of db in catch statement',
      );
    }

    if (oldVersion < 4) {
      await db.execute('DROP TABLE IF EXISTS persons;');
    }
  } catch (e) {
    Log().error(
      tag: 'Db Migration Exception',
      error: e,
    );
    final allTables = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');

    final allTriggers = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "trigger"');

    for (var i = 0; i < allTriggers.length; i++) {
      await db.execute('DROP TRIGGER IF EXISTS ${allTables[i]['name']};');
    }

    for (var i = 0; i < allTables.length; i++) {
      if (allTables[i]['name'] == 'sqlite_sequence') {
        continue;
      }
      await db.execute('DROP TABLE IF EXISTS ${allTables[i]['name']};');
    }

    for (var table in tables) {
      db.execute(table);
    }
  }
}
