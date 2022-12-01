import 'package:test_db/model/user.dart';

abstract class UsersEvent {}

class LoadUsersEvent extends UsersEvent {}

class AddUserEvent extends UsersEvent {
  final User user;

  AddUserEvent(this.user);
}
