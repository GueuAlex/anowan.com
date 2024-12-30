class CountryModel {
  final String name;
  final String code;
  final String flag;
  final String zipCode;
  final String currency;

  CountryModel({
    required this.name,
    required this.code,
    required this.flag,
    required this.zipCode,
    required this.currency,
  });

  static List<CountryModel> get list => [
        CountryModel(
          name: 'Côte d\'Ivoire',
          code: 'ci',
          flag: 'assets/icons/flags/ci.svg',
          zipCode: '225',
          currency: 'XOF',
        ),
        CountryModel(
          name: 'Burkina Faso',
          code: 'bf',
          flag: 'assets/icons/flags/bf.svg',
          zipCode: '226',
          currency: 'XOF',
        ),
        CountryModel(
          name: 'Bénin',
          code: 'bj',
          flag: 'assets/icons/flags/bj.svg',
          zipCode: '229',
          currency: 'XOF',
        ),
        CountryModel(
          name: 'Congo',
          code: 'cg',
          flag: 'assets/icons/flags/cg.svg',
          zipCode: '242',
          currency: 'XAF',
        ),
        CountryModel(
          name: 'Cameroun',
          code: 'cm',
          flag: 'assets/icons/flags/cm.svg',
          zipCode: '237',
          currency: 'XAF',
        ),
        CountryModel(
          name: 'Guinée',
          code: 'gn',
          flag: 'assets/icons/flags/gn.svg',
          zipCode: '224',
          currency: 'GNF',
        ),
        CountryModel(
          name: 'Mali',
          code: 'ml',
          flag: 'assets/icons/flags/ml.svg',
          zipCode: '223',
          currency: 'XOF',
        ),
        CountryModel(
          name: 'Niger',
          code: 'ne',
          flag: 'assets/icons/flags/ne.svg',
          zipCode: '227',
          currency: 'XOF',
        ),
        CountryModel(
          name: 'Sénégal',
          code: 'sn',
          flag: 'assets/icons/flags/sn.svg',
          zipCode: '221',
          currency: 'XOF',
        ),
        CountryModel(
          name: 'Togo',
          code: 'tg',
          flag: 'assets/icons/flags/tg.svg',
          zipCode: '228',
          currency: 'XOF',
        ),
      ];
}

/* Map<String, dynamic> storageData = { // stocker dans la base de données
  "amount": "number",
  "transaction_phone": "string",
  "status": "string",
  "payment_date": "string (ISO format)",
  "command_id": "number",
  "command_type": "string",
  "transaction_id": "string",
  "payment_method": "string",
  "description": "string",
  "currency": "string",
  "payable_id": "number",
  "payable_type": "string",
  "customer_country": "string"
};

Map<String, dynamic> sessionData = { // initialise le paiement
  "idFromClient": "string",
  "additionnalInfos": {
    "recipientEmail": "string (nullable)",
    "recipientFirstName": "string (nullable)",
    "recipientLastName": "string (nullable)",
    "destinataire": "string",
    "otp": "string (nullable)"
  },
  "amount": "number",
  "callback": "string (URL)",
  "recipientNumber": "string",
  "serviceCode": "string"
}; */
