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
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _genderControler = TextEditingController();
  final _residenceControler = TextEditingController();
  final _dateOfBirthControler = TextEditingController();
  

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
        _lastNameController.text = onData.user.lastName;
        _surnameNameController.text = onData.user.username;
        _emailController.text = onData.user.email;
        _roleController.text = onData.user.email;
        _residenceControler.text = onData.user.residence;
        _dateOfBirthControler.text = onData.user.dateOfBirth;
        _genderDropdownValue = onData.user.gender;
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
        lastName: _lastNameController.text,
        gender: _genderDropdownValue,
        dateOfBirth: _dateOfBirthControler.text,
        email: _emailController.text,
        username: _surnameNameController.text,
        roles: _roleController.text,
        password: _passwordController.text,
        residence: _residenceControler.text
      ),
    );
  }

  void update(String id) { 
    _userBloc.updateUser( 
      User( 
        id: id,
        firstName: _firstNameController.text,
        email: _emailController.text,
        username: _surnameNameController.text
        ),
    );
  }

  void deleteUser(String id) {
    _userBloc.deleteUser(widget.id);
  }

  String _value = '';

  Future _selectDate() async {
    print('valsks');
    DateTime picked = await showDatePicker( 
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1990), lastDate: DateTime(2019));
      
      if (picked != null) setState(() {
        _value = picked.toString();
      });
  }

  // List<String> gender = ['Male', 'Female'];
          String _genderDropdownValue;
          String _dateOfBirthValue;

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
                          hintText: "First Name",
                        ),
                      ),
                    ),
                    ListTile( 
                      leading: Icon(Icons.person),
                      title: TextFormField( 
                        controller: _lastNameController,
                        decoration: InputDecoration( 
                          hintText: 'Last Name'
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
                    // DropdownButton<String>( 
                    //   hint: _selectGender == null 
                    //   ? Text('Please choose a gender')
                    //   : Text(_selectGender,
                    //    style: TextStyle(color: Colors.blue),

                    //   ),
                    //   value: _selectGender,
                    //   onChanged: (String newValue) {
                    //     setState(() {
                    //       _selectGender = newValue;
                    //     });
                    //   },
                    //   items: gender.map((String gender) {
                    //     return DropdownMenuItem<String>( 
                    //       child: Text(gender),
                    //       value: gender,
                    //     );
                    //   }).toList(),
                    // ),
                    DropdownButton( 
                      hint: _genderDropdownValue == null
                      ? Text('Select Gender')
                      : Text(_genderDropdownValue, 
                        style: TextStyle(color: Colors.blue),
                      ),
                      // isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: ['Male', 'Female'].map( 
                        (val) {
                          return DropdownMenuItem(value: val,child: Text(val),);
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(() {
                          _genderDropdownValue = val;
                          // print(_genderDropdownValue);
                        });
                      },
                    ),
                    RaisedButton( 
                      onPressed: _selectDate,
                      child: Text('Select Day of Birth'),
                    ),
                    ListTile( 
                      leading: Icon(Icons.mail),
                      title: TextFormField( 
                        controller: _emailController,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                    ),
                    ListTile( 
                      leading: Icon(Icons.mail),
                      title: TextFormField( 
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: "Password"),
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
