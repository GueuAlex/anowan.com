// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

import 'package:ticketwave/model/event_model.dart';
import 'package:ticketwave/model/pass_model.dart';

TicketModel ticketModelFromJson(String str) =>
    TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  int id;
  String uniqueCode;
  String qrcode;
  bool active;
  bool scanned;
  PassModel pass;
  EventModel event;

  TicketModel({
    required this.id,
    required this.uniqueCode,
    required this.qrcode,
    required this.active,
    required this.scanned,
    required this.pass,
    required this.event,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json["id"],
        uniqueCode: json["unique_code"],
        qrcode: json["qrcode"],
        active: json["active"] == 0 ? false : true,
        scanned: json["scanned"] == 0 ? false : true,
        pass: PassModel.fromJson(json["pass"]),
        event: EventModel.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_code": uniqueCode,
        "qrcode": qrcode,
        "active": active,
        "scanned": scanned,
        "pass": pass.toJson(),
        "event": event.toJson(),
      };

  static List<TicketModel> tickList = [
    TicketModel(
        id: 1,
        uniqueCode: '123',
        qrcode: 'qrcode',
        active: true,
        scanned: false,
        pass: PassModel.eventList[0],
        event: EventModel.eventList[0]),
    TicketModel(
        id: 1,
        uniqueCode: '456',
        qrcode: 'qrcode',
        active: false,
        scanned: false,
        pass: PassModel.eventList[1],
        event: EventModel.eventList[1]),
    TicketModel(
        id: 1,
        uniqueCode: '789',
        qrcode: 'qrcode',
        active: true,
        scanned: true,
        pass: PassModel.eventList[2],
        event: EventModel.eventList[2]),
    TicketModel(
        id: 1,
        uniqueCode: '1011',
        qrcode: 'qrcode',
        active: true,
        scanned: false,
        pass: PassModel.eventList[3],
        event: EventModel.eventList[3]),
    TicketModel(
        id: 1,
        uniqueCode: '1213',
        qrcode: 'qrcode',
        active: true,
        scanned: false,
        pass: PassModel.eventList[4],
        event: EventModel.eventList[4]),
  ];
}
