class EventModel {
  int id;
  String name;
  String uniqueId;
  String slug;
  String description;
  String shortDescription;
  DateTime salesDeadline;
  bool free;
  String image;

  EventModel({
    required this.id,
    required this.name,
    required this.uniqueId,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.salesDeadline,
    required this.free,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        uniqueId: json["unique_id"],
        slug: json["slug"],
        description: json["description"],
        shortDescription: json["short_description"],
        salesDeadline: DateTime.parse(json["sales_deadline"]),
        free: json["free"] == 0 ? false : true,
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unique_id": uniqueId,
        "slug": slug,
        "description": description,
        "short_description": shortDescription,
        "sales_deadline":
            "${salesDeadline.year.toString().padLeft(4, '0')}-${salesDeadline.month.toString().padLeft(2, '0')}-${salesDeadline.day.toString().padLeft(2, '0')}",
        "free": free,
        "image": image,
      };

  static List<EventModel> eventList = [
    EventModel(
      id: 1,
      name: "Événement 1",
      uniqueId: "event_1_unique_id",
      slug: "event-1",
      description: "Description de l'événement 1",
      shortDescription: "Courte description de l'événement 1",
      salesDeadline: DateTime(2023, 10, 15),
      free: false,
      image: "image_url_1",
    ),
    EventModel(
      id: 2,
      name: "Événement 2",
      uniqueId: "event_2_unique_id",
      slug: "event-2",
      description: "Description de l'événement 2",
      shortDescription: "Courte description de l'événement 2",
      salesDeadline: DateTime(2023, 11, 20),
      free: true,
      image: "image_url_2",
    ),
    EventModel(
      id: 3,
      name: "Événement 3",
      uniqueId: "event_3_unique_id",
      slug: "event-3",
      description: "Description de l'événement 3",
      shortDescription: "Courte description de l'événement 3",
      salesDeadline: DateTime(2023, 12, 25),
      free: true,
      image: "image_url_3",
    ),
    EventModel(
      id: 4,
      name: "Événement 4",
      uniqueId: "event_4_unique_id",
      slug: "event-4",
      description: "Description de l'événement 4",
      shortDescription: "Courte description de l'événement 4",
      salesDeadline: DateTime(2023, 9, 30),
      free: false,
      image: "image_url_4",
    ),
    EventModel(
      id: 5,
      name: "Événement 5",
      uniqueId: "event_5_unique_id",
      slug: "event-5",
      description: "Description de l'événement 5",
      shortDescription: "Courte description de l'événement 5",
      salesDeadline: DateTime(2023, 10, 10),
      free: true,
      image: "image_url_5",
    ),
  ];
}
