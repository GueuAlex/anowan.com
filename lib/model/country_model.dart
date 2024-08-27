class CountryModel {
  final String name;
  final String code;
  final String flag;
  final String zipCode;

  CountryModel({
    required this.name,
    required this.code,
    required this.flag,
    required this.zipCode,
  });

  static List<CountryModel> get list => [
        CountryModel(
          name: 'Burkina Faso',
          code: 'bf',
          flag: 'assets/icons/flags/bf.svg',
          zipCode: '226',
        ),
        CountryModel(
          name: 'Bénin',
          code: 'bj',
          flag: 'assets/icons/flags/bj.svg',
          zipCode: '229',
        ),
        CountryModel(
          name: 'Congo',
          code: 'cg',
          flag: 'assets/icons/flags/cg.svg',
          zipCode: '242',
        ),
        CountryModel(
          name: 'Côte d\'Ivoire',
          code: 'ci',
          flag: 'assets/icons/flags/ci.svg',
          zipCode: '225',
        ),
        CountryModel(
          name: 'Cameroun',
          code: 'cm',
          flag: 'assets/icons/flags/cm.svg',
          zipCode: '237',
        ),
        CountryModel(
          name: 'Guinée',
          code: 'gn',
          flag: 'assets/icons/flags/gn.svg',
          zipCode: '224',
        ),
        CountryModel(
          name: 'Mali',
          code: 'ml',
          flag: 'assets/icons/flags/ml.svg',
          zipCode: '223',
        ),
        CountryModel(
          name: 'Niger',
          code: 'ne',
          flag: 'assets/icons/flags/ne.svg',
          zipCode: '227',
        ),
        CountryModel(
          name: 'Sénégal',
          code: 'sn',
          flag: 'assets/icons/flags/sn.svg',
          zipCode: '221',
        ),
        CountryModel(
          name: 'Togo',
          code: 'tg',
          flag: 'assets/icons/flags/tg.svg',
          zipCode: '228',
        ),
      ];
}
