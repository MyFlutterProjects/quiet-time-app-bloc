import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qt_bloc_app/blocs/auth_bloc.dart';
// import 'package:bloc_provider/bloc_provider.dart';
import 'package:qt_bloc_app/blocs/user_bloc.dart';
import 'package:qt_bloc_app/blocs/user_list_bloc.dart';
import 'package:qt_bloc_app/helpers/SimpleBlocSupervisor.dart';
import 'package:qt_bloc_app/views/login.dart';
import 'package:qt_bloc_app/views/user_list.dart';

void main(){ 
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocSupervisorDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
  providers: [
    BlocProvider<UserListBloc>(
      create: (BuildContext context) =>UserListBloc(),
    ),
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
    ),
    BlocProvider<UserBloc>(
      create: (BuildContext context) => UserBloc(),
    ),
  ],
  // child: UserList(),
  child: Login(),
),

    );
  }
}

