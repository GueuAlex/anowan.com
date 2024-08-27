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

class UserModel {
  final int id;
  final String name;
  final String firstname;
  final String phone;
  final String email;
  final DateTime? emailVerifiedAt;
  final String avatar;
  final bool active;
  final String phoneCode;

  UserModel({
    required this.id,
    required this.name,
    required this.firstname,
    required this.phone,
    required this.email,
    required this.emailVerifiedAt,
    required this.avatar,
    required this.active,
    required this.phoneCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"] ?? "",
        firstname: json["firstname"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.parse(json["email_verified_at"])
            : null,
        avatar: json["avatar"] ?? "",
        active: json["active"] == 0 ? false : true,
        phoneCode: json["phone_code"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstname": firstname,
        "phone": phone,
        "email": email,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "avatar": avatar,
        "active": active,
        "phone_code": phoneCode,
      };
}
