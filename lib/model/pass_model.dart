import 'dart:convert';

List<PassModel> listPassModelFromJson(String str) =>
    List<PassModel>.from(json.decode(str).map((x) => PassModel.fromJson(x)));

String listPassModelToJson(List<PassModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//single
PassModel passModelFromJson(String str) => PassModel.fromJson(json.decode(str));

String passModelToJson(PassModel data) => json.encode(data.toJson());

class PassModel {
  final int id;
  final int eventId;
  final String name;
  final String? description;
  final int price;
  final String? passesQuantity;
  final String? remainingPasses;
  final bool unlimited;
  final bool active;
  final String peopleMax; // peaople max default 1

  PassModel({
    required this.id,
    required this.eventId,
    required this.name,
    required this.description,
    required this.price,
    required this.passesQuantity,
    required this.remainingPasses,
    required this.unlimited,
    required this.active,
    required this.peopleMax,
  });

  factory PassModel.fromJson(Map<String, dynamic> json) => PassModel(
        id: json["id"],
        eventId: json["event_id"] ?? 0,
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] ?? 0,
        passesQuantity: json["passes_quantity"] ?? '',
        remainingPasses: json["remaining_passes"] ?? '',
        unlimited: json["unlimited"] == 0 ? false : true,
        active: json["active"] == 0 ? false : true,
        peopleMax: json["people_max"] ?? '1',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "name": name,
        "description": description,
        "price": price,
        "passes_quantity": passesQuantity,
        "remaining_passes": remainingPasses,
        "unlimited": unlimited,
        "active": active,
        "people_max": peopleMax,
      };

  static List<PassModel> sortPassesByPrice(List<PassModel> passes) {
    passes.sort((a, b) => a.price.compareTo(b.price));
    return passes;
  }

  static List<PassModel> passList = [
    PassModel(
      id: 1,
      eventId: 101,
      name: 'Pass Standard',
      description: 'Accès standard à l\'événement',
      price: 10000,
      passesQuantity: '1',
      remainingPasses: '1',
      unlimited: true,
      active: true,
      peopleMax: '1',
    ),
    PassModel(
      id: 2,
      eventId: 102,
      name: 'Pass VIP',
      description: 'Accès VIP avec sièges réservés',
      price: 25000,
      passesQuantity: '1',
      remainingPasses: '1',
      unlimited: true,
      active: true,
      peopleMax: '1',
    ),
    PassModel(
      id: 3,
      eventId: 103,
      name: 'Pass Étudiant',
      description: 'Réduction pour les étudiants',
      price: 2000,
      passesQuantity: '1',
      remainingPasses: '1',
      unlimited: true,
      active: true,
      peopleMax: '1',
    ),
    PassModel(
      id: 4,
      eventId: 104,
      name: 'Pass Premium',
      description: 'Accès premium avec avantages exclusifs',
      price: 50000,
      passesQuantity: '1',
      remainingPasses: '1',
      unlimited: true,
      active: true,
      peopleMax: '1',
    ),
    PassModel(
      id: 5,
      eventId: 105,
      name: 'Pass Général',
      description: 'Accès général à toutes les zones',
      price: 4000,
      passesQuantity: '1',
      remainingPasses: '1',
      unlimited: true,
      active: true,
      peopleMax: '1',
    ),
  ];
}
