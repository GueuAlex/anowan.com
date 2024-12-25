class ThirdPartyModel {
  final String name;
  final String firstname;
  final String? email;
  final String? phone;
  final String? zipcode;
  final String recepient;

  ThirdPartyModel({
    required this.name,
    required this.firstname,
    required this.recepient,
    this.email,
    this.phone,
    this.zipcode,
  });

  // Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'firstname': firstname,
      'email': email,
      'phone': phone,
      'zipcode': zipcode,
      'recepient': recepient,
    };
  }

  // Méthode pour créer l'objet depuis un JSON
  factory ThirdPartyModel.fromJson(Map<String, dynamic> json) {
    return ThirdPartyModel(
      name: json['name'] as String,
      firstname: json['firstname'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      zipcode: json['zipcode'] as String?,
      recepient: json['recepient'] as String,
    );
  }
}
