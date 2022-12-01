import 'package:sqflite/sqflite.dart';
import 'package:test_db/database/users_table.dart' as users;
import 'package:test_db/model/user.dart';

class UsersDatasource {
  final Database db;

  UsersDatasource(this.db);

  Future<void> saveUser(User user) async {
    Map<String, dynamic> row = {
      users.columnName: user.name,
      users.columnAge: user.age,
    };
    db.insert(users.tableName, row);
    //db.rawInsert('INSERT INTO my_table(name, age) VALUES("Alex", 22)');
  }

  Future<List<User>> getUsers() async {
    final result = await db.query(users.tableName);
    if (result.isEmpty) {
      return [];
    }
    return result
        .map((it) => User(
              id: it[users.columnId] as int,
              name: it[users.columnName] as String,
              age: it[users.columnAge] as int,
            ))
        .toList();
  }

  Future<void> cleanAllUsers() async {
    await db.transaction((transaction) async {
      //await transaction.rawQuery('...');
      await transaction.delete(users.tableName);
      // where: ...
    });
  }
}
