class PassModel {
  int id;
  int eventId;
  String name;
  String description;
  int price;

  PassModel({
    required this.id,
    required this.eventId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory PassModel.fromJson(Map<String, dynamic> json) => PassModel(
        id: json["id"],
        eventId: json["event_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "name": name,
        "description": description,
        "price": price,
      };

  static List<PassModel> eventList = [
    PassModel(
      id: 1,
      eventId: 101,
      name: 'Pass Standard',
      description: 'Accès standard à l\'événement',
      price: 10000,
    ),
    PassModel(
      id: 2,
      eventId: 102,
      name: 'Pass VIP',
      description: 'Accès VIP avec sièges réservés',
      price: 25000,
    ),
    PassModel(
      id: 3,
      eventId: 103,
      name: 'Pass Étudiant',
      description: 'Réduction pour les étudiants',
      price: 2000,
    ),
    PassModel(
      id: 4,
      eventId: 104,
      name: 'Pass Premium',
      description: 'Accès premium avec avantages exclusifs',
      price: 50000,
    ),
    PassModel(
      id: 5,
      eventId: 105,
      name: 'Pass Général',
      description: 'Accès général à toutes les zones',
      price: 4000,
    ),
  ];
}
