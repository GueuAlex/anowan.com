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
}
