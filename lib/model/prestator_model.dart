// To parse this JSON data, do
//
//     final prestatorMdel = prestatorMdelFromJson(jsonString);

import 'dart:convert';

PrestatorMdel prestatorMdelFromJson(String str) =>
    PrestatorMdel.fromJson(json.decode(str));
List<PrestatorMdel> prestatorMdelListFromJson(String str) =>
    List<PrestatorMdel>.from(
        json.decode(str).map((x) => PrestatorMdel.fromJson(x)));

String prestatorMdelToJson(PrestatorMdel data) => json.encode(data.toJson());

class PrestatorMdel {
  int id;
  int serviceCategoryId;
  String name;
  String logo;
  dynamic email;
  dynamic phone1;
  dynamic phone2;
  dynamic phone3;
  dynamic longitude;
  dynamic latitude;
  String description;
  String shortDescription;
  dynamic servicePrice;
  dynamic address;
  String city;
  String town;
  String country;
  dynamic postalCode;
  String isActive;
  dynamic isVerified;
  dynamic isFeatured;
  dynamic isApproved;
  dynamic serviceRating;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic website;
  dynamic facebook;
  dynamic twitter;
  dynamic instagram;
  dynamic tiktok;
  dynamic linkedin;
  String serviceCategory;
  List<String> tags;
  List<PrestatorCovers> images;
  dynamic video;

  PrestatorMdel({
    required this.id,
    required this.serviceCategoryId,
    required this.name,
    required this.logo,
    required this.email,
    required this.phone1,
    required this.phone2,
    required this.phone3,
    required this.longitude,
    required this.latitude,
    required this.description,
    required this.shortDescription,
    required this.servicePrice,
    required this.address,
    required this.city,
    required this.town,
    required this.country,
    required this.postalCode,
    required this.isActive,
    required this.isVerified,
    required this.isFeatured,
    required this.isApproved,
    required this.serviceRating,
    required this.createdAt,
    required this.updatedAt,
    required this.website,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.tiktok,
    required this.linkedin,
    required this.serviceCategory,
    required this.tags,
    required this.images,
    required this.video,
  });

