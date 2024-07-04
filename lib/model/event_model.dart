import 'package:ticketwave/model/localization_model.dart';

import 'inspector_model.dart';

class EventModel {
  int id;
  /* int organizerId;
  int eventTypeId;
  int categoryId;
  int packageId; */
  String name;
  String uniqueId;
  String slug;
  String description;
  String shortDescription;
  /*  DateTime salesDeadline; */
  bool free;
  String image;
  List<InspectorModel> inspectors;
  List<LocalizationModel> localizations;

  EventModel({
    required this.id,
    required this.name,
    required this.uniqueId,
    required this.slug,
    required this.description,
    required this.shortDescription,
    /* required this.salesDeadline, */
    required this.free,
    required this.image,
    required this.inspectors,
    required this.localizations,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        uniqueId: json["unique_code"],
        slug: json["slug"],
        description: json["description"],
        shortDescription: json["short_description"],
        /*  salesDeadline: DateTime.parse(json["sales_deadline"]), */
        free: json["free"] == 0 ? false : true,
        image: json["image"] ?? '',
        inspectors: List<InspectorModel>.from(
            json["inspectors"].map((x) => InspectorModel.fromJson(x))),
        localizations: List<LocalizationModel>.from(
            json["localizations"].map((x) => LocalizationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unique_id": uniqueId,
        "slug": slug,
        "description": description,
        "short_description": shortDescription,
        /* "sales_deadline":
            "${salesDeadline.year.toString().padLeft(4, '0')}-${salesDeadline.month.toString().padLeft(2, '0')}-${salesDeadline.day.toString().padLeft(2, '0')}", */
        "free": free,
        "image": image,
        "inspectors": List<dynamic>.from(inspectors.map((x) => x.toJson())),
      };

  static List<EventModel> eventList = [
    EventModel(
      id: 1,
      name: "Glory Bonjour Cher Partisant ici c'est un test de taille de texte",
      uniqueId: "event_1_unique_id",
      slug: "event-1",
      description:
          "<p>Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins et repartant avec des lots🥰</p><p> </p><p>Nous profitons de ce moment pour récompenser nos meilleurs clients, partageurs, soutiens ...</p><p> </p><p>COÛT DES TICKETS(disponibilité des tickets jusqu'au 12 Août 2024)</p><p> </p><p>    ● 0-6 ans gratuit (20 places) prière rajouter une pièce justificative comme preuve de paiement pour confirmer l'âge. </p><p>   ● 7-15 ans 15000F</p><p>    ● 16 ans et plus 20000F</p><p>    ●Gbonhi (4 personnes) 75000F</p><p> </p>",
      shortDescription:
          "La Glorieuse Louange Œcuménique de Reconnaissance à YHWH, c'est un concert live d’action de grâce, de louange et d’adoration avec le SWC de la Pastorale pour la Propagation de l'Evangile et plusieurs autres chantres invités.",
      /*  salesDeadline: DateTime(2023, 10, 15), */
      free: true,
      image: "https://anowan.com/events/images/glory-ok-1719439197.jpg",
      inspectors: [
        InspectorModel(
            name: "name",
            firstname: "firstname",
            phone: "phone",
            email: "email",
            scanToken: "scanToken"),
      ],
      localizations: [
        LocalizationModel(
          id: 1,
          dateEvent: DateTime.utc(2024, 7, 13),
          starttimeEvent: '15:00',
          endtimeEvent: '19:00',
          place: "Centre culturel ivoiro-coreen - Espace CSCTICAO",
          longitude: "-4.011174518452463",
          latitude: "5.352904082928223",
        )
      ],
    ),
    EventModel(
      id: 2,
      name: "Projection-Débat",
      uniqueId: "event_2_unique_id",
      slug: "event-2",
      description:
          "<p> </p><p>Lauréats de l'édition 2023-2024 de l'appel à projet du MINISTERE DES RELATIONS INTERNATIONALES ET DE LA FRANCOPHONIE DU QUEBEC, les Organisations Oria et Le Centre Padre Pio organisent une conférence pour débattre sur un thème très important:</p><p>Parents COURAGE: Des défis vers la nécessité d’un SOUTIEN réel et efficient.</p><p>Pour débattre de ce sujet , Alexandra Bores, psychologue d'état de la fonction publique française  et conférencière, fera le déplacement de Paris à Abidjan. Elle sera accompagnée d'Hervé Gbohagnon, travailleur psycho-social, en Côte d'Ivoire.</p><p>Les place sont GRATUITES, mais limitées.</p><p> </p><p>Quand?</p><p>Le 18 mai 2024 </p><p>Où?</p><p>A Ivoire Golf club</p><p>Combien?</p><p>L'entrée est GRATUITE</p><p>Pour bien vous délecter de ce débat, une pause café avec de la pâtisserie fine vous sera servi</p>",
      shortDescription:
          "L'organisation Oria en partenariat avec Le Centre Padre Pio Organisent une projection débat pour parler de la nécessité d'accompagner les parents d'enfants déficients intellectuels, autistes, trisomiques et paralytiques cérébraux",
      /* salesDeadline: DateTime(2023, 11, 20), */
      free: true,
      image:
          "https://anowan.com/events/images/projection-debat-2024-04-21-015628.jpg",
      inspectors: [
        InspectorModel(
            name: "name",
            firstname: "firstname",
            phone: "phone",
            email: "email",
            scanToken: "scanToken"),
      ],
      localizations: [
        LocalizationModel(
          id: 2,
          dateEvent: DateTime.utc(2024, 10, 23),
          starttimeEvent: "9:00",
          endtimeEvent: "11:30",
          place: "Ivoire Golf Club Boulevard de France, Abidjan",
          longitude: "-3.9627284752428675",
          latitude: "5.336375441398119",
        )
      ],
    ),
    EventModel(
      id: 3,
      name: "COUPON SOLID-ORIA",
      uniqueId: "event_3_unique_id",
      slug: "event-3",
      description: "Description de l'événement 3",
      shortDescription:
          """Oria est une Association à but non lucratif qui se bat pour l’inclusion scolaire des enfants déficients intellectuels et autistes. 
Dans cette démarche, elle organise un dîner gala, le 18 mai 2024 au Palm Club, afin de collecter des fonds pour équiper l’école inclusive qu’elle va ouvrir en 2025.Pour nous soutenir, vous avez la possibilité, avec nos coupons Solid-Oria, de contribuer à la cause par transfert wave ou orange au +2250700304828 à hauteur de:
10000F, 30000F, 50000F, 100000F et plus. 
Si vous désirez participer à l'événement, cliquez sur ce lien :

 

https://forms.gle/PAJBztWnZ1CTjS3M7""",
      /* salesDeadline: DateTime(2023, 12, 25), */
      free: true,
      image:
          "https://anowan.com/events/images/coupon-solid-oria-2024-03-20-111658.jpg",
      inspectors: [
        InspectorModel(
            name: "name",
            firstname: "firstname",
            phone: "phone",
            email: "email",
            scanToken: "scanToken"),
      ],
      localizations: [
        LocalizationModel(
          id: 3,
          dateEvent: DateTime.utc(2024, 6, 29),
          starttimeEvent: "08:00",
          endtimeEvent: "23:00",
          place: "Palm Club",
          longitude: "-4.002539975242815",
          latitude: "5.353430099515598",
        )
      ],
    ),
    EventModel(
      id: 4,
      name: "GALA POUR L'INCLUSION",
      uniqueId: "event_4_unique_id",
      slug: "event-4",
      description:
          "<p>Un grand projet va voir le jour en Côte d’Ivoire : l’ouverture d’une école inclusive qui accueillera et formera scolairement nos enfants autistes et déficients intellectuels. </p><p>A cet effet, l’ONG ORIA organise un gala pour collecter des fonds et construire l'école. </p><p>Dans le contexte actuel où l'INCLUSION est primordial, ce Gala sera agrémenté de deux débats de taille, ainsi que de témoignages et de belles surprises. </p><p> </p><p>Les thèmes de ces débats sont:</p><p><strong>1/Comment construire l'estime de soi dans les familles confrontées au handicap?</strong></p><p><strong>2/Pourquoi l'école inclusive fait-elle peur?</strong></p><p> </p><p>Parrain de l'évènement : <strong>GADJI CELI</strong></p><p><strong>Lieu: Ivoire Golf Club</strong></p><p> </p><p> </p><p>Les pass disponibles</p><p> </p><ul><li>Pass classique : <strong>50 000 F </strong>pour une personne ou <strong>90 000 F </strong>pour un couple</li><li>Pass VIP : <strong>70 000 F </strong> pour une personne ou <strong>130 000 F </strong>pour un couple</li></ul><p>Si vous ne pouvez pas y participer , vous pouvez soutenir la cause si vous le souhaitez :  </p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAB3RJTUUH4wgOCAAWdmwblwAAAAZiS0dEAP8A/wD/oL2nkwAAA3BJREFUeNrNVU2MFEUUfvXXPT09oyw/S1hiTFAOJmSjeJETCQEPxngwRuPRGGPQmz8XEuOBCyeIcuDoXtRwgQvECPFAuACi0eAJY0SjBmGnd2e6e/q3qviqssMezI6JDIlv+vWrrp/3VX3fqww9bGMbDfxw8jUWPzq33ZCIlJJ/7Hr9k+a/APCNBpKsmivL4mQUyotKssM3l95SMwUoqraTptmTVZk/UZfFe1VVLM4UoG50ay21umkoz9KF5ZXsmZkC9Lqq1wll3xhDw7Rkfw9yOVOAfjdc7Pd7O4lxyoo6SfPqp5kBnPvoUNiL45eiqNcjxsCT+W6YVzdmBrBjfsvebhw/L6QipQLQFfy8dPZqOpN7cPr9/Z09T+06vmnz1sOCC2rbmorx+IK19gSztllfwSaPxFswnNQSzFoG3ZrVUfrb3cHwl38I99jCNlATvcoZ9wtUGFEQxQeM1s9hsc9hjCajW5fMI3l3AMa4KcwabbtR8GcYyKPy1y/eUabVHSm4ub2c7O7H3Q9AyxaNnftFVhKoklzIRwiQVhuqy4xWkoQatJ35fmNJA8C4iP6ianYnw/HTUqjwxU4cvsEYFwthtFPX1R6tm8nuXHIk1cQ4v5+MA3iwmtOtv5LlKAxu4lNjtgfBD0C2BtCNptWfSVDxLCN6AdDCLWyNBu8AgDleQY2Pax2+zaHNju2b6fZglN9J0o/ReR0zuB8nz6yRoRq/e+pyI4t8FAkh2CQZRHVxLR+He7CJgF4GAx8XDUWhmgfXm94+dXmVNjCZZRkPlCDBuF8IoRCNy+WpIOfkE8PJxxYc30lyszIqvgHv12mKyXFRK6MFg8ju+JNC8XFdQm+TMQC7mx7Yoh9deuXY17emXrSybikvG6c61U2L3ek1N961gbt2q+Euuj5Pk4DPn/7wIJ96glFe19i9DRRngRQkhRPRiekpmjBExruvEGzE0Gpa/giKzoJ/MxVgmJUpAIzCCw85PVD15NrQ3oOsqeBBWu0Fdqc+PxhVVwg2XYOyvoIaOsM4U0hmgkAudAK1GCoRSwChdpF63fwJWr0M2r498vk1+68AZdVcBL+X3O4YtunKrgrbQ7jmLysl9grOe762GTUQuYAGvwNgqSjrrx7oT//TN/f1AfI49JjDJIMKK9GdoyjuDtNi5ciX3xv6P9g9qb/yymX7NcMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMTRUMTU6MDA6MjItMDc6MDCQMBjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTE0VDE1OjAwOjIyLTA3OjAw4W2gZwAAAABJRU5ErkJggg==\" alt=\"👉🏽\">Canada</p><p>PayPal: <a href=\"https://www.paypal.me/Oriaorg\">https://www.paypal.me/Oriaorg</a></p><p>Virement Interac: info@<a href=\"http://oria.com/514-692-0045?fbclid=IwAR1viX7HuYcFH1blod4Tv728yWRr1SqYqyOwNfjyHdEpO_3-n7plQ80WRrY\">oria.com/514-692-0045</a></p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAB3RJTUUH4wgOCAAWdmwblwAAAAZiS0dEAP8A/wD/oL2nkwAAA3BJREFUeNrNVU2MFEUUfvXXPT09oyw/S1hiTFAOJmSjeJETCQEPxngwRuPRGGPQmz8XEuOBCyeIcuDoXtRwgQvECPFAuACi0eAJY0SjBmGnd2e6e/q3qviqssMezI6JDIlv+vWrrp/3VX3fqww9bGMbDfxw8jUWPzq33ZCIlJJ/7Hr9k+a/APCNBpKsmivL4mQUyotKssM3l95SMwUoqraTptmTVZk/UZfFe1VVLM4UoG50ay21umkoz9KF5ZXsmZkC9Lqq1wll3xhDw7Rkfw9yOVOAfjdc7Pd7O4lxyoo6SfPqp5kBnPvoUNiL45eiqNcjxsCT+W6YVzdmBrBjfsvebhw/L6QipQLQFfy8dPZqOpN7cPr9/Z09T+06vmnz1sOCC2rbmorx+IK19gSztllfwSaPxFswnNQSzFoG3ZrVUfrb3cHwl38I99jCNlATvcoZ9wtUGFEQxQeM1s9hsc9hjCajW5fMI3l3AMa4KcwabbtR8GcYyKPy1y/eUabVHSm4ub2c7O7H3Q9AyxaNnftFVhKoklzIRwiQVhuqy4xWkoQatJ35fmNJA8C4iP6ianYnw/HTUqjwxU4cvsEYFwthtFPX1R6tm8nuXHIk1cQ4v5+MA3iwmtOtv5LlKAxu4lNjtgfBD0C2BtCNptWfSVDxLCN6AdDCLWyNBu8AgDleQY2Pax2+zaHNju2b6fZglN9J0o/ReR0zuB8nz6yRoRq/e+pyI4t8FAkh2CQZRHVxLR+He7CJgF4GAx8XDUWhmgfXm94+dXmVNjCZZRkPlCDBuF8IoRCNy+WpIOfkE8PJxxYc30lyszIqvgHv12mKyXFRK6MFg8ju+JNC8XFdQm+TMQC7mx7Yoh9deuXY17emXrSybikvG6c61U2L3ek1N961gbt2q+Euuj5Pk4DPn/7wIJ96glFe19i9DRRngRQkhRPRiekpmjBExruvEGzE0Gpa/giKzoJ/MxVgmJUpAIzCCw85PVD15NrQ3oOsqeBBWu0Fdqc+PxhVVwg2XYOyvoIaOsM4U0hmgkAudAK1GCoRSwChdpF63fwJWr0M2r498vk1+68AZdVcBL+X3O4YtunKrgrbQ7jmLysl9grOe762GTUQuYAGvwNgqSjrrx7oT//TN/f1AfI49JjDJIMKK9GdoyjuDtNi5ciX3xv6P9g9qb/yymX7NcMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMTRUMTU6MDA6MjItMDc6MDCQMBjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTE0VDE1OjAwOjIyLTA3OjAw4W2gZwAAAABJRU5ErkJggg==\" alt=\"👉🏽\">France</p><p>PayPal: <a href=\"https://www.paypal.me/Oriaorg?fbclid=IwAR3lIQ9P6vw55fLiaT7Uyk5rQofsJEQCDxvJCVH7_RV3wJo-NWGrCNrsNtc\">https://www.paypal.me/Oriaorg</a></p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAB3RJTUUH4wgOCAAWdmwblwAAAAZiS0dEAP8A/wD/oL2nkwAAA3BJREFUeNrNVU2MFEUUfvXXPT09oyw/S1hiTFAOJmSjeJETCQEPxngwRuPRGGPQmz8XEuOBCyeIcuDoXtRwgQvECPFAuACi0eAJY0SjBmGnd2e6e/q3qviqssMezI6JDIlv+vWrrp/3VX3fqww9bGMbDfxw8jUWPzq33ZCIlJJ/7Hr9k+a/APCNBpKsmivL4mQUyotKssM3l95SMwUoqraTptmTVZk/UZfFe1VVLM4UoG50ay21umkoz9KF5ZXsmZkC9Lqq1wll3xhDw7Rkfw9yOVOAfjdc7Pd7O4lxyoo6SfPqp5kBnPvoUNiL45eiqNcjxsCT+W6YVzdmBrBjfsvebhw/L6QipQLQFfy8dPZqOpN7cPr9/Z09T+06vmnz1sOCC2rbmorx+IK19gSztllfwSaPxFswnNQSzFoG3ZrVUfrb3cHwl38I99jCNlATvcoZ9wtUGFEQxQeM1s9hsc9hjCajW5fMI3l3AMa4KcwabbtR8GcYyKPy1y/eUabVHSm4ub2c7O7H3Q9AyxaNnftFVhKoklzIRwiQVhuqy4xWkoQatJ35fmNJA8C4iP6ianYnw/HTUqjwxU4cvsEYFwthtFPX1R6tm8nuXHIk1cQ4v5+MA3iwmtOtv5LlKAxu4lNjtgfBD0C2BtCNptWfSVDxLCN6AdDCLWyNBu8AgDleQY2Pax2+zaHNju2b6fZglN9J0o/ReR0zuB8nz6yRoRq/e+pyI4t8FAkh2CQZRHVxLR+He7CJgF4GAx8XDUWhmgfXm94+dXmVNjCZZRkPlCDBuF8IoRCNy+WpIOfkE8PJxxYc30lyszIqvgHv12mKyXFRK6MFg8ju+JNC8XFdQm+TMQC7mx7Yoh9deuXY17emXrSybikvG6c61U2L3ek1N961gbt2q+Euuj5Pk4DPn/7wIJ96glFe19i9DRRngRQkhRPRiekpmjBExruvEGzE0Gpa/giKzoJ/MxVgmJUpAIzCCw85PVD15NrQ3oOsqeBBWu0Fdqc+PxhVVwg2XYOyvoIaOsM4U0hmgkAudAK1GCoRSwChdpF63fwJWr0M2r498vk1+68AZdVcBL+X3O4YtunKrgrbQ7jmLysl9grOe762GTUQuYAGvwNgqSjrrx7oT//TN/f1AfI49JjDJIMKK9GdoyjuDtNi5ciX3xv6P9g9qb/yymX7NcMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMTRUMTU6MDA6MjItMDc6MDCQMBjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTE0VDE1OjAwOjIyLTA3OjAw4W2gZwAAAABJRU5ErkJggg==\" alt=\"👉🏽\">Côte d'Ivoire</p><p>Achat de coupons Solid-Oria: 10 000 FCFA, 30 000 FCFA, 50 000 FCFA, 100 000 FCFA et plus par transfert WAVE et ORANGE MONEY au +225 07 00 304 828</p>",
      shortDescription:
          "Parce que la différence est aussi une RICHESSE, ORIA organise en Côte d'Ivoire un Gala pour collecter des fonds afin de favoriser l'inclusion scolaire des enfants déficients intellectuels et autistes.",
      /* salesDeadline: DateTime(2023, 9, 30), */
      free: false,
      image:
          "https://anowan.com/events/images/gala-pour-linclusion-2024-04-21-014546.jpg",
      inspectors: [
        InspectorModel(
            name: "name",
            firstname: "firstname",
            phone: "phone",
            email: "email",
            scanToken: "scanToken"),
      ],
      localizations: [
        LocalizationModel(
            id: 4,
            dateEvent: DateTime.utc(2024, 7, 10),
            starttimeEvent: "19:45",
            endtimeEvent: "23:30",
            place: 'Ivoire Golf Club Boulevard de France, Abidjan',
            longitude: "-3.9627499329138995",
            latitude: "5.33649294707749"),
      ],
    ),
    EventModel(
      id: 5,
      name: "Sweet Lunch",
      uniqueId: "event_5_unique_id",
      slug: "event-5",
      description:
          "<p><strong>ORIA</strong> est l'initiative de Michèle- Francine Acho. </p><p> </p><p>Michèle-Francine Acho<i><strong> </strong></i>est maman de deux enfants épileptiques et quadréparesiques. L’'aînée est, en plus, déficiente intellectuelle et paralytique cérébrale partielle. Le second, lui, a un retard global de développement.</p><p> </p><p>Le combat qu’elle mène chaque jour ainsi que les épreuves quotidiennes auxquelles elle fait face depuis quatorze ans maintenant, qui lui montrent son extrême impuissance face aux problématiques de ses enfants, lui ont fait comprendre que toute famille dans sa condition a besoin de soutien moral et psychologique dans un premier temps, puis matériel. </p><p> </p><p>Le but de l'ONG <strong>ORIA </strong>est d’apporter un soutien psychologique, éducatif et matériel aux familles vivant une situation de handicap en Côte d'Ivoire et en Afrique.</p><p> </p>",
      shortDescription:
          "Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins et repartant avec des lots🥰 Nous profitons de ce moment pour récompenser nos meilleurs clients, partageurs, soutiens ...",
      /* salesDeadline: DateTime(2023, 10, 10), */
      free: true,
      image: "https://anowan.com/events/images/shared-image-10-1717677948.jpeg",
      inspectors: [
        InspectorModel(
            name: "name",
            firstname: "firstname",
            phone: "phone",
            email: "email",
            scanToken: "scanToken"),
      ],
      localizations: [
        LocalizationModel(
          id: 5,
          dateEvent: DateTime.utc(2024, 8, 15),
          starttimeEvent: '12:00',
          endtimeEvent: '18:00',
          place: "Rosiers programme 3, Rive gauche Rue Muguet",
          longitude: "-3.9671011492747095",
          latitude: "5.383731841431673",
        )
      ],
    ),
  ];
}
