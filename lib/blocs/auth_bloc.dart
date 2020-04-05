import 'package:bloc/bloc.dart';
import 'package:qt_bloc_app/repositories/user_repositories.dart';

enum AuthEvents { login }

class AuthState {
  bool isNotAttemptedAuth;
  bool isAuthenticating;
  bool isAuthFailure;
  bool isAuthenticated;

  AuthState({ 
    this.isAuthFailure =false,
    this.isAuthenticated = false,
    this.isAuthenticating = false,
    this.isNotAttemptedAuth = false    
  });
}

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  UserRepository _userRepository;

  AuthBloc() {
    _userRepository = UserRepository();
  }

  String _username = "";
  String _password = "";

  @override 
  AuthState get initialState => AuthState();

  void authenticate(String username, String password) {
      _username = username;
      _password = password;

      this.add(AuthEvents.login);
  }

  @override 
  Stream<AuthState> mapEventToState(AuthEvents event) async* { 
    switch(event) {
      case AuthEvents.login:
           yield AuthState(isAuthenticating: true, isAuthenticated: false);
           bool isLoggedIn = await _userRepository.login(_username, _password);
           yield AuthState(isAuthenticating: false, isAuthFailure: !isLoggedIn, isAuthenticated: isLoggedIn );
           break;    
    }
  }


}