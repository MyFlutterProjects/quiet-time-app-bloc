import 'package:bloc/bloc.dart';
import 'package:qt_bloc_app/models/user.dart';
import 'package:qt_bloc_app/repositories/user_repositories.dart';

enum UserEvents { loadUsers }

class UserListBloc extends Bloc<UserEvents, List<User>> { 
  UserRepository _userRepository;

  UserListBloc() { 
    _userRepository = UserRepository();
  }

  @override 
  List<User> get initialState => [];

  void loadUsers() {
    this.add(UserEvents.loadUsers);
  }
  
  // @override 
  // Stream<List<User>> mapEventToState (List<User> currentState, UserEvents event) async* { 
  //   switch(event) { 
  //     case UserEvents.loadUsers:
  //          var users = await _userRepository.getAllUsers();
  //          yield users;
  //   }

  //   }

  @override 
  Stream<List<User>> mapEventToState (UserEvents event) async* { 
    switch(event) { 
      case UserEvents.loadUsers:
           var users = await _userRepository.getAllUsers();
           yield users;
    }

    }
}