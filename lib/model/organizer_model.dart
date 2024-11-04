// To parse this JSON data, do
//
//     final organizerModel = organizerModelFromJson(jsonString);

import 'dart:convert';

import 'package:ticketwave/model/user_model.dart';

List<OrganizerModel> listOrganizerModelFromJson(String str) {
  final jsonData = json.decode(str);

  // Récupère la liste d'objets à partir de la clé 'data'
  final data = jsonData['data'] as List;

  // Convertit chaque élément en un objet PrestatorMdel
  return List<OrganizerModel>.from(data.map((x) => OrganizerModel.fromJson(x)));
}

String listOrganizerModelToJson(List<OrganizerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

////single
OrganizerModel organizerModelFromJson(String str) =>
    OrganizerModel.fromJson(json.decode(str));
String organizerModelToJson(OrganizerModel data) => json.encode(data.toJson());

class OrganizerModel {
  final int id;
  final int userId;
  final String? avatar;
  final String? name;
  final String? uniqueCode;
  final String? phone;
  final String? description;
  final bool active;
  final String? shortDescription;
  final String? website;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final UserModel user;

  OrganizerModel({
    required this.id,
    required this.userId,
    required this.avatar,
    required this.name,
    required this.uniqueCode,
    required this.phone,
    required this.description,
    required this.active,
    required this.shortDescription,
    required this.website,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.user,
  });

  factory OrganizerModel.fromJson(Map<String, dynamic> json) => OrganizerModel(
        id: json["id"],
        userId: json["user_id"],
        avatar: json["avatar"] ?? "",
        name: json["name"] ?? "",
        uniqueCode: json["unique_code"] ?? "",
        phone: json["phone"] ?? "",
        description: json["description"] ?? "",
        active: json["active"] == 0 ? false : true,
        shortDescription: json["short_description"] ?? "",
        website: json["website"] ?? "",
        facebook: json["facebook"] ?? "",
        twitter: json["twitter"] ?? "",
        instagram: json["instagram"] ?? "",
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "avatar": avatar,
        "name": name,
        "unique_code": uniqueCode,
        "phone": phone,
        "description": description,
        "active": active,
        "short_description": shortDescription,
        "website": website,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "user": user.toJson(),
      };

  static List<OrganizerModel> organizers =
      listOrganizerModelFromJson(organizersJsonData);
}

String organizersJsonData = """[
        {
            "id": 1,
            "user_id": 2,
            "avatar": null,
            "name": "Soro David",
            "unique_code": "2852664",
            "phone": null,
            "description": null,
            "active": 1,
            "short_description": null,
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-02-15T15:59:25.000000Z",
            "updated_at": "2024-02-15T15:59:25.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 2,
            "user_id": 3,
            "avatar": "https://anowan.com/organizers/images/lifelor-event-2024-02-22-094859.jpg",
            "name": "Lifelor Event",
            "unique_code": "9505262",
            "phone": null,
            "description": null,
            "active": 1,
            "short_description": null,
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-02-22T09:48:59.000000Z",
            "updated_at": "2024-02-22T09:48:59.000000Z",
           "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 3,
            "user_id": 6,
            "avatar": "https://anowan.com/organizers/images/oria-2024-03-11-151549.jpg",
            "name": "ORIA",
            "unique_code": "2634321",
            "phone": null,
            "description": "<p><strong>ORIA</strong> est l'initiative de Michèle- Francine Acho. </p><p> </p><p>Michèle-Francine Acho<i><strong> </strong></i>est maman de deux enfants épileptiques et quadréparesiques. L’'aînée est, en plus, déficiente intellectuelle et paralytique cérébrale partielle. Le second, lui, a un retard global de développement.</p><p> </p><p>Le combat qu’elle mène chaque jour ainsi que les épreuves quotidiennes auxquelles elle fait face depuis quatorze ans maintenant, qui lui montrent son extrême impuissance face aux problématiques de ses enfants, lui ont fait comprendre que toute famille dans sa condition a besoin de soutien moral et psychologique dans un premier temps, puis matériel. </p><p> </p><p>Le but de l'ONG <strong>ORIA </strong>est d’apporter un soutien psychologique, éducatif et matériel aux familles vivant une situation de handicap en Côte d'Ivoire et en Afrique.</p><p> </p>",
            "active": 1,
            "short_description": "ORIA a pour but ultime d'offrir un soutien aux familles vivant une situation de handicap.",
            "website": "https://www.oriasoutien.com/home",
            "facebook": "https://www.facebook.com/oria.org",
            "twitter": null,
            "instagram": null,
            "created_at": "2024-03-11T15:15:49.000000Z",
            "updated_at": "2024-03-11T15:15:49.000000Z",
           "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 4,
            "user_id": 4,
            "avatar": null,
            "name": "Soro David",
            "unique_code": "596622833",
            "phone": null,
            "description": null,
            "active": 1,
            "short_description": null,
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-03-20T11:30:19.000000Z",
            "updated_at": "2024-03-20T11:30:19.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 5,
            "user_id": 188,
            "avatar": "https://anowan.com/organizers/images/pastorale-pour-la-propagation-de-levangile-2024-05-20-093152.jpg",
            "name": "Pastorale pour la Propagation de l'Evangile",
            "unique_code": "819102570",
            "phone": null,
            "description": "<p><strong>La Pastorale pour la Propagation de l’Evangile (PPE) </strong>est une communauté nouvelle catholique qui a pour mission la propagation de l’Evangile à temps et à contretemps dans toutes les régions du monde qui n’ont pas encore expérimenté la puissance de salut de notre Seigneur Jésus-Christ. </p><p> </p><p>Nous propageons l’évangile de Jésus-Christ par divers canaux dont le concert œcuménique d’action de grâce, de louange et d’adoration, GLORY.</p><p> </p><p>Temps d’enseignement et d’édification</p><p>Temps dédié de louange et d’adoration</p><p>-Dans le Saint des saints</p><p>-Trône de Gloire</p><p>-GLORY</p><p>-La brise du Cramel</p><p>Evangélisations :</p><p>Retraites spirituelles trimestrielles.</p><p>Activités diverses :</p><p>-Journée sportive (décembre) ;</p><p>-Journée du Motivation d’orientation (février) ;</p><p>-Visites aux malades et aux orphelins ;</p><p>-Arbres de Noel (décembre) ;</p>",
            "active": 1,
            "short_description": "La Pastorale pour la Propagation de l'Évangile est une communauté chrétienne qui a pour but le salut de la multitude et la joie du ciel au travers de plusieurs canaux, notamment les évangélisations, concert, retraite, journée récréative, diner, etc",
            "website": "pastoralepropagationevangile.org",
            "facebook": "https://www.facebook.com/P.P.E.Pastorale",
            "twitter": null,
            "instagram": "https://www.instagram.com/pastorale_ppe/",
            "created_at": "2024-05-07T20:26:55.000000Z",
            "updated_at": "2024-05-20T09:31:52.000000Z",
           "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 6,
            "user_id": 188,
            "avatar": "https://anowan.com/organizers/images/doho-epse-vlei-marie-dominique-2024-05-07-202727.jpg",
            "name": "Doho epse VLEI Marie Dominique",
            "unique_code": "496146851",
            "phone": null,
            "description": null,
            "active": 1,
            "short_description": "La Pastorale pour la Propagation de l'Évangile est une communauté chrétienne qui a pour but le salut de la multitude et la joie du ciel au travers de plusieurs canaux, notamment les évangélisations, concert, retraite, journée récréative, diner, etc",
            "website": "pastoralepropagationevangile.org",
            "facebook": "https://www.facebook.com/P.P.E.Pastorale",
            "twitter": null,
            "instagram": "https://www.instagram.com/pastorale_ppe/",
            "created_at": "2024-05-07T20:27:27.000000Z",
            "updated_at": "2024-05-07T20:27:27.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 7,
            "user_id": 187,
            "avatar": "https://anowan.com/organizers/images/digifaz-event-2024-05-23-104549.jpg",
            "name": "DIGIFAZ EVENT",
            "unique_code": "744112519",
            "phone": null,
            "description": "<p>DIGIFAZ EVENT</p>",
            "active": 1,
            "short_description": "DIGIFAZ EVENT",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-05-23T10:45:49.000000Z",
            "updated_at": "2024-05-23T10:45:49.000000Z",
           "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 8,
            "user_id": 195,
            "avatar": "https://anowan.com/organizers/images/noblesse-sweetness-food-2024-06-05-171910.jpg",
            "name": "Noblesse Sweetness & Food",
            "unique_code": "117140478",
            "phone": null,
            "description": "<p>Nous sommes un E-Restaurant-Traiteur-Event spécialisé dans la vente de mignardises, Entrées, plats,desserts, jus locaux, box surprises.. pour les petites envies, séminaires, dîners et cérémonies(Mariage, Baptême…)</p><p> </p><p>Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins et surtout repartant avec des lots nous accueillons tout le monde (petits et grands)</p><p> </p>",
            "active": 1,
            "short_description": "Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins.",
            "website": null,
            "facebook": "Noblesse Sweetness & Food",
            "twitter": null,
            "instagram": "Noblesse.sweetness_food23",
            "created_at": "2024-06-05T17:19:10.000000Z",
            "updated_at": "2024-06-05T17:19:10.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 9,
            "user_id": 213,
            "avatar": "https://anowan.com/organizers/images/faith-event-agence-1720531908.jpg",
            "name": "Faith Event Agence",
            "unique_code": "853533932",
            "phone": null,
            "description": "Pour l'organisation de vos événements sans stress ni contraintes, contactez Faith Event au 0709858485",
            "active": 1,
            "short_description": null,
            "website": null,
            "facebook": "https://www.facebook.com/faitheventci",
            "twitter": null,
            "instagram": null,
            "created_at": "2024-07-09T13:09:07.000000Z",
            "updated_at": "2024-07-09T13:31:48.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 10,
            "user_id": 215,
            "avatar": "https://anowan.com/organizers/images/p-expertise-conseils-1721237446.jpeg",
            "name": "P EXPERTISE CONSEILS",
            "unique_code": "627671002",
            "phone": "0777062900",
            "description": null,
            "active": 1,
            "short_description": null,
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-07-17T17:05:45.000000Z",
            "updated_at": "2024-07-17T17:30:46.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 11,
            "user_id": 217,
            "avatar": null,
            "name": "ROBERT'S HOTEL",
            "unique_code": "392927372",
            "phone": null,
            "description": null,
            "active": 1,
            "short_description": null,
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-08-17T15:44:36.000000Z",
            "updated_at": "2024-08-17T15:44:36.000000Z",
           "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        },
        {
            "id": 12,
            "user_id": 196,
            "avatar": "https://anowan.com/organizers/images/kouame-marie-andree-2024-08-18-162433.jpg",
            "name": "ANDY EVENT'S",
            "unique_code": "932823468",
            "phone": null,
            "description": null,
            "active": 1,
            "short_description": "Vous satisfaire lors de vos évenéments est notre priorité.",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "created_at": "2024-08-18T16:24:33.000000Z",
            "updated_at": "2024-08-22T18:23:03.000000Z",
            "user": {
                    "id": 6,
                    "name": "ORIA",
                    "firstname": "ORIA",
                    "phone": null,
                    "email": "contact@oriasoutien.com",
                    "email_verified_at": "2024-03-11T15:22:04.000000Z",
                    "avatar": "oria-2024-03-28-190052.png",
                    "active": 1,
                    "created_at": "2024-03-11T15:08:42.000000Z",
                    "updated_at": "2024-03-28T19:00:52.000000Z",
                    "phone_code": "+225"
                }
        }
    ]""";
