class ArtistModel {
  int? id;
  int? userId;
  String? name;
  String? dob;

  ArtistModel({
    this.id,
    this.userId,
    this.name,
    this.dob,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        id: json['id'] == null ? null : json["id"],
        userId: json['user_id'] == null ? null : json["user_id"],
        name: json['name'] == null ? null : json["name"],
        dob: json['dob'] == null ? null : json["dob"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "dob": dob,
      };
}
