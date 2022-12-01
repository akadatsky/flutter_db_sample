import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';
import 'package:test_db/model/user.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // BlocBuilder, BlocConsumer
    return BlocListener<UsersBloc, UsersState>(
      listener: (BuildContext context, state) {
        if (state is UsersLoadedState) {
          print(state.users);
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _addTestValues,
              child: const Text('Add test users'),
            ),
            ElevatedButton(
              onPressed: _printUsers,
              child: const Text('Print users'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTestValues() {
    final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(
      AddUserEvent(
        User(
          name: 'Alex',
          age: 22,
        ),
      ),
    );
    bloc.add(
      AddUserEvent(
        User(
          name: 'Ben',
          age: 33,
        ),
      ),
    );
    bloc.add(
      AddUserEvent(
        User(
          name: 'Carl',
          age: 44,
        ),
      ),
    );
  }

  void _printUsers() {
    final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(LoadUsersEvent());
  }
}
