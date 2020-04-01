import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qt_bloc_app/blocs/user_list_bloc.dart';
import 'package:qt_bloc_app/models/user.dart';
import 'package:qt_bloc_app/views/user_details.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserListBloc _userListBloc;

  @override
  void initState() {
    _userListBloc = UserListBloc();
    _userListBloc.loadUsers();
    super.initState();
  }

  @override
  void dispose() {
    _userListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _userListBloc,
        builder: (BuildContext context, List<User> list) {
          return Scaffold(
            appBar: AppBar(
              title: Text('User'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails(""),
                        )).then((val) {
                      if (val == true) {
                        _userListBloc.loadUsers();
                      }
                    });
                  },
                  icon: Icon(Icons.add),
                )
              ],
            ),
            body: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails(list[index].id),
                        ),
                      ).then((val) => _userListBloc.loadUsers());
                    },
                    title: Text(list[index].firstName ?? "<No Name>"),
                  );
                }),
          );
        });
  }
}
