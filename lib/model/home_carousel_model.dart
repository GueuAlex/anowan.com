class CarouselModel {
  final String img;
  final String slogan;

  CarouselModel({required this.img, required this.slogan});

  static List<CarouselModel> list = [
    CarouselModel(
      img: 'assets/images/carousel/carousel6.jpg',
      slogan: 'Créez des connexions, célébrez ensemble',
    ),
    CarouselModel(
      img: 'assets/images/carousel/carousel1.jpg',
      slogan: 'Vivez chaque instant avec passion',
    ),
    CarouselModel(
      img: 'assets/images/carousel/carousel2.jpg',
      slogan: 'Transformez vos moments en souvenirs inoubliables',
    ),
    CarouselModel(
      img: 'assets/images/carousel/carousel3.jpg',
      slogan: 'Vos événements, notre expertise',
    ),
    CarouselModel(
      img: 'assets/images/carousel/carousel4.jpg',
      slogan: 'Participez, partagez, profitez',
    ),
    CarouselModel(
      img: 'assets/images/carousel/carousel5.jpg',
      slogan: 'Des billets pour chaque aventure',
    ),
    CarouselModel(
      img: 'assets/images/carousel/carousel7.jpg',
      slogan: 'Événements exclusifs, accès privilégié',
    ),
  ];
}
