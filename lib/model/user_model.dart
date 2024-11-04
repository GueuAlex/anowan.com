// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> listUserModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String listUserModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

///single
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

//// crée une class LocalService qui utilise sqflite: ^2.3.3+2 pour gerer le stockage local.
///voici un exemple de cette class.
///

// voici notre premier objet (table) à créer
// écrire une methode de classe UserModel qui va interagire avec localservice pour créer un user.
class UserModel {
  final int id;
  final String name;
  final String? firstname;
  final String? phone;
  final String? email;
  final String? avatar;
  final bool active;
  final String? phoneCode;
  final String? gender;
  final DateTime? birthDate;
  final List<String> interests;
  final List<String> bookmarkedOrganizersId;
  final String? bio;
  final String? favoriteLocation;
  final List<String> about;
  final List<String> bookmarkedEventsId;

  UserModel({
    required this.id,
    required this.name,
    required this.firstname,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.active,
    required this.phoneCode,
    required this.gender,
    required this.birthDate,
    this.bookmarkedEventsId = const [],
    this.interests = const [],
    this.bookmarkedOrganizersId = const [],
    this.bio,
    this.favoriteLocation,
    this.about = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"] ?? "",
        firstname: json["firstname"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        avatar: json["avatar"] ?? "",
        active: json["active"] == 0 ? false : true,
        phoneCode: json["phone_code"] ?? "",
        gender: json["gender"],
        birthDate: json["birth_date"] != null
            ? DateTime.parse(json["birth_date"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstname": firstname,
        "phone": phone,
        "email": email,
        "avatar": avatar,
        "active": active,
        "phone_code": phoneCode,
      };
}
