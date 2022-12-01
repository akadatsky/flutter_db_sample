class User {
  final int id;
  final String name;
  final int age;

  User({
    this.id = -1,
    required this.name,
    required this.age,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $name, age: $age}';
  }
}
