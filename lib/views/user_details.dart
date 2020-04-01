import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qt_bloc_app/blocs/user_bloc.dart';
import 'package:qt_bloc_app/models/user.dart';

class UserDetails extends StatefulWidget {
  final String id;
  UserDetails(this.id);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  UserBloc _userBloc;
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _surnameNameController = TextEditingController();
   final _roleController = TextEditingController();
  

  StreamSubscription blocSubscription;
  @override
  void initState() {
    _userBloc = UserBloc();

    if (widget.id != "") {
      _userBloc.getUser(widget.id);
    }

    blocSubscription = _userBloc.listen((onData) {
      if (onData.isSaved == true || onData.isDeleted == true) {
        Navigator.pop(context, true);
      }

      if (onData.isLoaded) {
        _firstNameController.text = onData.user.firstName;
        _surnameNameController.text = onData.user.surname;
        _emailController.text = onData.user.email;
        _roleController.text = onData.user.email;
      }
    });
    super.initState();
  }

  @override 
  void dispose() {
    blocSubscription.cancel();
    _userBloc.close();
    super.dispose();
  }

  void create() {
    _userBloc.createUser( 
      User( 
        firstName: _firstNameController.text,
        email: _emailController.text,
        surname: _surnameNameController.text,
        roles: _roleController.text
      ),
    );
  }

  void update(String id) { 
    _userBloc.updateUser( 
      User( 
        id: id,
        firstName: _firstNameController.text,
        email: _emailController.text,
        surname: _surnameNameController.text
        ),
    );
  }

  void deleteUser(String id) {
    _userBloc.deleteUser(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("User details"),
        actions: <Widget>[ 
          BlocBuilder( 
            bloc: _userBloc, 
            builder: (BuildContext context, UserState state) {
              return IconButton( 
                icon: Icon(Icons.save),
                onPressed: () {
                  if (widget.id != "") {
                    update(state.user.id);
                  } else { 
                    create();
                  }
                });
            }),
         BlocBuilder( 
           bloc: _userBloc,
           builder: (BuildContext context, UserState state) {
             return IconButton(
               icon: Icon(Icons.delete),
               onPressed: () {
                 if (widget.id != "") {
                   deleteUser(widget.id);
                 }
               });
           }),
        ],
      ),
      body: BlocBuilder( 
        bloc: _userBloc,
        builder: (BuildContext context, UserState state) {
          if (state.isSaving == true) {
            return Center( 
              child: CircularProgressIndicator(),
            );
          }

          return state.isLoading 
            ? LinearProgressIndicator()
            : Form(
              child: SingleChildScrollView( 
                child: Column( 
                  children: <Widget>[ 
                    ListTile( 
                      leading: Icon(Icons.person),
                      title: TextFormField( 
                        controller: _firstNameController,
                        decoration: InputDecoration( 
                          hintText: "Name",
                        ),
                      ),
                    ),
                    ListTile( 
                      leading: Icon(Icons.verified_user),
                      title: TextFormField( 
                        controller: _surnameNameController,
                        decoration: InputDecoration(hintText: "Username"),
                      ),
                    ),
                    ListTile( 
                      leading: Icon(Icons.mail),
                      title: TextFormField( 
                        controller: _emailController,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                    ),
                      ListTile( 
                      leading: Icon(Icons.person_pin),
                      title: TextFormField( 
                        controller: _roleController,
                        decoration: InputDecoration(hintText: "Role"),
                      ),
                    )
                  ],),
              ),
              
            );
        },
      ),
    );
  }
}
