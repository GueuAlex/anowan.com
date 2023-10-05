// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'members_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String genre;
  String nom;
  String prenoms;
  String entreprise;
  String numeroCni;
  String plaqueVehicule;
  String email;
  String number;
  String entrepotVisite;
  String motifVisite;
  List<Member> members;

  User({
    required this.id,
    required this.genre,
    required this.nom,
    required this.prenoms,
    required this.entreprise,
    required this.numeroCni,
    required this.plaqueVehicule,
    required this.email,
    required this.number,
    required this.entrepotVisite,
    required this.motifVisite,
    this.members = const [],
  });

  int get getId => id;
  set setId(int value) => id = value;

  String get getGenre => genre;
  set setGenre(String value) => genre = value;

  String get getNom => nom;
  set setNom(String value) => nom = value;

  String get getPrenoms => prenoms;
  set setPrenoms(String value) => prenoms = value;

  String get getEntreprise => entreprise;
  set setEntreprise(String value) => entreprise = value;

  String get getNumeroCni => numeroCni;
  set setNumeroCni(String value) => numeroCni = value;

  String get getPlaqueVehicule => plaqueVehicule;
  set setPlaqueVehicule(String value) => plaqueVehicule = value;

  String get getEmail => email;
  set setEmail(String value) => email = value;

  String get getNumber => number;
  set setNumber(String value) => number = value;

  String get getEntrepotVisite => entrepotVisite;
  set setEntrepotVisite(String value) => entrepotVisite = value;

  String get getMotifVisite => motifVisite;
  set setMotifVisite(String value) => motifVisite = value;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        genre: json["genre"] == null ? '' : json["genre"],
        nom: json["nom"],
        prenoms: json["prenoms"],
        entreprise: json["entreprise"],
        numeroCni: json["numero_cni"] == null ? '' : json["numero_cni"],
        plaqueVehicule:
            json["plaque_vehicule"] == null ? '' : json["plaque_vehicule"],
        email: json["email"] == null ? '' : json["email"],
        number: json["number"] == null ? '' : json["number"],
        entrepotVisite:
            json["entrepot_visite"] == null ? '' : json["entrepot_visite"],
        motifVisite: json["motif"] == null || json["motif"]["libelle"] == null
            ? ''
            : json["motif"]["libelle"].toLowerCase(),
        members: List<Member>.from(
            json["membre_visites"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "genre": genre,
        "nom": nom,
        "prenoms": prenoms,
        "entreprise": entreprise,
        "numero_cni": numeroCni,
        "plaque_vehicule": plaqueVehicule,
        "email": email,
        "number": number,
        "entrepot_visite": entrepotVisite,
        "motif_visite": motifVisite,
      };

  static List<User> userList = [
    /* User(
      id: 1,
      genre: "M",
      nom: "Doe",
      prenoms: "John",
      entreprise: "XYZ Company",
      numeroCni: "1234567890",
      plaqueVehicule: "ABC123",
      email: "john.doe@example.com",
      number: "123456789",
      entrepotVisite: "Entrepôt A",
      motifVisite: "Livraison",
    ),
    User(
      id: 2,
      genre: "F",
      nom: "Smith",
      prenoms: "Jane",
      entreprise: "ABC Corporation",
      numeroCni: "0987654321",
      plaqueVehicule: "XYZ789",
      email: "jane.smith@example.com",
      number: "987654321",
      entrepotVisite: "Entrepôt B",
      motifVisite: "Réapprovisionnement",
    ),
    // Ajoutez les 8 utilisateurs supplémentaires ici
    User(
      id: 3,
      genre: "M",
      nom: "Garcia",
      prenoms: "Carlos",
      entreprise: "Acme Inc.",
      numeroCni: "5432167890",
      plaqueVehicule: "DEF456",
      email: "carlos.garcia@example.com",
      number: "876543210",
      entrepotVisite: "Entrepôt C",
      motifVisite: "Maintenance",
    ),
    User(
      id: 4,
      genre: "F",
      nom: "Chen",
      prenoms: "Li",
      entreprise: "Global Corp",
      numeroCni: "9087612345",
      plaqueVehicule: "GHI789",
      email: "li.chen@example.com",
      number: "543216789",
      entrepotVisite: "Entrepôt D",
      motifVisite: "Inspection",
    ),
    User(
      id: 5,
      genre: "M",
      nom: "Kumar",
      prenoms: "Raj",
      entreprise: "Tech Solutions",
      numeroCni: "6543217890",
      plaqueVehicule: "JKL456",
      email: "raj.kumar@example.com",
      number: "098761234",
      entrepotVisite: "Entrepôt E",
      motifVisite: "Réparation",
    ),
    User(
      id: 6,
      genre: "F",
      nom: "Lee",
      prenoms: "Soo",
      entreprise: "Innovate Ltd.",
      numeroCni: "4321657890",
      plaqueVehicule: "MNO789",
      email: "soo.lee@example.com",
      number: "654321789",
      entrepotVisite: "Entrepôt F",
      motifVisite: "Récupération",
    ),
    User(
      id: 7,
      genre: "M",
      nom: "Gonzalez",
      prenoms: "Luis",
      entreprise: "Dynamic Co.",
      numeroCni: "9012345678",
      plaqueVehicule: "PQR456",
      email: "luis.gonzalez@example.com",
      number: "432165789",
      entrepotVisite: "Entrepôt G",
      motifVisite: "Enquête",
    ),
    User(
      id: 8,
      genre: "F",
      nom: "Wang",
      prenoms: "Mei",
      entreprise: "Global Services",
      numeroCni: "5678901234",
      plaqueVehicule: "STU789",
      email: "mei.wang@example.com",
      number: "901234567",
      entrepotVisite: "Entrepôt H",
      motifVisite: "Formation",
    ),
    User(
      id: 9,
      genre: "M",
      nom: "Lopez",
      prenoms: "Juan",
      entreprise: "Epic Ventures",
      numeroCni: "3456789012",
      plaqueVehicule: "VWX456",
      email: "juan.lopez@example.com",
      number: "567890123",
      entrepotVisite: "Entrepôt I",
      motifVisite: "Réunion",
    ),
    User(
      id: 10,
      genre: "F",
      nom: "Kim",
      prenoms: "Mi-Young",
      entreprise: "Mega Corp",
      numeroCni: "6789012345",
      plaqueVehicule: "YZA789",
      email: "miyoung.kim@example.com",
      number: "345678901",
      entrepotVisite: "Entrepôt J",
      motifVisite: "Présentation",
    ), */
  ];
}
