// To parse this JSON data, do
//
//     final scanHistoryModel = scanHistoryModelFromJson(jsonString);

import 'dart:convert';

ScanHistoryModel scanHistoryModelFromJson(String str) =>
    ScanHistoryModel.fromJson(json.decode(str));

String scanHistoryModelToJson(ScanHistoryModel data) =>
    json.encode(data.toJson());

/////////////////////////////////////////////////////////////////
///

List<ScanHistoryModel> scanHistoryModelListFromJson(String str) =>
    List<ScanHistoryModel>.from(
        json.decode(str).map((x) => ScanHistoryModel.fromJson(x)));

String scanHistoryModelListToJson(List<ScanHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

///
////////////////////////////////////////////////////////////////////

class ScanHistoryModel {
  final int id;
  final int qrCodeId;
  final DateTime scandDate;
  final String scanHour;
  final String motif;

  ScanHistoryModel({
    required this.id,
    required this.qrCodeId,
    required this.scandDate,
    required this.scanHour,
    required this.motif,
  });

  factory ScanHistoryModel.fromJson(Map<String, dynamic> json) =>
      ScanHistoryModel(
        id: json["id"],
        qrCodeId: json["qr_code_id"],
        scandDate: DateTime.parse(json["scan_date"]),
        scanHour: json["scan_hour"].substring(0, 5),
        motif: json["motif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qr_code_id": qrCodeId,
        "scan_date": scandDate.toIso8601String(),
        "scan_hour": scanHour,
        "motif": motif,
      };

  static DateTime today = DateTime(
    DateTime.now().subtract(const Duration(days: 2)).year,
    DateTime.now().subtract(const Duration(days: 2)).month,
    DateTime.now().subtract(const Duration(days: 2)).day,
  );

  static List<ScanHistoryModel> scanHistories = [
    /* ScanHistoryModel(
      id: 1,
      qrCodeId: 1,
      scandDate: today.add(const Duration(days: 2)),
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 1,
      qrCodeId: 1,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 2,
      qrCodeId: 1,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 3,
      qrCodeId: 1,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 4,
      qrCodeId: 1,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 5,
      qrCodeId: 1,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 6,
      qrCodeId: 1,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 7,
      qrCodeId: 1,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 8,
      qrCodeId: 1,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),
    ////////////////////
    ///
    /////////////////////
    ScanHistoryModel(
      id: 9,
      qrCodeId: 2,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 10,
      qrCodeId: 2,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 11,
      qrCodeId: 2,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 12,
      qrCodeId: 2,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 13,
      qrCodeId: 2,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 14,
      qrCodeId: 2,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 15,
      qrCodeId: 2,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 16,
      qrCodeId: 2,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),
    //////////////////////////:
    ///
    ScanHistoryModel(
      id: 72,
      qrCodeId: 3,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 33,
      qrCodeId: 3,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 34,
      qrCodeId: 3,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 22,
      qrCodeId: 3,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 45,
      qrCodeId: 3,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 56,
      qrCodeId: 3,
      scandDate: today.add(const Duration(
        days: 1,
      )),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 37,
      qrCodeId: 3,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 111,
      qrCodeId: 3,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),

    ///////////////////////////
    ///
    ///
    ScanHistoryModel(
      id: 1234,
      qrCodeId: 4,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 234,
      qrCodeId: 4,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 1232,
      qrCodeId: 4,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 3432,
      qrCodeId: 4,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 3209,
      qrCodeId: 4,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 3342,
      qrCodeId: 4,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 938,
      qrCodeId: 4,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 333334,
      qrCodeId: 4,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),
    //////////////////
    ///
    ScanHistoryModel(
      id: 1998,
      qrCodeId: 5,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 290088,
      qrCodeId: 5,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 388722,
      qrCodeId: 5,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 4872839,
      qrCodeId: 5,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 534989,
      qrCodeId: 5,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 623784,
      qrCodeId: 5,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 73784,
      qrCodeId: 5,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 78939,
      qrCodeId: 5,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),
    /////////////////////////
    ///
    ScanHistoryModel(
      id: 1327899,
      qrCodeId: 7,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 289003,
      qrCodeId: 7,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 39239834,
      qrCodeId: 7,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 478438392,
      qrCodeId: 7,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 576238,
      qrCodeId: 7,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 638439,
      qrCodeId: 7,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 789328843,
      qrCodeId: 7,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 7893293,
      qrCodeId: 7,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),
    ////////////////////////
    ///
    ScanHistoryModel(
      id: 9993923932,
      qrCodeId: 9,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 338328,
      qrCodeId: 9,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 39900023,
      qrCodeId: 9,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 3323,
      qrCodeId: 9,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 324932,
      qrCodeId: 9,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 32932032,
      qrCodeId: 9,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 23323,
      qrCodeId: 9,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 433223009,
      qrCodeId: 9,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ),
    //////////////////
    ///
    //////////////////////:::
    ScanHistoryModel(
      id: 143,
      qrCodeId: 10,
      scandDate: today,
      scanHour: "8:10",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 244431,
      qrCodeId: 10,
      scandDate: today,
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 332343,
      qrCodeId: 10,
      scandDate: today,
      scanHour: "13:30",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 44334,
      qrCodeId: 10,
      scandDate: today,
      scanHour: "16:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 54342,
      qrCodeId: 10,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "8:45",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 62424,
      qrCodeId: 10,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "12:30",
      motif: "Sortie",
    ),
    ScanHistoryModel(
      id: 723344,
      qrCodeId: 10,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "14:00",
      motif: "Entrée",
    ),
    ScanHistoryModel(
      id: 74343430,
      qrCodeId: 10,
      scandDate: today.add(const Duration(days: 1)),
      scanHour: "17:00",
      motif: "Sortie",
    ), */
  ];
}