  factory PrestatorMdel.fromJson(Map<String, dynamic> json) => PrestatorMdel(
        id: json["id"],
        serviceCategoryId: json["service_category_id"],
        name: json["name"],
        logo: json["logo"],
        email: json["email"],
        phone1: json["phone1"],
        phone2: json["phone2"],
        phone3: json["phone3"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        description: json["description"],
        shortDescription: json["short_description"],
        servicePrice: json["service_price"],
        address: json["address"],
        city: json["city"],
        town: json["town"],
        country: json["country"],
        postalCode: json["postal_code"],
        isActive: json["is_active"],
        isVerified: json["is_verified"],
        isFeatured: json["is_featured"],
        isApproved: json["is_approved"],
        serviceRating: json["service_rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        website: json["website"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
        linkedin: json["linkedin"],
        serviceCategory: json["service_category"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        images: List<PrestatorCovers>.from(
            json["images"].map((x) => PrestatorCovers.fromJson(x))),
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_category_id": serviceCategoryId,
        "name": name,
        "logo": logo,
        "email": email,
        "phone1": phone1,
        "phone2": phone2,
        "phone3": phone3,
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "short_description": shortDescription,
        "service_price": servicePrice,
        "address": address,
        "city": city,
        "town": town,
        "country": country,
        "postal_code": postalCode,
        "is_active": isActive,
        "is_verified": isVerified,
        "is_featured": isFeatured,
        "is_approved": isApproved,
        "service_rating": serviceRating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "website": website,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "tiktok": tiktok,
        "linkedin": linkedin,
        "service_category": serviceCategory,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "video": video,
      };

  static List<PrestatorMdel> prestators = prestatorMdelListFromJson(jsonData);
  //
  // Fonction pour obtenir tous les tags sans doublons
  static List<String> getAllUniqueTags(
      {required List<PrestatorMdel> prestatorsList}) {
    final Set<String> uniqueTags = {};

    for (final prestator in prestatorsList) {
      uniqueTags.addAll(prestator.tags);
    }

    return uniqueTags.toList();
  }
}

class PrestatorCovers {
  int id;
  String url;
  int imageCover;

  PrestatorCovers({
    required this.id,
    required this.url,
    required this.imageCover,
  });

  factory PrestatorCovers.fromJson(Map<String, dynamic> json) =>
      PrestatorCovers(
        id: json["id"],
        url: json["url"],
        imageCover: json["image_cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "image_cover": imageCover,
      };
}

String jsonData = """[{
            "id": 1,
            "service_category_id": 1,
            "name": "Chelo Events and Design",
            "logo": "https://anowan.com/service-providers/logo/chelo-events-and-design-1717060910.jpg",
            "email": null,
            "phone1": "0709576135",
            "phone2": "0150784318",
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations:</p><p> </p><ul><li><strong>Décoration et organisation d'événement de A à Z : </strong>Mariage, Anniversaire, Brunch, Baptême, …</li><li><strong>Décoratrice et accessoiriste : </strong>Télévision, Film, Publicité et Entreprise</li><li><strong>Rénovation :</strong> Détox ton Local</li><li><strong>Décoration d'intérieur : </strong>Maisons, Résidences meublées et Entreprises</li><li><strong>Vente et Location </strong>de matériel de décoration / <strong>Location </strong>de vaisselle, chaise et autres</li><li><strong>Confection de</strong> bouquets de fleurs, paniers et emballages cadeau</li></ul><p>Nous proposons également la location de la sonorisation, l'éclairage, un service traiteur, la sécurité, l'éclairage, etc… pour tout type d'évènement. </p><p> </p><p>Plus de 150 évènements déjà organisés.</p>",
            "short_description": "Nous décorons et organisons vos événements",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-29T15:39:51.000000Z",
            "updated_at": "2024-05-30T09:21:50.000000Z",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "tiktok": null,
            "linkedin": null,
            "service_category": "Décoration",
            "tags": [
                "Plateau télévision",
                "Cérémonie",
                "Mariage"
            ],
            "images": [
                {
                    "id": 13,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0003-1717060569.png",
                    "image_cover": 1
                },
                {
                    "id": 14,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0004-1717060586.png",
                    "image_cover": 0
                },
                {
                    "id": 15,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0005-1717060605.png",
                    "image_cover": 0
                },
                {
                    "id": 16,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0006-1717060626.png",
                    "image_cover": 0
                },
                {
                    "id": 17,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0007-1717060636.png",
                    "image_cover": 0
                },
                {
                    "id": 18,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0009-1717060648.png",
                    "image_cover": 0
                },
                {
                    "id": 19,
                    "url": "https://anowan.com/service-providers/images/img-20240524-wa0011-1717060659.png",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 2,
            "service_category_id": 1,
            "name": "Mashana events",
            "logo": "https://anowan.com/service-providers/logo/mashana-events-1717065684.jpg",
            "email": "stefanoumab@gmail.com",
            "phone1": "0757706823",
            "phone2": null,
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations:</p><p> </p><ul><li><strong>Décoration et organisation d'événement de A à Z : </strong>Mariage, Anniversaire, Brunch, Baptême, Séminaires….</li><li><strong>Location </strong>de matériel de décoration / <strong>Location </strong>de vaisselle, chaise et autres</li><li><strong>Confection de</strong> bouquets de fleurs</li></ul><p>Nous proposons également , un service traiteur, la sécurité, l'éclairage, etc… pour tout type d'évènement. </p><p> </p>",
            "short_description": "Planification et organisation d'événements Event designer (décoratrice événementiel)",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-30T10:41:24.000000Z",
            "updated_at": "2024-05-31T10:53:18.000000Z",
            "website": null,
            "facebook": "https://www.facebook.com/mashanaevents?mibextid=ZbWKwL",
            "twitter": null,
            "instagram": "https://www.instagram.com/mashana.events?igsh=MTdsa2hwczlpNTk0",
            "tiktok": null,
            "linkedin": null,
            "service_category": "Décoration",
            "tags": [
                "Cérémonie",
                "Mariage",
                "Baptême",
                "Conférence"
            ],
            "images": [
                {
                    "id": 20,
                    "url": "https://anowan.com/service-providers/images/screenshot-20240514-110240-facebook-stephanie-anouma-1717064867.jpg",
                    "image_cover": 1
                },
                {
                    "id": 21,
                    "url": "https://anowan.com/service-providers/images/0y5a5426-stephanie-anouma-1717064918.jpg",
                    "image_cover": 0
                },
                {
                    "id": 22,
                    "url": "https://anowan.com/service-providers/images/screenshot-20240514-110130-facebook-stephanie-anouma-1717065010.png",
                    "image_cover": 0
                },
                {
                    "id": 24,
                    "url": "https://anowan.com/service-providers/images/fb-img-1715684408963-stephanie-anouma-1717065113.png",
                    "image_cover": 0
                },
                {
                    "id": 25,
                    "url": "https://anowan.com/service-providers/images/fb-img-1715684382323-stephanie-anouma-1717065156.png",
                    "image_cover": 0
                },
                {
                    "id": 53,
                    "url": "https://anowan.com/service-providers/images/tmp-bf0aae44-1400-4b26-8e30-93bdff707edc-1717151350.jpeg",
                    "image_cover": 0
                },
                {
                    "id": 54,
                    "url": "https://anowan.com/service-providers/images/tmp-227f978f-239c-474f-888c-2b2909c8643d-1717151387.jpeg",
                    "image_cover": 0
                },
                {
                    "id": 55,
                    "url": "https://anowan.com/service-providers/images/tmp-3d607cab-26f5-46c7-8006-6f02129e15d1-1717151430.jpeg",
                    "image_cover": 0
                },
                {
                    "id": 56,
                    "url": "https://anowan.com/service-providers/images/tmp-c85b7a49-61c4-4e66-894b-37e0b46f35ed-1717151460.jpeg",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 3,
            "service_category_id": 2,
            "name": "Noblesse Sweetness & Food",
            "logo": "https://anowan.com/service-providers/logo/noblesse-sweetness-food-1717068460.jpg",
            "email": "noblesse.food@gmail.com",
            "phone1": "0566998416",
            "phone2": null,
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations </p><p> </p><p>E-Restaurant-Traiteur- Event</p><p> </p><p>spécialisé dans la vente de mignardises, Plats, Jus locaux, Gift Box Personnalisée, Pour vos petites envies, cérémonies(Mariage, Baptême, soutenance...) et Séminaires a partir de 1500 FCFa</p><p><strong>E-Restaurant : </strong>nous vous offrons une variété de plats en fonction de vos préférences </p><p><strong>Confection de paniers surprises</strong></p><p> </p><p>Nous offrons nos services pour tout type d'évènements ( mariages, conférences, baptêmes etc.)</p><p> </p>",
            "short_description": "E-Restaurant- Traiteur- Événementiel",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-30T11:27:40.000000Z",
            "updated_at": "2024-05-31T14:19:58.000000Z",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "tiktok": null,
            "linkedin": null,
            "service_category": "Service traiteur",
            "tags": [
                "Mariage",
                "Baptême",
                "Conférence"
            ],
            "images": [
                {
                    "id": 29,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202833-d4657f81-1717068208.png",
                    "image_cover": 1
                },
                {
                    "id": 31,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202832-5a3a634b-1717068249.png",
                    "image_cover": 0
                },
                {
                    "id": 32,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202831-e1f19217-1717068260.png",
                    "image_cover": 0
                },
                {
                    "id": 33,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202831-df05d9dc-1717068280.png",
                    "image_cover": 0
                },
                {
                    "id": 34,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202831-7e992e19-1717068293.png",
                    "image_cover": 0
                },
                {
                    "id": 35,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202831-634cc596-1717068306.png",
                    "image_cover": 0
                },
                {
                    "id": 36,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202829-cf2f6961-1717068318.png",
                    "image_cover": 0
                },
                {
                    "id": 37,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-202829-35142d8d-1717068331.png",
                    "image_cover": 0
                },
                {
                    "id": 89,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-203825-c51134f1-1717164572.png",
                    "image_cover": 0
                },
                {
                    "id": 90,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-14-a-203824-16b31110-1717165147.png",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 4,
            "service_category_id": 1,
            "name": "Evens Deco",
            "logo": "https://anowan.com/service-providers/logo/evens-deco-1717076942.jpg",
            "email": null,
            "phone1": "0585285081",
            "phone2": null,
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations :</p><p> </p><p><strong>Décoration  d’événement  </strong>: Mariage, Anniversaire, Brunch, Baptême, …</p><p><strong>Mise à disposition d'une salle </strong>: Capacité d’accueil 300 personnes </p><p><strong>Nom de  la salle </strong> : EDEN PALACE</p><p> </p><p>Nous proposons également la location de la sonorisation, l’éclairage, un service traiteur, la sécurité, l’éclairage, etc… pour tout type d’évènement .</p>",
            "short_description": "Décoration événementielle",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-30T13:49:02.000000Z",
            "updated_at": "2024-05-30T19:09:15.000000Z",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "tiktok": null,
            "linkedin": null,
            "service_category": "Décoration",
            "tags": [
                "Cérémonie",
                "Mariage",
                "Baptême"
            ],
            "images": [
                {
                    "id": 38,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0013-1717076668.png",
                    "image_cover": 0
                },
                {
                    "id": 39,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0012-1717076690.png",
                    "image_cover": 1
                },
                {
                    "id": 40,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0013-1717076702.png",
                    "image_cover": 0
                },
                {
                    "id": 41,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0008-1717076715.png",
                    "image_cover": 0
                },
                {
                    "id": 42,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0008-1717076756.png",
                    "image_cover": 0
                },
                {
                    "id": 43,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0009-1717076768.png",
                    "image_cover": 0
                },
                {
                    "id": 44,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0007-1717076778.png",
                    "image_cover": 0
                },
                {
                    "id": 45,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0005-1717076832.png",
                    "image_cover": 0
                },
                {
                    "id": 46,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0004-1717076871.png",
                    "image_cover": 0
                },
                {
                    "id": 47,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0002-1717076892.png",
                    "image_cover": 0
                },
                {
                    "id": 48,
                    "url": "https://anowan.com/service-providers/images/img-20240513-wa0001-1717076904.png",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 5,
            "service_category_id": 4,
            "name": "Skyview Event",
            "logo": "https://anowan.com/service-providers/logo/skyview-event-1717081064.jpg",
            "email": "stefanoumab@gmail.com",
            "phone1": "0769636837",
            "phone2": "0757706823",
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations : </p><p> </p><p><strong>Décoration et organisation d’événements</strong> : Mariage, Anniversaire, Brunch, Baptême, etc.</p><p><strong>Location de salles de réception :</strong> Une salle d'une capacité de 200 personnes maximum (chapiteau climatisé) et une salle plus petite d'une capacité de 100 personnes maximum.</p><p><strong>Equipements disponibles dans notre salle</strong> : Sonorisation, logistique (chaises, tables et vaisselle)</p><p><strong>Event planner et Event designer :</strong> Organisation et décoration d'événements de tout genre.</p><p> </p><p>Nous proposons l’éclairage, un service de  sécurité,de nettoyage etc… pour tout type d’évènement.</p>",
            "short_description": "Location de salle de reception",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-30T14:57:44.000000Z",
            "updated_at": "2024-05-30T19:07:00.000000Z",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "tiktok": null,
            "linkedin": null,
            "service_category": "Location (salle , couverts etc....)",
            "tags": [
                "Cérémonie",
                "Mariage",
                "Baptême",
                "Conférence"
            ],
            "images": [
                {
                    "id": 49,
                    "url": "https://anowan.com/service-providers/images/fb-img-1715684128649-stephanie-anouma-1717080618.png",
                    "image_cover": 1
                },
                {
                    "id": 50,
                    "url": "https://anowan.com/service-providers/images/fb-img-1715684142299-stephanie-anouma-1717080629.png",
                    "image_cover": 0
                },
                {
                    "id": 51,
                    "url": "https://anowan.com/service-providers/images/fb-img-1715684161961-stephanie-anouma-1717080655.png",
                    "image_cover": 0
                },
                {
                    "id": 52,
                    "url": "https://anowan.com/service-providers/images/screenshot-20240514-110024-facebook-stephanie-anouma-1717080702.png",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 6,
            "service_category_id": 3,
            "name": "CHRISYLDA Tradition",
            "logo": "https://anowan.com/service-providers/logo/chrisylda-tradition-1717154306.gif",
            "email": "chrisylda.t@gmail.com",
            "phone1": "0575540618",
            "phone2": "0707580306",
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Officiellement présent en Côte d’Ivoire depuis 2005, notre activité se base essentiellement sur la location et la vente de vêtements et d’accessoires traditionnels pour les événements heureux</p><p> </p>",
            "short_description": "Location et vente d'accessoires traditionnels",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-31T11:05:04.000000Z",
            "updated_at": "2024-05-31T11:20:47.000000Z",
            "website": null,
            "facebook": "https://www.facebook.com/CHRISYLDA.Tradition?mibextid=ZbWKwL",
            "twitter": null,
            "instagram": null,
            "tiktok": null,
            "linkedin": null,
            "service_category": "Tenue traditionnelle",
            "tags": [
                "Cérémonie",
                "Mariage"
            ],
            "images": [
                {
                    "id": 57,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-193835-b6813854-1717153172.png",
                    "image_cover": 1
                },
                {
                    "id": 58,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-193835-462152ee-1717153192.png",
                    "image_cover": 0
                },
                {
                    "id": 59,
                    "url": "https://anowan.com/service-providers/images/9bd05749-3ce1-4dd6-91ac-04a26dfac922-chrisylda-tradition-1717153214.png",
                    "image_cover": 0
                },
                {
                    "id": 60,
                    "url": "https://anowan.com/service-providers/images/6d6f7543-c089-48ae-b672-12cf0c908136-chrisylda-tradition-1717153235.png",
                    "image_cover": 0
                },
                {
                    "id": 61,
                    "url": "https://anowan.com/service-providers/images/4718d512-8f66-41bc-ba03-8fa2a61add16-chrisylda-tradition-1717153246.png",
                    "image_cover": 0
                },
                {
                    "id": 62,
                    "url": "https://anowan.com/service-providers/images/4370cc5c-c35c-45bd-a20a-040149ae1434-chrisylda-tradition-1717153258.png",
                    "image_cover": 0
                },
                {
                    "id": 63,
                    "url": "https://anowan.com/service-providers/images/0bfb8288-ddfe-49f0-bbbf-96cdbaf8e5af-chrisylda-tradition-1717153293.png",
                    "image_cover": 0
                },
                {
                    "id": 64,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-193835-057ce806-1717153332.png",
                    "image_cover": 0
                },
                {
                    "id": 65,
                    "url": "https://anowan.com/service-providers/images/tmp-12af4061-3595-4259-85e2-c07a872990e1-1717154403.jpeg",
                    "image_cover": 0
                },
                {
                    "id": 66,
                    "url": "https://anowan.com/service-providers/images/tmp-cc9b1cc5-c12b-4b74-a4b4-eecce6ea7100-1717154435.jpeg",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 8,
            "service_category_id": 1,
            "name": "Anémone Agency",
            "logo": "https://anowan.com/service-providers/logo/anemone-agency-1717157621.jpg",
            "email": "anemoneagency@gmail.com",
            "phone1": "0748114866",
            "phone2": null,
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations </p><p> </p><ul><li>Décoration</li><li>Wedding planner</li><li>Organisation d’événements</li><li>Location de tenues de mariés</li><li>Formation</li></ul>",
            "short_description": "Décoratrice spécialisée en transformation des lieux",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-05-31T12:13:41.000000Z",
            "updated_at": "2024-05-31T20:49:40.000000Z",
            "website": null,
            "facebook": null,
            "twitter": null,
            "instagram": null,
            "tiktok": null,
            "linkedin": null,
            "service_category": "Décoration",
            "tags": [
                "Mariage",
                "Baptême",
                "Conférence"
            ],
            "images": [
                {
                    "id": 78,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-235132-baa376b4-1717156404.png",
                    "image_cover": 1
                },
                {
                    "id": 79,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-31-a-000853-b1bdcb46-1717156415.png",
                    "image_cover": 0
                },
                {
                    "id": 80,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-31-a-000823-7331c3ee-1717156427.png",
                    "image_cover": 0
                },
                {
                    "id": 81,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-235042-fa1e1161-1717156441.jpg",
                    "image_cover": 0
                },
                {
                    "id": 82,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-234428-fa73b780-1717156453.jpg",
                    "image_cover": 0
                },
                {
                    "id": 83,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-234410-d7d5da61-1717156471.jpg",
                    "image_cover": 0
                },
                {
                    "id": 84,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-235554-b8f844ae-1717156534.png",
                    "image_cover": 0
                },
                {
                    "id": 85,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-31-a-001846-cfee1c14-1717156970.jpg",
                    "image_cover": 0
                },
                {
                    "id": 86,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-234717-cdc4a84b-1717157580.png",
                    "image_cover": 0
                },
                {
                    "id": 87,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-234506-24309854-1717157589.png",
                    "image_cover": 0
                },
                {
                    "id": 88,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-05-30-a-234608-33160b9f-1717157598.png",
                    "image_cover": 0
                }
            ],
            "video": null
        },
        {
            "id": 9,
            "service_category_id": 5,
            "name": "SPECIMEN 229",
            "logo": "https://anowan.com/service-providers/logo/specimen-229-1718871045.jpg",
            "email": null,
            "phone1": "0101685107",
            "phone2": "0758527739",
            "phone3": null,
            "longitude": null,
            "latitude": null,
            "description": "<p>Nos prestations : </p><p><strong>Restaurant, traiteur.</strong></p><p>Nous sommes spécialisés dans la restauration et nous offrons à nos clients toute sorte de mets (Africain ou Européen) pour faire voyager vos papilles gustatives. </p><p>Avec nos chefs spécialisés, nous vous accueillons dans un cadre somptueux, paisible qui rend votre déjeuner, Diner ou Evènement spécial.</p><p><br>Notre magnifique cadre est ouvert pour tous vos évènements (Mariages, Anniversaires Baptêmes etc.)</p>",
            "short_description": "restaurant grill et lounge spécialisés dans la confection de mets",
            "service_price": null,
            "address": null,
            "city": "Abidjan",
            "town": "Cocody",
            "country": "Côte d'Ivoire",
            "postal_code": null,
            "is_active": "1",
            "is_verified": null,
            "is_featured": null,
            "is_approved": null,
            "service_rating": null,
            "created_at": "2024-06-19T16:46:27.000000Z",
            "updated_at": "2024-06-20T08:13:23.000000Z",
            "website": null,
            "facebook": "https://www.facebook.com/profile.php?id=61554087511164&mibextid=ZbWKwL",
            "twitter": null,
            "instagram": "https://www.instagram.com/lespecimen229?igsh=MTFkM2diNmJsdjd0Yg==",
            "tiktok": "https://www.tiktok.com/@lespecimen229?_t=8nKo1c8Wl9R&_r=1",
            "linkedin": null,
            "service_category": "Resto grill et lounge",
            "tags": [
                "Cérémonie",
                "Mariage",
                "Baptême"
            ],
            "images": [
                {
                    "id": 98,
                    "url": "https://anowan.com/service-providers/images/12058be2-bbda-4884-ae93-37022509c9a4-1718814393.png",
                    "image_cover": 1
                },
                {
                    "id": 99,
                    "url": "https://anowan.com/service-providers/images/fd121401-5556-45d6-acf5-9508a5f0ab80-1718814410.png",
                    "image_cover": 0
                },
                {
                    "id": 101,
                    "url": "https://anowan.com/service-providers/images/503b75d8-9efe-4fbc-a871-ecb7483e9a6c-1718814989.png",
                    "image_cover": 0
                },
                {
                    "id": 104,
                    "url": "https://anowan.com/service-providers/images/0a20d7e8-cb75-460c-ad92-dca2766d0af6-1718815050.png",
                    "image_cover": 0
                },
                {
                    "id": 105,
                    "url": "https://anowan.com/service-providers/images/fd121401-5556-45d6-acf5-9508a5f0ab80-1718816666.png",
                    "image_cover": 0
                },
                {
                    "id": 106,
                    "url": "https://anowan.com/service-providers/images/image-1-1718816815.png",
                    "image_cover": 0
                },
                {
                    "id": 107,
                    "url": "https://anowan.com/service-providers/images/image-3-1718816875.png",
                    "image_cover": 0
                },
                {
                    "id": 108,
                    "url": "https://anowan.com/service-providers/images/image-4-1718816935.png",
                    "image_cover": 0
                },
                {
                    "id": 109,
                    "url": "https://anowan.com/service-providers/images/image-5-1718816950.png",
                    "image_cover": 0
                },
                {
                    "id": 110,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-06-19-a-170947-f502dc30-1718817321.jpg",
                    "image_cover": 0
                },
                {
                    "id": 111,
                    "url": "https://anowan.com/service-providers/images/whatsapp-image-2024-06-19-a-170935-3443c37d-1718817406.jpg",
                    "image_cover": 0
                }
            ],
            "video": null
        }]""";
