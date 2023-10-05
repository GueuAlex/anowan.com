class Member {
  final int id;
  final String nom;
  final String prenoms;

  Member({
    required this.id,
    required this.nom,
    required this.prenoms,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        nom: json["nom"] == null ? '' : json["nom"],
        prenoms: json["prenoms"] == null ? '' : json["prenoms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenoms": prenoms,
      };
}
