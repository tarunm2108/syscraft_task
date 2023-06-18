import 'dart:convert';

ApiResp apiRespFromJson(String str) => ApiResp.fromJson(json.decode(str));

String apiRespToJson(ApiResp data) => json.encode(data.toJson());

class ApiResp {
  List<User>? users;

  ApiResp({
    this.users,
  });

  factory ApiResp.fromJson(Map<String, dynamic> json) => ApiResp(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  int? id;
  String? firstName;
  Address? address;
  Company? company;

  User({
    this.id,
    this.firstName,
    this.address,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "address": address?.toJson(),
        "company": company?.toJson(),
      };
}

class Address {
  String? address;
  String? city;

  Address({
    this.address,
    this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
      };
}

class Company {
  Address? address;
  String? department;
  String? name;
  String? title;

  Company({
    this.address,
    this.department,
    this.name,
    this.title,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        department: json["department"],
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "department": department,
        "name": name,
        "title": title,
      };
}
