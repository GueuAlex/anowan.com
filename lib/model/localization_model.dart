import 'dart:convert';

List<LocalizationModel> listLocalizationModelFromJson(String str) =>
    List<LocalizationModel>.from(
        json.decode(str).map((x) => LocalizationModel.fromJson(x)));

String listLocalizationModelToJson(List<LocalizationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
////single
LocalizationModel localizationModelFromJson(String str) =>
    LocalizationModel.fromJson(json.decode(str));

String localizationModelToJson(LocalizationModel data) =>
    json.encode(data.toJson());

class LocalizationModel {
  final int id;
  final int eventId;
  final DateTime dateEvent;
  final DateTime? dateEventEnd;
  final String starttimeEvent;
  final String endtimeEvent;
  final String? place;
  final String? longitude;
  final String? latitude;

  LocalizationModel({
    required this.id,
    required this.eventId,
    required this.dateEvent,
    required this.starttimeEvent,
    required this.endtimeEvent,
    required this.place,
    required this.longitude,
    required this.latitude,
    required this.dateEventEnd,
  });

  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      LocalizationModel(
        id: json["id"],
        eventId: json["event_id"],
        dateEvent: DateTime.parse(json["date_event"]),
        starttimeEvent: json["starttime_event"] ?? '',
        endtimeEvent: json["endtime_event"] ?? '',
        place: json["place"] ?? '',
        longitude: json["longitude"],
        latitude: json["latitude"],
        dateEventEnd: json["date_event_end"] != null
            ? DateTime.parse(json["date_event_end"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "date_event":
            "${dateEvent.year.toString().padLeft(4, '0')}-${dateEvent.month.toString().padLeft(2, '0')}-${dateEvent.day.toString().padLeft(2, '0')}",
        "starttime_event": starttimeEvent,
        "endtime_event": endtimeEvent,
        "place": place,
        "longitude": longitude,
        "latitude": latitude,
      };

  static List<LocalizationModel> localList = [
    LocalizationModel(
      id: 1,
      dateEvent: DateTime.now(),
      starttimeEvent: "10:00",
      endtimeEvent: "12:00",
      place: "Place de la maison",
      longitude: "1.23",
      latitude: "2.34",
      eventId: 0,
      dateEventEnd: null,
    ),
    LocalizationModel(
      id: 2,
      eventId: 0,
      dateEvent: DateTime.now(),
      starttimeEvent: "10:00",
      endtimeEvent: "12:00",
      place: "Place de la maison",
      longitude: "1.23",
      latitude: "2.34",
      dateEventEnd: null,
    ),
    LocalizationModel(
      id: 3,
      eventId: 0,
      dateEvent: DateTime.now(),
      starttimeEvent: "10:00",
      endtimeEvent: "12:00",
      place: "Place de la maison",
      longitude: "1.23",
      latitude: "2.34",
      dateEventEnd: null,
    ),
  ];
}
