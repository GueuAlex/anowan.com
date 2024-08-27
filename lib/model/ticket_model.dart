// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

import 'event_model.dart';
import 'order_model.dart';
import 'pass_model.dart';

TicketModel ticketModelFromJson(String str) =>
    TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

// liste
List<TicketModel> listTicketModelFromJson(String str) => List<TicketModel>.from(
    json.decode(str).map((x) => TicketModel.fromJson(x)));

String listTicketModelToJson(List<TicketModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketModel {
  final int id;
  final int eventId;
  final int orderId;
  final int passId;
  final String uniqueCode;
  final String pdfPath;
  final String? qrcode;
  final bool scanned;
  final DateTime? scannedAt;
  final bool active;
  final String nameOnTicket;
  final String firstnameOnTicket;
  final String sendToEmail;
  final String sendToPhone;
  final int participantId;
  /* final String participantType; */
  final String peopleNumber;
  final String shortUrl;
  final PassModel pass;
  final EventModel event;
  final OrderModel order;

  TicketModel({
    required this.id,
    required this.eventId,
    required this.orderId,
    required this.passId,
    required this.uniqueCode,
    required this.pdfPath,
    required this.qrcode,
    required this.scanned,
    required this.scannedAt,
    required this.active,
    required this.nameOnTicket,
    required this.firstnameOnTicket,
    required this.sendToEmail,
    required this.sendToPhone,
    required this.participantId,
    /* required this.participantType, */
    required this.peopleNumber,
    required this.shortUrl,
    required this.pass,
    required this.event,
    required this.order,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json["id"],
        eventId: json["event_id"],
        orderId: json["order_id"],
        passId: json["pass_id"],
        uniqueCode: json["unique_code"],
        pdfPath: json["pdf_path"],
        qrcode: json["qrcode"],
        scanned: json["scanned"] == 0 ? false : true,
        scannedAt: json["scanned_at"] != null
            ? DateTime.parse(json["scanned_at"])
            : null,
        active: json["active"] == 0 ? false : true,
        nameOnTicket: json["name_on_ticket"],
        firstnameOnTicket: json["firstname_on_ticket"],
        sendToEmail: json["send_to_email"],
        sendToPhone: json["send_to_phone"],
        participantId: json["participant_id"],
        /* participantType: json["participant_type"], */
        peopleNumber: json["people_number"],
        shortUrl: json["short_url"],
        pass: PassModel.fromJson(json["pass"]),
        event: EventModel.fromJson(json["event"]),
        order: OrderModel.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "order_id": orderId,
        "pass_id": passId,
        "unique_code": uniqueCode,
        "pdf_path": pdfPath,
        "qrcode": qrcode,
        "scanned": scanned,
        "scanned_at": scannedAt,
        "active": active,
        "name_on_ticket": nameOnTicket,
        "firstname_on_ticket": firstnameOnTicket,
        "send_to_email": sendToEmail,
        "send_to_phone": sendToPhone,
        "participant_id": participantId,
        /* "participant_type": participantType, */
        "people_number": peopleNumber,
        "short_url": shortUrl,
        "pass": pass.toJson(),
        "event": event.toJson(),
        "order": order.toJson(),
      };

  static List<TicketModel> tickList = listTicketModelFromJson(ticketData);
}

String ticketData = """[{
    "id": 3198,
    "event_id": 36,
    "order_id": 1011,
    "pass_id": 46,
    "unique_code": "907148889670433",
    "pdf_path": "CDL-907148889670433-1724364274.pdf",
    "qrcode": "iVBORw0KGgoAAAANSUhEUgAAAD8AAAA/AQMAAABtkYKcAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAKJJREFUKJF10LsNwzAMBFAaKtw5CxjQGuq0kiYInAU0UzqvIYALsExhkDkhTmGbZvUafo5k9mHNpnRFoxQk0eSANW0lWb3BdItWfGBy1H3FCf2e+j/siF5P2usIk2T2xmQPo5kFdRAlB6G4OAjoFWR00AbjOsbqALWVPBcHSNFXVwfIPiOCOsDH6IH4Plgyyw3wscUBJvNr/a04Afe0YUX7BV/QLiRscfI+dQAAAABJRU5ErkJggg==",
    "scanned": 0,
    "scanned_at": null,
    "active": 1,
    "created_at": "2024-08-22T22:03:50.000000Z",
    "updated_at": "2024-08-22T22:04:36.000000Z",
    "name_on_ticket": "",
    "firstname_on_ticket": "",
    "send_to_email": "",
    "send_to_phone": "",
    "participant_id": 934,
    "people_number": "1",
    "short_url": "jWiq1C",
    "pass": {
        "id": 46,
        "event_id": 36,
        "name": "Standard",
        "description": "Standard",
        "price": 100,
        "passes_quantity": "15",
        "remaining_passes": "15",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-22T17:48:15.000000Z",
        "updated_at": "2024-08-23T12:15:14.000000Z",
        "people_max": "1"
    },
    "event": {
        "id": 36,
        "organizer_id": 12,
        "category_id": 2,
        "event_type_id": 1,
        "package_id": 2,
        "name": "CONCERT DE L'ESPERANCE",
        "unique_code": "8724131404",
        "slug": "concert-de-lesperance",
        "description": "<p>Le <strong>Concert de l’Espérance</strong> est un événement musical organisé dans le but de lever des fonds pour la construction d’une chapelle dédiée à <strong>Padre Pio</strong>. Ce concert rassemble des artistes et des musiciens qui se produisent pour soutenir cette noble cause. L’objectif principal est de réunir la communauté autour de la musique et de la foi, tout en collectant des dons nécessaires pour la réalisation de ce projet spirituel et architectural.</p>",
        "short_description": "Le Concert de l’Espérance est un événement musical organisé dans le but de lever des fonds pour la construction d’une chapelle dédiée à Padre Pio.",
        "free": 0,
        "qrcode": "iVBORw0KGgoAAAANSUhEUgAAAGMAAABjAQMAAAC19SzWAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAUdJREFUOI2N1MGNwyAQBdCxOHAzDSC5Dd9oKVTguAHcEjfaQKKBcOOAdvbjzdXDokjxk4LymWFMzC0vjcgp5kySMu354O2zlzfJKj97XzVfrVxtKg6k3qT+oS3sI8tMyMJvKhzVN9mjcL4S9vH5nvZRWKqmbtL9KKmbpq5kTcwe+yRZH/PC5Uz0QnZJ29mQmoO25CbiZFe3XZHPKKsbRgp7J8qiVI0qEK3avu6jPssaxqLVYbcsws89KpH6EmUhBZlkD3QDHZPUPU42aobikSh0tRMKpjm4mfQWRs1wZWQxbmtt9mAeWURhR0DfUh9ZJClu/WD8D3+cLFoSWoG+Yf5kdY+axbsbSRYW7iDamw3LwqwQaSKMi5OV72/ULK86ixrTX9n6hixTqfGe0Jh+mmk04Yx4kDWy1MT1b6YljXekiVvFxMQs6RfpXZgD+wBUVQAAAABJRU5ErkJggg==",
        "image": "compressed-worship-1724350574.jpg",
        "published": 1,
        "active": 1,
        "created_at": "2024-08-22T17:48:15.000000Z",
        "updated_at": "2024-08-22T18:16:32.000000Z",
        "published_at": "2024-08-22 17:48:35",
        "payment_terms": null,
        "infoline": "07 10 07 43 74",
        "visibility": 0,
        "short_url": "HXVqCs",
        "inspectors": [
            {
                "id": 17,
                "name": "Ekra",
                "firstname": "Isabelle",
                "phone": "0759619352",
                "email": "Isabelleyebe@gmail.com",
                "scan_token": "976640",
                "created_at": "2024-08-22T21:59:51.000000Z",
                "updated_at": "2024-08-22T21:59:51.000000Z",
                "pivot": {
                    "event_id": 36,
                    "inspector_id": 17
                }
            }
        ],
        "localizations": [
            {
                "id": 33,
                "event_id": 36,
                "date_event": "2024-09-29",
                "starttime_event": "14:30:00",
                "endtime_event": "18:00:00",
                "place": "Fraternité saint Padre Pio des Freres Mineurs Capucins Cocody Angré",
                "longitude": null,
                "latitude": null,
                "created_at": "2024-08-22T17:48:15.000000Z",
                "updated_at": "2024-08-22T18:11:00.000000Z"
            }
        ],
        "organizer": {
      "id": 1,
      "user_id": 2,
      "avatar": null,
      "name": "Soro David",
      "unique_code": "2852664",
      "phone": null,
      "description": null,
      "active": 1,
      "short_description": null,
      "website": null,
      "facebook": null,
      "twitter": null,
      "instagram": null,
      "created_at": "2024-02-15T15:59:25.000000Z",
      "updated_at": "2024-02-15T15:59:25.000000Z",
      "user": {
        "id": 2,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "sorogneneyeridavid@gmail.com",
        "email_verified_at": "2024-02-15T15:59:13.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-02-15T15:58:53.000000Z",
        "updated_at": "2024-02-15T16:09:17.000000Z",
        "phone_code": "+225"
      }
    }
    },
    "order": {
        "id": 1011,
        "event_id": 36,
        "unique_code": "878585703998",
        "amount": "101",
        "status": 1,
        "orderable_id": 934,
        
        "created_at": "2024-08-22T22:03:50.000000Z",
        "updated_at": "2024-08-22T22:04:31.000000Z",
        "fees": "1",
        "sms_fees": "0",
        "amount_available": "95",
        "pack_levy": "5",
        "amount_ht": "100",
        "comments": null,
        "sms_quantity": 0
    }
}]""";
