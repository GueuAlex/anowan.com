import 'dart:convert';

LocalizationModel localizationModelFromJson(String str) =>
    LocalizationModel.fromJson(json.decode(str));

String localizationModelToJson(LocalizationModel data) =>
    json.encode(data.toJson());

class LocalizationModel {
  int id;
  DateTime dateEvent;
  String starttimeEvent;
  String endtimeEvent;
  String place;
  String longitude;
  String latitude;

  LocalizationModel({
    required this.id,
    required this.dateEvent,
    required this.starttimeEvent,
    required this.endtimeEvent,
    required this.place,
    required this.longitude,
    required this.latitude,
  });

  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      LocalizationModel(
        id: json["id"],
        dateEvent: DateTime.parse(json["date_event"]),
        starttimeEvent: json["starttime_event"],
        endtimeEvent: json["endtime_event"],
        place: json["place"],
        longitude: json["longitude"] == null ? "" : json["longitude"],
        latitude: json["latitude"] == null ? "" : json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
    ),
    LocalizationModel(
        id: 2,
        dateEvent: DateTime.now(),
        starttimeEvent: "10:00",
        endtimeEvent: "12:00",
        place: "Place de la maison",
        longitude: "1.23",
        latitude: "2.34"),
    LocalizationModel(
        id: 3,
        dateEvent: DateTime.now(),
        starttimeEvent: "10:00",
        endtimeEvent: "12:00",
        place: "Place de la maison",
        longitude: "1.23",
        latitude: "2.34"),
  ];
}
