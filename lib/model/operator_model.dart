class OperatorModel {
  final String name;
  final String methodName;
  final String assetPath;

  OperatorModel({
    required this.name,
    required this.assetPath,
    required this.methodName,
  });

  static List<OperatorModel> operators = [
    OperatorModel(
      name: 'Orange Money',
      methodName: 'OM',
      assetPath: 'assets/images/pay1.jpg',
    ),
    OperatorModel(
      name: 'Mobile Money',
      methodName: 'MOMO',
      assetPath: 'assets/images/pay3.png',
    ),
    OperatorModel(
      name: 'Moov Money',
      methodName: 'FLOOZ',
      assetPath: 'assets/images/pay2.png',
    ),
    OperatorModel(
      name: 'Wave',
      methodName: 'WALLET',
      assetPath: 'assets/images/pay4.png',
    ),
  ];
}
