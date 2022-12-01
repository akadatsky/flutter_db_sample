import 'package:test_db/model/user.dart';

abstract class UsersState {}

class UsersInitState extends UsersState {}

class UsersLoadedState implements UsersState {
  final List<User> users;

  UsersLoadedState(this.users);
}
