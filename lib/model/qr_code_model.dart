// To parse this JSON data, do
//
//     final qrCodeModel = qrCodeModelFromJson(jsonString);

import 'dart:convert';

import 'user.dart';

QrCodeModel qrCodeModelFromJson(String str) =>
    QrCodeModel.fromJson(json.decode(str));

String qrCodeModelToJson(QrCodeModel data) => json.encode(data.toJson());

////////////////////// list apis /////////////////////////
///
List<QrCodeModel> qrCodeModelListFromJson(String str) => List<QrCodeModel>.from(
    json.decode(str).map((x) => QrCodeModel.fromJson(x)));

String qrCodeModelListToJson(List<QrCodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

///
/////////////////////////////////////////////////////

class QrCodeModel {
  final int id;
  bool isActive;
  final String type;
  final DateTime dateDebut;
  final DateTime? dateFin;
  //final String imgUrl;
  final String codeAssociate;
  bool isAlreadyScanned;
  final User user;

  QrCodeModel({
    required this.id,
    required this.isActive,
    required this.type,
    required this.dateDebut,
    required this.dateFin,
    //required this.imgUrl,
    required this.codeAssociate,
    required this.isAlreadyScanned,
    required this.user,
  });

  factory QrCodeModel.fromJson(Map<String, dynamic> json) => QrCodeModel(
        id: json["id"],
        isActive: json["is_active"] == 1 ? true : false,
        type: json["type"].toLowerCase(),
        dateDebut: DateTime.parse(json["date_debut"]),
        dateFin:
            json["date_fin"] != null ? DateTime.parse(json["date_fin"]) : null,
        //imgUrl: json["img_url"],
        codeAssociate: json["code_visite"] == null ? '' : json["code_visite"],
        isAlreadyScanned: json["is_already_scanned"] == 1 ? true : false,
        user: User.fromJson(json["visite"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "type": type,
        "date_debut": dateDebut.toIso8601String(),
        "date_fin": dateFin?.toIso8601String(),
        // "img_url": imgUrl,
        "code_associate": codeAssociate,
        "is_already_scanned": isAlreadyScanned,
        "user": user.toJson(),
      };

  static List<QrCodeModel> qrCodeList = [
    /* QrCodeModel(
      id: 1,
      isActive: true,
      type: "temporaire",
      dateDebut: DateTime.now(),
      dateFin: DateTime.now().add(const Duration(days: 30)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-000",
      isAlreadyScanned: true,
      user: User.userList[0],
    ),
    QrCodeModel(
        id: 2,
        isActive: true,
        type: "permanent",
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().add(const Duration(days: 70)),
        //imgUrl: "imgUrl",
        codeAssociate: "AG-XF-2023-001",
        isAlreadyScanned: true,
        user: User.userList[1]),
    QrCodeModel(
        id: 3,
        isActive: true,
        type: "temporaire",
        dateDebut: DateTime.now().subtract(const Duration(days: 15)),
        dateFin: DateTime.now().add(const Duration(days: 30)),
        //imgUrl: "imgUrl",
        codeAssociate: "AG-XF-2023-002",
        isAlreadyScanned: true,
        user: User.userList[2]),
    QrCodeModel(
      id: 4,
      isActive: false,
      type: "permanent",
      dateDebut: DateTime.now().subtract(const Duration(days: 5)),
      dateFin: DateTime.now().add(const Duration(days: 100)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-003",
      isAlreadyScanned: true,
      user: User.userList[3],
    ),
    QrCodeModel(
      id: 5,
      isActive: false,
      type: "temporaire",
      dateDebut: DateTime.now(),
      dateFin: DateTime.now().add(const Duration(days: 30)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-004",
      isAlreadyScanned: false,
      user: User.userList[4],
    ),
    QrCodeModel(
      id: 6,
      isActive: true,
      type: "temporaire",
      dateDebut: DateTime.now(),
      dateFin: DateTime.now().add(const Duration(days: 30)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-005",
      isAlreadyScanned: true,
      user: User.userList[5],
    ),
    QrCodeModel(
      id: 7,
      isActive: true,
      type: "permanent",
      dateDebut: DateTime.now().subtract(const Duration(days: 9)),
      dateFin: DateTime.now().add(const Duration(days: 15)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-006",
      isAlreadyScanned: true,
      user: User.userList[6],
    ),
    QrCodeModel(
      id: 8,
      isActive: true,
      type: "temporaire",
      dateDebut: DateTime.now(),
      dateFin: DateTime.now().add(const Duration(days: 30)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-007",
      isAlreadyScanned: false,
      user: User.userList[7],
    ),
    QrCodeModel(
      id: 9,
      isActive: false,
      type: "temporaire",
      dateDebut: DateTime.now(),
      dateFin: DateTime.now().add(const Duration(days: 30)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-008",
      isAlreadyScanned: true,
      user: User.userList[8],
    ),
    QrCodeModel(
      id: 10,
      isActive: true,
      type: "permanent",
      dateDebut: DateTime.now().subtract(const Duration(days: 30)),
      dateFin: DateTime.now().add(const Duration(days: 90)),
      //imgUrl: "imgUrl",
      codeAssociate: "AG-XF-2023-009",
      isAlreadyScanned: true,
      user: User.userList[9],
    ), */
  ];
}
