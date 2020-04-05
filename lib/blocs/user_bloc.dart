import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:qt_bloc_app/models/user.dart';
import 'package:qt_bloc_app/repositories/user_repositories.dart';

enum UserEvents { getUser, createUser, updateUser, deleteUser }

class UserState { 
  User user;
  bool isLoading;
  bool isLoaded;
  bool isDeleting;
  bool isDeleted;
  bool isSaved;
  bool hasFailure;
  bool isSaving;

  UserState({ 
    this.user,
    this.isLoading = false,
    this.isSaved = false,
    this.isDeleting = false,
    this.isDeleted = false,
    this.isSaving = false,
    this.hasFailure = false,
    this.isLoaded =false,
  });

}

class UserBloc extends Bloc<UserEvents, UserState> {
  UserRepository  _userRepository;

  UserBloc() { 
    _userRepository = UserRepository();
  }

  String _id = "";
  User _user;

  @override 
  UserState get initialState => UserState();


 // methods are called from the view
  void getUser(String id) { 
    _id = id;
    this.add(UserEvents.getUser);
  }

  void createUser(User user) { 
    _user = user;
    this.add(UserEvents.createUser);
  }

  void updateUser(User user) { 
    _user = user;
    this.add(UserEvents.updateUser);
  }

  void deleteUser(String id) {
    _id = id;
    this.add(UserEvents.deleteUser);
  }

  @override 
  Stream<UserState> mapEventToState( UserEvents event) async* {
    switch(event)  { 
      case UserEvents.getUser: 
          yield UserState(isLoading: true, isLoaded: false);
          User user = await _userRepository.getUserById(_id);
          yield UserState(user: user, isLoading: false, isLoaded: true);
          break;
      case UserEvents.createUser:
          yield UserState(isSaving: true, isSaved: false);
          bool isSuccessful = await _userRepository.createUser(_user);
          yield UserState(isSaving: false, isSaved: isSuccessful, hasFailure: !isSuccessful);
          break;
      case UserEvents.updateUser: 
          yield UserState( isSaving: true, isSaved: false);
          bool isSuccessful = await _userRepository.updateUser(_user);
          yield UserState(isSaving: false, isSaved: isSuccessful, hasFailure: !isSuccessful);
          break;
      case UserEvents.deleteUser:
          yield UserState( isDeleting: true, isDeleted: false);
          bool isSuccessful = await _userRepository.deleteUser(_id);
          yield UserState(isDeleting: false, isDeleted: isSuccessful, hasFailure: !isSuccessful);
          break;  
    }

  }




}