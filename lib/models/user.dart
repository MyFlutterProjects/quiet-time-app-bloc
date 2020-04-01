class User { 
  final String id;
  final String firstName;
  final String surname;
  final String email;
  final String roles;

  User({ this.id, this.firstName, this.surname, this.email, this.roles});

  User.fromJson(Map json)
    : id = json["_id"]["\$oid"],
    firstName = json["firstName"],
    surname = json["surname"],
    email = json["email"],
    roles = json["roles"];


    Map toJson() { 
      return { 
        'id': id,
        'first_name': firstName,
        'surname': surname,
        'email': email,
        'roles':['$roles']
      };
    }
}