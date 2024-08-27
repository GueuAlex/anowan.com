class CheckoutMethod {
  final String name;
  final String asset;

  const CheckoutMethod({required this.name, required this.asset});

  static const List<CheckoutMethod> checkoutMethods = [
    CheckoutMethod(name: 'CARTE', asset: 'assets/images/cartes.jpg'),
    CheckoutMethod(name: 'WAVE', asset: 'assets/images/wave.png'),
    CheckoutMethod(name: 'MTN', asset: 'assets/images/mtn.webp'),
    CheckoutMethod(name: 'MOOV', asset: 'assets/images/moow.webp'),
    CheckoutMethod(name: 'ORANGE', asset: 'assets/images/om.png'),
  ];
}
