import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';
import 'package:test_db/database/database.dart';
import 'package:test_db/datasource/ds_users.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitState()) {
    on<LoadUsersEvent>(onLoadUsersEvent);
    on<AddUserEvent>(onAddUserEvent);
  }

  Future<void> onLoadUsersEvent(
      LoadUsersEvent event, Emitter<UsersState> emit) async {
    final db = await provideDb();
    final usersDs = UsersDatasource(db);
    final users = await usersDs.getUsers();
    emit(UsersLoadedState(users));
  }

  Future<void> onAddUserEvent(
      AddUserEvent event, Emitter<UsersState> emit) async {
    final db = await provideDb();
    final usersDs = UsersDatasource(db);
    usersDs.saveUser(event.user);
  }
}
