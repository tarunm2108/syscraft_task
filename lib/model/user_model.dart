class UserModel {
  int? id;
  String? firstname;
  String? lastname;
  String? dob;
  String? password;
  String? email;
  int? hasWelcome;

  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.dob,
    this.password,
    this.email,
    this.hasWelcome,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] == null ? null : json["id"],
        firstname: json['firstname'] == null ? null : json["firstname"],
        lastname: json['lastname'] == null ? null : json["lastname"],
        email: json['email'] == null ? null : json["email"],
        dob: json['dob'] == null ? null : json["dob"],
        password: json['password'] == null ? null : json["password"],
    hasWelcome: json['hasWelcome'] == null ? null : json["hasWelcome"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "dob": dob,
        "email": email,
        "hasWelcome": hasWelcome,
      };
}
