const String tableName = 'users';

const String columnId = 'user_id';
const String columnName = 'user_name';
const String columnAge = 'user_age';

// ====================================
// No comma after last column!!!
// ====================================
const String createTableQuery = '''
CREATE TABLE IF NOT EXISTS $tableName (
$columnId integer PRIMARY KEY AUTOINCREMENT,
$columnName text,
$columnAge integer
);
''';
