import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qt_bloc_app/models/user.dart';


class UserRepository { 
  static const String baseUrl = "https://qt-app-backend.herokuapp.com/api";

  Future<List<User>> getAllUsers() async { 
    print('Calling');
    var response = await http.get("$baseUrl/users");
    print('Response ${response.body}');
    Iterable userList = json.decode(response.body);
    List<User> users = userList.map((user) => user.fromJson(user)).toList();
    
    return users;
  }

  Future<User> getUserById(String id) async { 
    var response = await http.get("$baseUrl/users/$id");
    var jsonUser = json.decode(response.body);
    User user = User.fromJson(jsonUser);
    return user;
  }

 

    Future<bool> createUser(User user) async {
      print('Here,,,,,');
      print(user.toJson());
     var response = await http.post(
      "$baseUrl/auth/signup",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(user.toJson(),)
    );

      print('Response : ${response.body}');
    return response.statusCode == 201;
  }

  Future<bool> updateUser(User user) async { 
    var response = await http.put("$baseUrl/users/${user.id}" , headers: {"Content-Type": "application/json"}, body: json.encode(user.toJson()));
    return response.statusCode == 200;
  }

  Future<bool> deleteUser(String id) async { 
    var response = await http.delete("$baseUrl/users/$id");
    return response.statusCode == 200;
  }

  // Login 

  Future<bool> login(String username, String password) async { 
    var response = await http.post("$baseUrl/auth/signin",
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'username': username,
        'password': password
      }),
    );

    print(response.body);

    if (response.statusCode != 200)
      throw Exception();
    
    return response.statusCode == 200;
  }

  
  
}