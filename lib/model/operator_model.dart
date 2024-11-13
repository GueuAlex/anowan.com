class OperatorModel {
  final String name;
  final String assetPath;

  OperatorModel({required this.name, required this.assetPath});

  static List<OperatorModel> operators = [
    OperatorModel(name: 'Orange Money', assetPath: 'assets/images/pay1.jpg'),
    OperatorModel(name: 'Mobile Money', assetPath: 'assets/images/pay3.png'),
    OperatorModel(name: 'Moov Money', assetPath: 'assets/images/pay2.png'),
    OperatorModel(name: 'Wave', assetPath: 'assets/images/pay4.png'),
  ];
}
