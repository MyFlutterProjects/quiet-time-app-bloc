class User { 
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String gender;
  final String dateOfBirth;
  final String email;
  final String roles;
  final String residence;
  String password;

  User({ this.id, this.firstName, this.lastName, this.username,this.gender, this.email, this.dateOfBirth,  this.roles, this.residence, this.password});

  User.fromJson(Map json)
    : id = json["_id"]["\$oid"],
    firstName = json["firstName"],
    lastName = json["lastName"],
    username = json["username"],
    gender =  json["gender"],
    dateOfBirth = json["dateOfBirth"],
    email = json["email"],
    roles = json["roles"],
    residence = json["residence"];


    Map toJson() { 
      return { 
        'firstName': firstName,
        'lastName': lastName,
        'username':username,
        'gender':gender,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'roles':['$roles'],
        'residence': residence,
        'password': password
      };
    }
}