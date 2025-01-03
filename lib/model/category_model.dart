import 'event_model.dart';

class CategoryModel {
  final int id;
  final String libelle;
  final String img;
  final List<EventModel> events;

  CategoryModel({
    required this.id,
    required this.libelle,
    required this.img,
    required this.events,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 1,
      libelle: 'Entreprise',
      img:
          'https://www.mega.com/sites/tera/files/2023-07/architecture-entreprise-definition%20%281%29.webp',
      events: [],
    ),
    CategoryModel(
      id: 2,
      libelle: 'Culture et Art',
      img:
          'https://tourismecotedivoire.ci/wp-content/uploads/2022/01/Zaouli.jpg',
      events: [],
    ),
    CategoryModel(
      id: 3,
      libelle: 'Sport',
      img:
          'https://resize.elle.fr/square/var/plain_site/storage/images/minceur/news/sport-et-forme/sport-intensif-3021821/60232385-1-fre-FR/Hard-Gym-le-phenomene-du-sport-intensif.jpg',
      events: [],
    ),
    CategoryModel(
      id: 4,
      libelle: 'Social',
      img:
          'https://media.licdn.com/dms/image/D5612AQERMBHsst6Pjg/article-cover_image-shrink_720_1280/0/1656799109431?e=2147483647&v=beta&t=m4g2cMZImnQ_S3mHVYSEcJQ_ItH3gHi7iQ6stil95YE',
      events: [
        EventModel.eventList[1],
        EventModel.eventList[2],
      ],
    ),
    CategoryModel(
      id: 5,
      libelle: 'Education',
      img:
          'https://assets.globalpartnership.org/s3fs-public/styles/standard_blog_banner/public/39815677115_1a00a8e51e_k_1_2.jpg?VersionId=rM36cV8LmsWKsaV2EhCSLm2AKp_3tQTJ&itok=iBseoC17',
      events: [],
    ),
    CategoryModel(
      id: 6,
      libelle: 'Charité et Levée de fonds',
      img:
          'https://media.istockphoto.com/id/886006886/fr/vectoriel/mains-mettre-des-pi%C3%A8ces-dans-la-bo%C3%AEte-de-don-faire-un-don-de-la-notion-de-charit%C3%A9-argent.jpg?s=612x612&w=0&k=20&c=UK0W6DOGdLWSAt3UnlqrdShiJVwExTZfEUrnLxqjbNE=',
      events: [EventModel.eventList[3]],
    ),
    CategoryModel(
      id: 7,
      libelle: 'Divertissement',
      img:
          'https://www.capgemini.com/wp-content/uploads/2021/08/Capgemini_Industries-Media-and-Entertainment.jpg',
      events: [EventModel.eventList[4]],
    ),
    CategoryModel(
      id: 8,
      libelle: 'Religieux',
      img:
          'https://gdb.voanews.com/15D4E5D3-5079-44EB-835B-E71E7A8AFB94_w1080_h608_s.jpg',
      events: [EventModel.eventList[0]],
    ),
  ];
}
