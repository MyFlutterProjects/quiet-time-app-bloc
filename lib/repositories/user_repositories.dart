import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qt_bloc_app/models/user.dart';


class UserRepository { 
  static const String baseUrl = "https://quiet-time-backend.herokuapp.com/api";

  Future<List<User>> getAllUsers() async { 
    var response = await http.get("$baseUrl/users");
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

  // Future<bool> createUser(User user) async { 
  //   print(user.toJson());
  //   print(json.encode(user.toJson()));
  //   var response = await http.post("$baseUrl/auth/signup",  
  //   headers: {"Content-Type": "applicaton/json"},
  //   body: json.encode(
  //     user.toJson(),
  //   ),
  //   );
  //   print('Response : ${response.body}');
  //   return response.statusCode == 201;
  // }

    Future<bool> createUser(User user) async { 
    print(user.toJson());
    print(json.encode(user.toJson()));
    var response = await http.Client().post("$baseUrl/auth/signup",  
    headers: <String, String>{ 
      "Content-Type": "applicaton/json" 
      },
    body: json.encode(
      user.toJson(),
    ),
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
  
}