import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../providers/user.provider.dart';
import 'image_model.dart';
import 'inspector_model.dart';
import 'localization_model.dart';
import 'organizer_model.dart';
import 'pass_model.dart';

/* List<EventModel> listEventModelFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x))); */

String listEventModelToJson(List<EventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<EventModel> listEventModelFromJson(String str) {
  final jsonData = json.decode(str);

  // Récupère la liste d'objets à partir de la clé 'data'
  final data = jsonData['data'] as List;

  // Convertit chaque élément en un objet PrestatorMdel
  return List<EventModel>.from(data.map((x) => EventModel.fromJson(x)));
}

////single
EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));
String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  final int id;
  final int organizerId;
  final int categoryId;
  final int eventTypeId;
  final int packageId;
  final String name;
  final String uniqueCode;
  final String? slug;
  final String? description;
  final String? shortDescription;
  final bool free;
  final String? qrcode;
  final String? image;
  final bool published;
  final bool active;
  final DateTime? publishedAt;
  final String? paymentTerms;
  final String? infoline;
  final bool visibility;
  final String? shortUrl;
  final List<LocalizationModel> localizations;
  final List<PassModel>? passes;
  final List<InspectorModel>? inspectors;
  final String category;
  final String package;
  final List<ImageModel>? images;
  final String? video;
  final String eventType;
  final OrganizerModel organizer;

  EventModel({
    required this.id,
    required this.organizerId,
    required this.categoryId,
    required this.eventTypeId,
    required this.packageId,
    required this.name,
    required this.uniqueCode,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.free,
    this.qrcode,
    required this.image,
    required this.published,
    required this.active,
    this.publishedAt,
    this.paymentTerms,
    required this.infoline,
    required this.visibility,
    required this.shortUrl,
    required this.localizations,
    required this.passes,
    required this.inspectors,
    required this.category,
    required this.package,
    required this.images,
    this.video,
    required this.eventType,
    required this.organizer,
  });

  // Getter pour vérifier si l'événement est passé
  bool get isPastEvent {
    final now = DateTime.now();
    return localizations.every((localization) {
      // Vérifie si toutes les dates de l'événement sont dans le passé
      return localization.dateEvent.isBefore(now) &&
          (localization.dateEventEnd == null ||
              localization.dateEventEnd!.isBefore(now));
    });
  }

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        organizerId: json["organizer_id"],
        categoryId: json["category_id"],
        eventTypeId: json["event_type_id"],
        packageId: json["package_id"],
        name: json["name"],
        uniqueCode: json["unique_code"],
        slug: json["slug"],
        description: json["description"],
        shortDescription: json["short_description"],
        free: json["free"] == 0 ? false : true,
        qrcode: json["qrcode"],
        image: json["image"] != null
            ? 'https://izibillet.com/events/images/${json["image"]}'
            : networtImgPlaceholder,
        published: json["published"] == 0 ? false : true,
        active: json["active"] == 0 ? false : true,
        publishedAt: json["published_at"] != null
            ? DateTime.parse(json["published_at"])
            : null,
        paymentTerms: json["payment_terms"],
        infoline: json["infoline"],
        visibility: json["visibility"] == 0 ? false : true,
        shortUrl: json["short_url"],
        localizations: List<LocalizationModel>.from(
            json["localizations"].map((x) => LocalizationModel.fromJson(x))),
        passes: json["passes"] != null
            ? List<PassModel>.from(
                json["passes"].map((x) => PassModel.fromJson(x)))
            : null,
        inspectors: json["inspectors"] != null
            ? List<InspectorModel>.from(
                json["inspectors"].map((x) => InspectorModel.fromJson(x)))
            : null,
        category: json["category"] ?? "",
        package: json["package"] ?? "",
        images: json["images"] != null
            ? List<ImageModel>.from(
                json["images"].map((x) => ImageModel.fromJson(x)))
            : null,
        video: json["video"],
        eventType: json["event_type"] ?? "",
        organizer: OrganizerModel.fromJson(json["organizer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organizer_id": organizerId,
        "category_id": categoryId,
        "event_type_id": eventTypeId,
        "package_id": packageId,
        "name": name,
        "unique_code": uniqueCode,
        "slug": slug,
        "description": description,
        "short_description": shortDescription,
        "free": free,
        "qrcode": qrcode,
        "image": image,
        "published": published,
        "active": active,
        "published_at": publishedAt!.toIso8601String(),
        "payment_terms": paymentTerms,
        "infoline": infoline,
        "visibility": visibility,
        "short_url": shortUrl,
        "localizations":
            List<LocalizationModel>.from(localizations.map((x) => x.toJson())),
        "passes": List<PassModel>.from(passes!.map((x) => x.toJson())),
        "inspectors":
            List<InspectorModel>.from(inspectors!.map((x) => x.toJson())),
        "category": category,
        "package": package,
        "images": List<ImageModel>.from(images!.map((x) => x.toJson())),
        "video": video,
        "event_type": eventType,
        "organizer": organizer.toJson(),
      };

  static List<EventModel> eventList = eventModelJsonData
      .map((eventJson) => EventModel.fromJson(eventJson))
      .toList();
}

extension EventModelExtension on EventModel {
  bool isBookmarked(WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return false; // L'utilisateur n'est pas connecté ou chargé
    }
    return user.bookmarkedEventsId.contains(id.toString());
  }
}

List<Map<String, dynamic>> eventModelJsonData = [
  {
    "id": 1,
    "organizer_id": 1,
    "category_id": 1,
    "event_type_id": 4,
    "package_id": 1,
    "name": "Anowan.com",
    "unique_code": "5513242",
    "slug": "anowancom",
    "description":
        "<p>Cet événement permet de réunir  en un seul lieu les demandeurs d'emploi et les recruteurs en vue de rencontres fructueuses en BtoB ou en panel</p>",
    "short_description":
        "Lieu de rencontre entre recruteurs et jeunes demandeurs d'emploi",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARNJREFUOI2F07GthDAMBmCfUqQLC0TKGu5YKSyQ4xaAldKxhqUsAB1FhJ+tuxLzIoQ+JBQ7PwaYTzdj2ke+wDIBRhjdhRBMtwspQ5uRlyfH4N3+n4eN8pOlrrs8778ebi39twXb8jvLrWXRtPUA33VrXpnC2F+ShulY5EJezxhMJ8nzgjSPejfci+e1amPZtFvGtssjy+aW+djcUWnQupZpYv6c8bXJ+5Yh+D7VtJ49m3Yrw3D2gtqD4Zgl9ipZpcU0TZpD+1QoptMMTXJgrWuZ3tyz728mMK2fdUcqMlSmdU4kh4K9mJZ5awdLmD2Y1vkP2AeZlifDu1LwUvfB+gvIEYJpras5VJkTy5qSfBTZtlj+A5xS/af0uusuAAAAAElFTkSuQmCC",
    "image": "jobconferencedays-2024-02-15-160807.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-02-15T16:08:07.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-02-15 16:08:21",
    "payment_terms": null,
    "infoline": "0504360023",
    "visibility": 0,
    "short_url": "JiMq5l",
    "localizations": [
      {
        "id": 1,
        "event_id": 1,
        "date_event": "2024-07-30",
        "starttime_event": "09:00:00",
        "endtime_event": "12:00:00",
        "place": "Centre des expositions d'Abidjan",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-02-15T16:08:07.000000Z",
        "updated_at": "2024-02-15T16:08:07.000000Z"
      },
      {
        "id": 2,
        "event_id": 1,
        "date_event": "2024-07-31",
        "starttime_event": "09:00:00",
        "endtime_event": "12:00:00",
        "place": "Centre des expositions d'Abidjan",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-02-15T16:08:07.000000Z",
        "updated_at": "2024-02-15T16:08:07.000000Z"
      }
    ],
    "passes": [
      {
        "id": 1,
        "event_id": 1,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-02-15T16:08:07.000000Z",
        "updated_at": "2024-03-02T12:14:09.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 2,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "sorogneneyeridavid@gmail.com",
        "email_verified_at": "2024-02-15T15:59:13.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-02-15T15:58:53.000000Z",
        "updated_at": "2024-02-15T16:09:17.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Entreprise",
    "package": "Pack Classic",
    "images": [
      {
        "id": 1,
        "url":
            "https://anowan.com/events/images/jobconferencedays-2024-02-15-160807.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 2,
    "organizer_id": 3,
    "category_id": 6,
    "event_type_id": 8,
    "package_id": 3,
    "name": "GALA POUR L'INCLUSION",
    "unique_code": "3054402011",
    "slug": "gala-pour-linclusion",
    "description":
        "<p>Un grand projet va voir le jour en Côte d’Ivoire : l’ouverture d’une école inclusive qui accueillera et formera scolairement nos enfants autistes et déficients intellectuels. </p><p>A cet effet, l’ONG ORIA organise un gala pour collecter des fonds et construire l'école. </p><p>Dans le contexte actuel où l'INCLUSION est primordial, ce Gala sera agrémenté de deux débats de taille, ainsi que de témoignages et de belles surprises. </p><p> </p><p>Les thèmes de ces débats sont:</p><p><strong>1/Comment construire l'estime de soi dans les familles confrontées au handicap?</strong></p><p><strong>2/Pourquoi l'école inclusive fait-elle peur?</strong></p><p> </p><p>Parrain de l'évènement : <strong>GADJI CELI</strong></p><p><strong>Lieu: Ivoire Golf Club</strong></p><p> </p><p> </p><p>Les pass disponibles</p><p> </p><ul><li>Pass classique : <strong>50 000 F </strong>pour une personne ou <strong>90 000 F </strong>pour un couple</li><li>Pass VIP : <strong>70 000 F </strong> pour une personne ou <strong>130 000 F </strong>pour un couple</li></ul><p>Si vous ne pouvez pas y participer , vous pouvez soutenir la cause si vous le souhaitez :  </p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAB3RJTUUH4wgOCAAWdmwblwAAAAZiS0dEAP8A/wD/oL2nkwAAA3BJREFUeNrNVU2MFEUUfvXXPT09oyw/S1hiTFAOJmSjeJETCQEPxngwRuPRGGPQmz8XEuOBCyeIcuDoXtRwgQvECPFAuACi0eAJY0SjBmGnd2e6e/q3qviqssMezI6JDIlv+vWrrp/3VX3fqww9bGMbDfxw8jUWPzq33ZCIlJJ/7Hr9k+a/APCNBpKsmivL4mQUyotKssM3l95SMwUoqraTptmTVZk/UZfFe1VVLM4UoG50ay21umkoz9KF5ZXsmZkC9Lqq1wll3xhDw7Rkfw9yOVOAfjdc7Pd7O4lxyoo6SfPqp5kBnPvoUNiL45eiqNcjxsCT+W6YVzdmBrBjfsvebhw/L6QipQLQFfy8dPZqOpN7cPr9/Z09T+06vmnz1sOCC2rbmorx+IK19gSztllfwSaPxFswnNQSzFoG3ZrVUfrb3cHwl38I99jCNlATvcoZ9wtUGFEQxQeM1s9hsc9hjCajW5fMI3l3AMa4KcwabbtR8GcYyKPy1y/eUabVHSm4ub2c7O7H3Q9AyxaNnftFVhKoklzIRwiQVhuqy4xWkoQatJ35fmNJA8C4iP6ianYnw/HTUqjwxU4cvsEYFwthtFPX1R6tm8nuXHIk1cQ4v5+MA3iwmtOtv5LlKAxu4lNjtgfBD0C2BtCNptWfSVDxLCN6AdDCLWyNBu8AgDleQY2Pax2+zaHNju2b6fZglN9J0o/ReR0zuB8nz6yRoRq/e+pyI4t8FAkh2CQZRHVxLR+He7CJgF4GAx8XDUWhmgfXm94+dXmVNjCZZRkPlCDBuF8IoRCNy+WpIOfkE8PJxxYc30lyszIqvgHv12mKyXFRK6MFg8ju+JNC8XFdQm+TMQC7mx7Yoh9deuXY17emXrSybikvG6c61U2L3ek1N961gbt2q+Euuj5Pk4DPn/7wIJ96glFe19i9DRRngRQkhRPRiekpmjBExruvEGzE0Gpa/giKzoJ/MxVgmJUpAIzCCw85PVD15NrQ3oOsqeBBWu0Fdqc+PxhVVwg2XYOyvoIaOsM4U0hmgkAudAK1GCoRSwChdpF63fwJWr0M2r498vk1+68AZdVcBL+X3O4YtunKrgrbQ7jmLysl9grOe762GTUQuYAGvwNgqSjrrx7oT//TN/f1AfI49JjDJIMKK9GdoyjuDtNi5ciX3xv6P9g9qb/yymX7NcMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMTRUMTU6MDA6MjItMDc6MDCQMBjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTE0VDE1OjAwOjIyLTA3OjAw4W2gZwAAAABJRU5ErkJggg==\" alt=\"👉🏽\">Canada</p><p>PayPal: <a href=\"https://www.paypal.me/Oriaorg\">https://www.paypal.me/Oriaorg</a></p><p>Virement Interac: info@<a href=\"http://oria.com/514-692-0045?fbclid=IwAR1viX7HuYcFH1blod4Tv728yWRr1SqYqyOwNfjyHdEpO_3-n7plQ80WRrY\">oria.com/514-692-0045</a></p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAB3RJTUUH4wgOCAAWdmwblwAAAAZiS0dEAP8A/wD/oL2nkwAAA3BJREFUeNrNVU2MFEUUfvXXPT09oyw/S1hiTFAOJmSjeJETCQEPxngwRuPRGGPQmz8XEuOBCyeIcuDoXtRwgQvECPFAuACi0eAJY0SjBmGnd2e6e/q3qviqssMezI6JDIlv+vWrrp/3VX3fqww9bGMbDfxw8jUWPzq33ZCIlJJ/7Hr9k+a/APCNBpKsmivL4mQUyotKssM3l95SMwUoqraTptmTVZk/UZfFe1VVLM4UoG50ay21umkoz9KF5ZXsmZkC9Lqq1wll3xhDw7Rkfw9yOVOAfjdc7Pd7O4lxyoo6SfPqp5kBnPvoUNiL45eiqNcjxsCT+W6YVzdmBrBjfsvebhw/L6QipQLQFfy8dPZqOpN7cPr9/Z09T+06vmnz1sOCC2rbmorx+IK19gSztllfwSaPxFswnNQSzFoG3ZrVUfrb3cHwl38I99jCNlATvcoZ9wtUGFEQxQeM1s9hsc9hjCajW5fMI3l3AMa4KcwabbtR8GcYyKPy1y/eUabVHSm4ub2c7O7H3Q9AyxaNnftFVhKoklzIRwiQVhuqy4xWkoQatJ35fmNJA8C4iP6ianYnw/HTUqjwxU4cvsEYFwthtFPX1R6tm8nuXHIk1cQ4v5+MA3iwmtOtv5LlKAxu4lNjtgfBD0C2BtCNptWfSVDxLCN6AdDCLWyNBu8AgDleQY2Pax2+zaHNju2b6fZglN9J0o/ReR0zuB8nz6yRoRq/e+pyI4t8FAkh2CQZRHVxLR+He7CJgF4GAx8XDUWhmgfXm94+dXmVNjCZZRkPlCDBuF8IoRCNy+WpIOfkE8PJxxYc30lyszIqvgHv12mKyXFRK6MFg8ju+JNC8XFdQm+TMQC7mx7Yoh9deuXY17emXrSybikvG6c61U2L3ek1N961gbt2q+Euuj5Pk4DPn/7wIJ96glFe19i9DRRngRQkhRPRiekpmjBExruvEGzE0Gpa/giKzoJ/MxVgmJUpAIzCCw85PVD15NrQ3oOsqeBBWu0Fdqc+PxhVVwg2XYOyvoIaOsM4U0hmgkAudAK1GCoRSwChdpF63fwJWr0M2r498vk1+68AZdVcBL+X3O4YtunKrgrbQ7jmLysl9grOe762GTUQuYAGvwNgqSjrrx7oT//TN/f1AfI49JjDJIMKK9GdoyjuDtNi5ciX3xv6P9g9qb/yymX7NcMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMTRUMTU6MDA6MjItMDc6MDCQMBjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTE0VDE1OjAwOjIyLTA3OjAw4W2gZwAAAABJRU5ErkJggg==\" alt=\"👉🏽\">France</p><p>PayPal: <a href=\"https://www.paypal.me/Oriaorg?fbclid=IwAR3lIQ9P6vw55fLiaT7Uyk5rQofsJEQCDxvJCVH7_RV3wJo-NWGrCNrsNtc\">https://www.paypal.me/Oriaorg</a></p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAB3RJTUUH4wgOCAAWdmwblwAAAAZiS0dEAP8A/wD/oL2nkwAAA3BJREFUeNrNVU2MFEUUfvXXPT09oyw/S1hiTFAOJmSjeJETCQEPxngwRuPRGGPQmz8XEuOBCyeIcuDoXtRwgQvECPFAuACi0eAJY0SjBmGnd2e6e/q3qviqssMezI6JDIlv+vWrrp/3VX3fqww9bGMbDfxw8jUWPzq33ZCIlJJ/7Hr9k+a/APCNBpKsmivL4mQUyotKssM3l95SMwUoqraTptmTVZk/UZfFe1VVLM4UoG50ay21umkoz9KF5ZXsmZkC9Lqq1wll3xhDw7Rkfw9yOVOAfjdc7Pd7O4lxyoo6SfPqp5kBnPvoUNiL45eiqNcjxsCT+W6YVzdmBrBjfsvebhw/L6QipQLQFfy8dPZqOpN7cPr9/Z09T+06vmnz1sOCC2rbmorx+IK19gSztllfwSaPxFswnNQSzFoG3ZrVUfrb3cHwl38I99jCNlATvcoZ9wtUGFEQxQeM1s9hsc9hjCajW5fMI3l3AMa4KcwabbtR8GcYyKPy1y/eUabVHSm4ub2c7O7H3Q9AyxaNnftFVhKoklzIRwiQVhuqy4xWkoQatJ35fmNJA8C4iP6ianYnw/HTUqjwxU4cvsEYFwthtFPX1R6tm8nuXHIk1cQ4v5+MA3iwmtOtv5LlKAxu4lNjtgfBD0C2BtCNptWfSVDxLCN6AdDCLWyNBu8AgDleQY2Pax2+zaHNju2b6fZglN9J0o/ReR0zuB8nz6yRoRq/e+pyI4t8FAkh2CQZRHVxLR+He7CJgF4GAx8XDUWhmgfXm94+dXmVNjCZZRkPlCDBuF8IoRCNy+WpIOfkE8PJxxYc30lyszIqvgHv12mKyXFRK6MFg8ju+JNC8XFdQm+TMQC7mx7Yoh9deuXY17emXrSybikvG6c61U2L3ek1N961gbt2q+Euuj5Pk4DPn/7wIJ96glFe19i9DRRngRQkhRPRiekpmjBExruvEGzE0Gpa/giKzoJ/MxVgmJUpAIzCCw85PVD15NrQ3oOsqeBBWu0Fdqc+PxhVVwg2XYOyvoIaOsM4U0hmgkAudAK1GCoRSwChdpF63fwJWr0M2r498vk1+68AZdVcBL+X3O4YtunKrgrbQ7jmLysl9grOe762GTUQuYAGvwNgqSjrrx7oT//TN/f1AfI49JjDJIMKK9GdoyjuDtNi5ciX3xv6P9g9qb/yymX7NcMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMTRUMTU6MDA6MjItMDc6MDCQMBjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTE0VDE1OjAwOjIyLTA3OjAw4W2gZwAAAABJRU5ErkJggg==\" alt=\"👉🏽\">Côte d'Ivoire</p><p>Achat de coupons Solid-Oria: 10 000 FCFA, 30 000 FCFA, 50 000 FCFA, 100 000 FCFA et plus par transfert WAVE et ORANGE MONEY au +225 07 00 304 828</p>",
    "short_description":
        "Parce que la différence est aussi une RICHESSE, ORIA organise en Côte d'Ivoire un Gala pour collecter des fonds afin de favoriser l'inclusion scolaire des enfants déficients intellectuels et autistes.",
    "free": 0,
    "qrcode": null,
    "image": "gala-pour-linclusion-2024-04-21-014546.jpg",
    "published": 1,
    "active": 0,
    "created_at": "2024-03-12T10:16:34.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-03-12 10:59:19",
    "payment_terms": "WAVE et ORANGE MONEY : +225 07 00 304 828",
    "infoline": "WhatsApp: +15146920045 ou contact@oriasoutien.com",
    "visibility": 1,
    "short_url": "zf12Lo",
    "localizations": [
      {
        "id": 3,
        "event_id": 2,
        "date_event": "2024-05-18",
        "starttime_event": "19:45:00",
        "endtime_event": "23:30:00",
        "place": "Ivoire Golf Club Boulevard de France, Abidjan",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-03-12T10:16:34.000000Z",
        "updated_at": "2024-04-21T19:20:31.000000Z"
      }
    ],
    "passes": [
      {
        "id": 2,
        "event_id": 2,
        "name": "Classique Simple",
        "description": "Pour une personne",
        "price": 50000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-03-12T10:16:34.000000Z",
        "updated_at": "2024-03-17T23:25:20.000000Z",
        "people_max": "1"
      },
      {
        "id": 3,
        "event_id": 2,
        "name": "Classique Couple",
        "description": "Pour deux personnes",
        "price": 90000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-03-12T10:16:34.000000Z",
        "updated_at": "2024-03-17T23:25:20.000000Z",
        "people_max": "1"
      },
      {
        "id": 4,
        "event_id": 2,
        "name": "VIP Simple",
        "description": "Pour une personne",
        "price": 70000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-03-12T10:16:34.000000Z",
        "updated_at": "2024-03-17T23:25:20.000000Z",
        "people_max": "1"
      },
      {
        "id": 5,
        "event_id": 2,
        "name": "VIP Couple",
        "description": "Pour deux personnes",
        "price": 130000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-03-12T10:16:34.000000Z",
        "updated_at": "2024-03-17T23:25:20.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 3,
      "user_id": 6,
      "avatar": "oria-2024-03-11-151549.jpg",
      "name": "ORIA",
      "unique_code": "2634321",
      "phone": null,
      "description":
          "<p><strong>ORIA</strong> est l'initiative de Michèle- Francine Acho. </p><p> </p><p>Michèle-Francine Acho<i><strong> </strong></i>est maman de deux enfants épileptiques et quadréparesiques. L’'aînée est, en plus, déficiente intellectuelle et paralytique cérébrale partielle. Le second, lui, a un retard global de développement.</p><p> </p><p>Le combat qu’elle mène chaque jour ainsi que les épreuves quotidiennes auxquelles elle fait face depuis quatorze ans maintenant, qui lui montrent son extrême impuissance face aux problématiques de ses enfants, lui ont fait comprendre que toute famille dans sa condition a besoin de soutien moral et psychologique dans un premier temps, puis matériel. </p><p> </p><p>Le but de l'ONG <strong>ORIA </strong>est d’apporter un soutien psychologique, éducatif et matériel aux familles vivant une situation de handicap en Côte d'Ivoire et en Afrique.</p><p> </p>",
      "active": 1,
      "short_description":
          "ORIA a pour but ultime d'offrir un soutien aux familles vivant une situation de handicap.",
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
    "category": "Charité et Levée de fonds",
    "package": "Pack PRO CHAP",
    "images": [
      {
        "id": 2,
        "url":
            "https://anowan.com/events/images/gala-pour-linclusion-2024-04-21-014546.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Dîner"
  },
  {
    "id": 3,
    "organizer_id": 3,
    "category_id": 4,
    "event_type_id": 4,
    "package_id": 1,
    "name": "Projection-Débat",
    "unique_code": "6883175359",
    "slug": "projection-debat",
    "description":
        "<p> </p><p>Lauréats de l'édition 2023-2024 de l'appel à projet du MINISTERE DES RELATIONS INTERNATIONALES ET DE LA FRANCOPHONIE DU QUEBEC, les Organisations Oria et Le Centre Padre Pio organisent une conférence pour débattre sur un thème très important:</p><p>Parents COURAGE: Des défis vers la nécessité d’un SOUTIEN réel et efficient.</p><p>Pour débattre de ce sujet , Alexandra Bores, psychologue d'état de la fonction publique française  et conférencière, fera le déplacement de Paris à Abidjan. Elle sera accompagnée d'Hervé Gbohagnon, travailleur psycho-social, en Côte d'Ivoire.</p><p>Les place sont GRATUITES, mais limitées.</p><p> </p><p>Quand?</p><p>Le 18 mai 2024 </p><p>Où?</p><p>A Ivoire Golf club</p><p>Combien?</p><p>L'entrée est GRATUITE</p><p>Pour bien vous délecter de ce débat, une pause café avec de la pâtisserie fine vous sera servi</p>",
    "short_description":
        "L'organisation Oria en partenariat avec Le Centre Padre Pio Organisent une projection débat pour parler de la nécessité d'accompagner les parents d'enfants déficients intellectuels, autistes, trisomiques et paralytiques cérébraux",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ5JREFUOI2F07GtxCAMBuA/SkHHLYDEGnReibdALrcAt1K6rIHEAnndFVb8THJlnIdSfEWEfxuAyCeW1GaSHZYrEpCCT/Cm255CTq0kKXdusrL/x3VCne6sdTVbr+5Na34t2sq3l0vrCnDtgGUeJMoneLDtAIwbIbu2mWZPnEnea9/TsDY4loTHyrY1/zmNs8dLV6AVJzv1iRmWjepjDZ7ibJqHBTlp/rGY7if7Ev5Z9H/LPKwVrmbSkZrOFH8lbq6P1LCGr6CxEGD79WlvCU/RPS3rkuJwnJ3l457oJUkym9abxpPOHNWb7icyUX0K5zuHyYkssdx5nJ3ml8201tU56He+kUv3/Dv6k5wt/wHvsNyPAibk4gAAAABJRU5ErkJggg==",
    "image": "projection-debat-2024-04-21-015628.jpg",
    "published": 1,
    "active": 0,
    "created_at": "2024-03-18T00:42:41.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-03-18 01:12:41",
    "payment_terms": null,
    "infoline":
        "Whatsapp: +1 514 6920045\r\n+225 08367695\r\nemail: contact@oriasoutien.com",
    "visibility": 1,
    "short_url": "KkoYXc",
    "localizations": [
      {
        "id": 4,
        "event_id": 3,
        "date_event": "2024-05-18",
        "starttime_event": "09:00:00",
        "endtime_event": "11:30:00",
        "place": "Ivoire Golf Club Boulevard de France, Abidjan",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-03-18T00:42:41.000000Z",
        "updated_at": "2024-05-05T00:45:02.000000Z"
      }
    ],
    "passes": [
      {
        "id": 6,
        "event_id": 3,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-03-18T00:42:41.000000Z",
        "updated_at": "2024-03-18T00:42:41.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 3,
      "user_id": 6,
      "avatar": "oria-2024-03-11-151549.jpg",
      "name": "ORIA",
      "unique_code": "2634321",
      "phone": null,
      "description":
          "<p><strong>ORIA</strong> est l'initiative de Michèle- Francine Acho. </p><p> </p><p>Michèle-Francine Acho<i><strong> </strong></i>est maman de deux enfants épileptiques et quadréparesiques. L’'aînée est, en plus, déficiente intellectuelle et paralytique cérébrale partielle. Le second, lui, a un retard global de développement.</p><p> </p><p>Le combat qu’elle mène chaque jour ainsi que les épreuves quotidiennes auxquelles elle fait face depuis quatorze ans maintenant, qui lui montrent son extrême impuissance face aux problématiques de ses enfants, lui ont fait comprendre que toute famille dans sa condition a besoin de soutien moral et psychologique dans un premier temps, puis matériel. </p><p> </p><p>Le but de l'ONG <strong>ORIA </strong>est d’apporter un soutien psychologique, éducatif et matériel aux familles vivant une situation de handicap en Côte d'Ivoire et en Afrique.</p><p> </p>",
      "active": 1,
      "short_description":
          "ORIA a pour but ultime d'offrir un soutien aux familles vivant une situation de handicap.",
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
    "category": "Social",
    "package": "Pack Classic",
    "images": [
      {
        "id": 3,
        "url":
            "https://anowan.com/events/images/projection-debat-2024-04-21-015628.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 4,
    "organizer_id": 3,
    "category_id": 4,
    "event_type_id": 1,
    "package_id": 1,
    "name": "COUPON SOLID-ORIA",
    "unique_code": "5388909932",
    "slug": "coupon-solid-oria",
    "description":
        "<p> </p><p>Oria est une Association à but non lucratif qui se bat pour l’inclusion scolaire des enfants déficients intellectuels et autistes. <br>Dans cette démarche, elle organise un dîner gala, le 18 mai 2024 au Palm Club, afin de collecter des fonds pour équiper l’école inclusive qu’elle va ouvrir en 2025.Pour nous soutenir, vous avez la possibilité, avec nos coupons Solid-Oria, de contribuer à la cause par transfert wave ou orange au +2250700304828 à hauteur de:<br>10000F, 30000F, 50000F, 100000F et plus. <br>Si vous désirez participer à l'événement, cliquez sur ce lien :</p><p> </p><p><a href=\"https://forms.gle/PAJBztWnZ1CTjS3M7\">https://forms.gle/PAJBztWnZ1CTjS3M7</a></p><p> </p>",
    "short_description":
        "Oria est une Association à but non lucratif qui se bat pour l’inclusion scolaire des enfants déficients intellectuels et autistes.",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQxJREFUOI2F072NhTAMB3CjFOnCApayBl1WCgsEbgFYiY41IrHAuy5FFN8/7951mLMQ+jXEHzEkUjIFWYM00pxpqnPhOJFTfbVJtsAO7yfXpVzrP6ZBcPKD8c7zkdOnhluj/mubru3Ty60RfiVO9Bu3rmOhGDha31TL98kU+rh0Z0wpBRpLdrrJmj6ECak1V4fi0cVJUTUl4r+705wXwWPwyaaah5NT8IKRqvZfmKdlR8irGa3Jfpot1KTarIHnMzuLLjQjGFez97ya5RUM8o5SnWqEtPcQdGNPfLOmb6/qvv9p8v0HUd33v1leet4H0yh5OOjR/mVFDhyrueeNQfby3pl7o34sEra3Rs0/dlHZtulM8+4AAAAASUVORK5CYII=",
    "image": "coupon-solid-oria-2024-03-20-111658.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-03-20T11:16:58.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-03-20 11:18:13",
    "payment_terms": null,
    "infoline":
        "Pour tout renseignement, contacter:\r\n whatsapp: +15146920045 / contact@oriasoutien.com",
    "visibility": 1,
    "short_url": "lvwdnZ",
    "localizations": [
      {
        "id": 5,
        "event_id": 4,
        "date_event": "2024-05-18",
        "starttime_event": "08:00:00",
        "endtime_event": "23:00:00",
        "place": "Palm Club",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-03-20T11:16:58.000000Z",
        "updated_at": "2024-03-20T11:21:47.000000Z"
      }
    ],
    "passes": [
      {
        "id": 7,
        "event_id": 4,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-03-20T11:16:58.000000Z",
        "updated_at": "2024-03-20T11:16:58.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 3,
      "user_id": 6,
      "avatar": "oria-2024-03-11-151549.jpg",
      "name": "ORIA",
      "unique_code": "2634321",
      "phone": null,
      "description":
          "<p><strong>ORIA</strong> est l'initiative de Michèle- Francine Acho. </p><p> </p><p>Michèle-Francine Acho<i><strong> </strong></i>est maman de deux enfants épileptiques et quadréparesiques. L’'aînée est, en plus, déficiente intellectuelle et paralytique cérébrale partielle. Le second, lui, a un retard global de développement.</p><p> </p><p>Le combat qu’elle mène chaque jour ainsi que les épreuves quotidiennes auxquelles elle fait face depuis quatorze ans maintenant, qui lui montrent son extrême impuissance face aux problématiques de ses enfants, lui ont fait comprendre que toute famille dans sa condition a besoin de soutien moral et psychologique dans un premier temps, puis matériel. </p><p> </p><p>Le but de l'ONG <strong>ORIA </strong>est d’apporter un soutien psychologique, éducatif et matériel aux familles vivant une situation de handicap en Côte d'Ivoire et en Afrique.</p><p> </p>",
      "active": 1,
      "short_description":
          "ORIA a pour but ultime d'offrir un soutien aux familles vivant une situation de handicap.",
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
    "category": "Social",
    "package": "Pack Classic",
    "images": [
      {
        "id": 4,
        "url":
            "https://anowan.com/events/images/coupon-solid-oria-2024-03-20-111658.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "One Time"
  },
  {
    "id": 6,
    "organizer_id": 5,
    "category_id": 8,
    "event_type_id": 6,
    "package_id": 1,
    "name": "GLORY",
    "unique_code": "7522304494",
    "slug": "glory",
    "description":
        "<p>La Glorieuse Louange Œcuménique de Reconnaissance à YHWH, c'est un concert live d’action de grâce, de louange et d’adoration avec le SWC de la Pastorale pour la Propagation de l'Evangile et plusieurs autres chantres invités.</p>",
    "short_description":
        "La Glorieuse Louange Œcuménique de Reconnaissance à YHWH, c'est un concert live d’action de grâce, de louange et d’adoration avec le SWC de la Pastorale pour la Propagation de l'Evangile et plusieurs autres chantres invités.",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARBJREFUOI2F072NhTAMB3AjCrpkgUiskc4rwQKQWyBvJbqsYSkLcB1FFJ/93l2HuRToV+Tjn9gA8zW+ynwid7BMEGvC4CI407XLF8FFzk/mVwnLPw4AY3+ynNv2Qn8Zbi35a441/97l1jLmc4INPuPW3LEt0FaJZ5rWUiXVzuRMw/Z+K3/opoZ1sovjOcmelsPKnLFJwmS6cqHhqnzJuZZl8sxMgDLfchsOvZ3kX0xL1TTVMmkGw1IUrcg3y0Usk+c2cAAck+n6dYwZa0c513RG8kfYuXbTWtYU9RFsS5+Q9NIWOZmWfgvrJRuSMy1927YpeK7nk3WVvFV/tC+ckE/T2v/+IKd9Yvnd/6D/dbL8A5Iy6b7y4vpkAAAAAElFTkSuQmCC",
    "image": "glory-ok-1719439197.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-05-20T09:29:16.000000Z",
    "updated_at": "2024-06-26T22:01:15.000000Z",
    "published_at": "2024-05-20 09:32:34",
    "payment_terms": null,
    "infoline":
        "+(225) 07 08 96 2294 - 07 58 10 8247\r\nhttps://www.facebook.com/P.P.E.Pastorale",
    "visibility": 1,
    "short_url": "blYou9",
    "localizations": [
      {
        "id": 7,
        "event_id": 6,
        "date_event": "2024-07-13",
        "starttime_event": "15:00:00",
        "endtime_event": "19:00:00",
        "place": "Centre culturel ivoiro-coreen - Espace CSCTICAO",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-05-20T09:29:16.000000Z",
        "updated_at": "2024-06-14T14:54:03.000000Z"
      }
    ],
    "passes": [
      {
        "id": 9,
        "event_id": 6,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-05-20T09:29:16.000000Z",
        "updated_at": "2024-05-20T09:29:16.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 5,
      "user_id": 188,
      "avatar":
          "pastorale-pour-la-propagation-de-levangile-2024-05-20-093152.jpg",
      "name": "Pastorale pour la Propagation de l'Evangile",
      "unique_code": "819102570",
      "phone": null,
      "description":
          "<p><strong>La Pastorale pour la Propagation de l’Evangile (PPE) </strong>est une communauté nouvelle catholique qui a pour mission la propagation de l’Evangile à temps et à contretemps dans toutes les régions du monde qui n’ont pas encore expérimenté la puissance de salut de notre Seigneur Jésus-Christ. </p><p> </p><p>Nous propageons l’évangile de Jésus-Christ par divers canaux dont le concert œcuménique d’action de grâce, de louange et d’adoration, GLORY.</p><p> </p><p>Temps d’enseignement et d’édification</p><p>Temps dédié de louange et d’adoration</p><p>-Dans le Saint des saints</p><p>-Trône de Gloire</p><p>-GLORY</p><p>-La brise du Cramel</p><p>Evangélisations :</p><p>Retraites spirituelles trimestrielles.</p><p>Activités diverses :</p><p>-Journée sportive (décembre) ;</p><p>-Journée du Motivation d’orientation (février) ;</p><p>-Visites aux malades et aux orphelins ;</p><p>-Arbres de Noel (décembre) ;</p>",
      "active": 1,
      "short_description":
          "La Pastorale pour la Propagation de l'Évangile est une communauté chrétienne qui a pour but le salut de la multitude et la joie du ciel au travers de plusieurs canaux, notamment les évangélisations, concert, retraite, journée récréative, diner, etc",
      "website": "pastoralepropagationevangile.org",
      "facebook": "https://www.facebook.com/P.P.E.Pastorale",
      "twitter": null,
      "instagram": "https://www.instagram.com/pastorale_ppe/",
      "created_at": "2024-05-07T20:26:55.000000Z",
      "updated_at": "2024-05-20T09:31:52.000000Z",
      "user": {
        "id": 188,
        "name": "Doho epse VLEI",
        "firstname": "Marie Dominique",
        "phone": "0708962294",
        "email": "mariedominique.doho@ppe-ci.org",
        "email_verified_at": "2024-05-07T20:23:07.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-05-07T20:22:08.000000Z",
        "updated_at": "2024-05-20T09:32:17.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Religieux",
    "package": "Pack Classic",
    "images": [
      {
        "id": 113,
        "url": "https://anowan.com/events/images/glory-ok-1719439110.jpg",
        "image_cover": 0
      },
      {
        "id": 114,
        "url": "https://anowan.com/events/images/glory-ok-1719439197.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Festival"
  },
  {
    "id": 7,
    "organizer_id": 7,
    "category_id": 4,
    "event_type_id": 2,
    "package_id": 1,
    "name": "PACK CLASSIC EMAIL",
    "unique_code": "1502950151",
    "slug": "pack-classic-email",
    "description": "<p>PACK CLASSIC EMAIL</p>",
    "short_description": "PACK CLASSIC EMAIL",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ1JREFUOI2F00GOhCAQBdDqsGBHX4CEa7DjSvYF1LkAfSV3XoOEC9g7F8SaX5lZzncMMU+DFHxBVE8J2a1FL2FukkVkhCyBul85on/NWu/cdcPjP16lzXdG3aSbVQ/UmH+vudfftfxpu+bifkA8HiqPfQQZ3HpIf6tMvh/UQ0qUou/dxiROX7hnee6Du73OdHmkYeslTggqeL1Km6mRQAzW8JIZFS2EybtK3Z4qzzO+NhuceMw+LnubSr+o9XP2z54OHwN1swSKqwVZMfe1xEXRMCazfRLQ3/4dM/aJVstTV2rsNK0ZYTahRs+EE7TouDVycLqlemdXveI6qFG3r75hO1VqzH8sZ5zsNBF/A5/jzGAHMQMSAAAAAElFTkSuQmCC",
    "image": null,
    "published": 0,
    "active": 1,
    "created_at": "2024-05-23T11:03:49.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": null,
    "payment_terms": null,
    "infoline": "07 77 777 104",
    "visibility": 0,
    "short_url": "tsfAK7",
    "localizations": [
      {
        "id": 8,
        "event_id": 7,
        "date_event": "2024-12-31",
        "starttime_event": "08:00:00",
        "endtime_event": "12:00:00",
        "place": "PALM CLUB",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-05-23T11:03:49.000000Z",
        "updated_at": "2024-05-23T11:03:49.000000Z"
      }
    ],
    "passes": [
      {
        "id": 10,
        "event_id": 7,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-05-23T11:03:49.000000Z",
        "updated_at": "2024-05-23T11:03:49.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 7,
      "user_id": 187,
      "avatar": "digifaz-event-2024-05-23-104549.jpg",
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
        "id": 187,
        "name": "Konan",
        "firstname": "Nadège",
        "phone": "0748086093",
        "email": "nadege.assohou@digifaz.com",
        "email_verified_at": "2024-05-23T10:59:28.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-04-15T15:17:29.000000Z",
        "updated_at": "2024-07-12T13:03:16.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Social",
    "package": "Pack Classic",
    "images": [
      {
        "id": 6,
        "url": "https://anowan.com/events/images/logo-3d-1716462062.jpg",
        "image_cover": 1
      },
      {
        "id": 7,
        "url": "https://anowan.com/events/images/couverture-rs-1716462141.jpg",
        "image_cover": 0
      }
    ],
    "video": null,
    "event_type": "Brunch"
  },
  {
    "id": 8,
    "organizer_id": 1,
    "category_id": 4,
    "event_type_id": 4,
    "package_id": 1,
    "name": "test prod",
    "unique_code": "5586299809",
    "slug": "test-prod",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ1JREFUOI2F0rGthDAMBmCjFHRhAaSsQZeVYAHuWCCslO7WsOQFch1FFL8fcSXmWSk+RYj8TkyqxzgcWqI2ssw08RolTeRNS5sUK2E9OZTelX/MnRI9GefWObr2y3Br5EcwSb9ebo2qvh9XuurW5w/fxD5KMa1blm/W/Ri9aSkxbFlLH4rp6om6LOdVmHYlsu91V8SzzCsFdPfKyG/ZpVj9xEPGjuWx+7Cfwn7U2TQvyks+E9oO+wc9CrJ503gR6g7uMq2mHSItWofMtmVTRoMvlbdpFF6/4uNm+pwTTD6uYjaNeQutl0TXTN4ac+sU2ZT9kxVz0qKWJ49XsGQa5+pXVTPNppEf4etwvp3hP4vmBiCiQd3tAAAAAElFTkSuQmCC",
    "image": "mot-superposition-dossier-jeunes-1716905542.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-05-28T14:12:55.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-05-28 14:13:03",
    "payment_terms": null,
    "infoline": "test",
    "visibility": 0,
    "short_url": "AFaT5A",
    "localizations": [
      {
        "id": 9,
        "event_id": 8,
        "date_event": "2024-05-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-05-28T14:12:55.000000Z",
        "updated_at": "2024-05-28T14:12:55.000000Z"
      }
    ],
    "passes": [
      {
        "id": 11,
        "event_id": 8,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-05-28T14:12:55.000000Z",
        "updated_at": "2024-05-28T14:12:55.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 2,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "sorogneneyeridavid@gmail.com",
        "email_verified_at": "2024-02-15T15:59:13.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-02-15T15:58:53.000000Z",
        "updated_at": "2024-02-15T16:09:17.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Social",
    "package": "Pack Classic",
    "images": [
      {
        "id": 8,
        "url":
            "https://anowan.com/events/images/mot-superposition-dossier-jeunes-1716905542.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 9,
    "organizer_id": 4,
    "category_id": 6,
    "event_type_id": 4,
    "package_id": 3,
    "name": "test prochap",
    "unique_code": "1611023561",
    "slug": "test-prochap",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQlJREFUOI2F07GtxCAMAFBLFHRkASTWoGOlZAHCLUBWossaSF4gZQqEz7775Tk/iqKnyMHGOEB0ewCaiSZo7hBHtt5FcKpxxnAlUyPVJ4+Nl/3HHNzzkzkvFsvPbw0/zfVjjVj/9vLTcjkwXyiWDhynX06/qg7Tcq/6Tt2pppJ8tvyJrKnYFBsu6M6OVXWge2QI/Kao7lvDoxFJXs2GKNTkXeJ4zfhqVCPsBKtq2O6+nGNrHK+Z83JtfSOsunmWlhNcNEX30rBac0hezfi6cdqxE07Vn7YDJyXdJP1MMm9FNdfmxSC3Yp7bDuAXwvLkkSPw8c0n86gEPrxLNeft2UrbV9VSv4D/FM1v5uLrpKEjXy0AAAAASUVORK5CYII=",
    "image": "mot-superposition-dossier-jeunes-1716978554.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-05-29T10:30:21.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-06-06 21:28:27",
    "payment_terms": "test",
    "infoline": "test",
    "visibility": 0,
    "short_url": "29VeGF",
    "localizations": [
      {
        "id": 10,
        "event_id": 9,
        "date_event": "2024-07-12",
        "starttime_event": "13:00:00",
        "endtime_event": "14:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-05-29T10:30:21.000000Z",
        "updated_at": "2024-05-29T10:30:21.000000Z"
      }
    ],
    "passes": [
      {
        "id": 12,
        "event_id": 9,
        "name": "test",
        "description": "test",
        "price": 4565,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-05-29T10:30:21.000000Z",
        "updated_at": "2024-06-06T21:35:42.000000Z",
        "people_max": "2"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Charité et Levée de fonds",
    "package": "Pack PRO CHAP",
    "images": [
      {
        "id": 9,
        "url":
            "https://anowan.com/events/images/mot-superposition-dossier-jeunes-1716978554.jpg",
        "image_cover": 1
      },
      {
        "id": 10,
        "url":
            "https://anowan.com/events/images/1-ecole-en-ligne-nimba-edu-1716978574.png",
        "image_cover": 0
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 10,
    "organizer_id": 4,
    "category_id": 7,
    "event_type_id": 2,
    "package_id": 2,
    "name": "test pro lite 1",
    "unique_code": "1761115520",
    "slug": "test-pro-lite-1",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARBJREFUOI2F0rGtxCAMBmBHFOnIApFYg46VuAW4uwXISnRZwxILcF0KhN9/L6+M81ygT1GU/NgmkWNdxLUggzQzeU5zzZ6s6jq8DO+yl3xn17xp/5inHV++Mc7+2PHkzHBp5Eewmv/ucmlUt/Oa6KxL9xjMJmxDbaqN7PVT3HasVjXedFuRNrum2nwKT6W22eheU+BFZBPEU43rN6JnQX7NfZGeiJfihmq37eY3f4+qKQb3ProFdFv001dks6oxEUaXpkJJNdHMKfSlsG6OXt6FnlJfqlGyFVyzDtXfPXl5tp6jauwbPaRmOnfy0thGk5FNON0Zc5ERcN7YDf8NllXjv2imSKGoGvn7dPTlOzvFP7rSAHoDL/uTAAAAAElFTkSuQmCC",
    "image": "coocogoose-pro-by-zetafonts-1716986833.png",
    "published": 1,
    "active": 1,
    "created_at": "2024-05-29T12:48:10.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-05-29 12:48:19",
    "payment_terms": null,
    "infoline": "test",
    "visibility": 0,
    "short_url": "4Ct8Nz",
    "localizations": [
      {
        "id": 11,
        "event_id": 10,
        "date_event": "2024-08-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-05-29T12:48:10.000000Z",
        "updated_at": "2024-08-19T13:33:12.000000Z"
      }
    ],
    "passes": [
      {
        "id": 13,
        "event_id": 10,
        "name": "test",
        "description": "test",
        "price": 5465,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-05-29T12:48:10.000000Z",
        "updated_at": "2024-08-19T13:38:46.000000Z",
        "people_max": "1"
      },
      {
        "id": 44,
        "event_id": 10,
        "name": "test 2",
        "description": "test",
        "price": 100,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-19T13:38:46.000000Z",
        "updated_at": "2024-08-19T13:38:46.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Divertissement",
    "package": "Pack PRO LITE",
    "images": [
      {
        "id": 11,
        "url":
            "https://anowan.com/events/images/coocogoose-pro-by-zetafonts-1716986833.png",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Brunch"
  },
  {
    "id": 11,
    "organizer_id": 7,
    "category_id": 1,
    "event_type_id": 3,
    "package_id": 1,
    "name": "CLASSIC SMS",
    "unique_code": "2412711162",
    "slug": "classic-sms",
    "description": "<p>CLASSIC SMS</p>",
    "short_description": "CLASSIC SMS",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARRJREFUOI2F07GNxCAQBdA5OSDDDViiDTJawg3Y3gZwS87cBhIN7GYTIP+bud3Qs0dgPSEZhuFDAGMHtoSLLFeKeHDPkbzpdsX2TJOPKN/cZ27bPyZKurJt+daV6/Kp4dZSfyuxlc9Zbi1j8mla6D1u3UemhabswmV6KC4UqU3XtBzAlBONXL3ptp/tKb9E2dpynSHFB5yUTffxoB+Ev7uzLJfSsxsKaW8Nh11XA466mMYVpaWTJ50xXMnVnKS8vpimleV+ybtWTA+bk15h130tAxgkbyO6Ny2jvaDBti3F03yGS/NmWfLWpdt6ENOa7ZX7Cpn54gFoj+P9jiwHqX89JG+WNf/y0HbWnBjW/L9Y0tuz5V9awvtk4sPf7AAAAABJRU5ErkJggg==",
    "image": "carte-du-monde-1717067288.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-05-30T11:08:36.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-05-30 11:08:56",
    "payment_terms": null,
    "infoline": "080808080808",
    "visibility": 0,
    "short_url": "VRBLZ3",
    "localizations": [
      {
        "id": 12,
        "event_id": 11,
        "date_event": "2024-06-30",
        "starttime_event": "12:00:00",
        "endtime_event": "20:00:00",
        "place": "ABIDJAN",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-05-30T11:08:36.000000Z",
        "updated_at": "2024-05-30T11:08:36.000000Z"
      }
    ],
    "passes": [
      {
        "id": 14,
        "event_id": 11,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-05-30T11:08:36.000000Z",
        "updated_at": "2024-05-30T11:08:36.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 7,
      "user_id": 187,
      "avatar": "digifaz-event-2024-05-23-104549.jpg",
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
        "id": 187,
        "name": "Konan",
        "firstname": "Nadège",
        "phone": "0748086093",
        "email": "nadege.assohou@digifaz.com",
        "email_verified_at": "2024-05-23T10:59:28.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-04-15T15:17:29.000000Z",
        "updated_at": "2024-07-12T13:03:16.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Entreprise",
    "package": "Pack Classic",
    "images": [
      {
        "id": 26,
        "url": "https://anowan.com/events/images/carte-du-monde-1717067219.jpg",
        "image_cover": 0
      },
      {
        "id": 27,
        "url": "https://anowan.com/events/images/carte-du-monde-1717067288.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Séminaire"
  },
  {
    "id": 12,
    "organizer_id": 7,
    "category_id": 7,
    "event_type_id": 2,
    "package_id": 3,
    "name": "PRO CHAP SMS",
    "unique_code": "7270526108",
    "slug": "pro-chap-sms",
    "description": "<p>PRO CHAP SMS</p>",
    "short_description": "PRO CHAP SMS",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQxJREFUOI2F072twyAQB/B7oqAjC1hiDTpWshew/RaAldyxBhILkM4F8r3/Ja/MOSmsn6XLfRmI+fQ9mD3yRZorBVrDcIGc6nYFiU+B053b85jcN6dQ1zujrv89pLpTjf4R39L/LB+NH4q2FzSPH/YZvdHQPc0Wi6qzbV01Op9W63NBTs2+SyQ9ytA9HqjL5pIZNdelmFz4inVVTQtzisNFv6vmbgeyYYqkmrYTOaflkP8qHqutztY5YqWauUfTIzJjpZplCUQmRTxV5xMbmDZGTs0Stkd6fTvNck4uHJLAu2qcNMQbXBCnGueWtlI3Hl/MzIdPd/bPMvDaVUtdjEnxfUc+WvrPcrXbrvkPyxHeHmb2BY0AAAAASUVORK5CYII=",
    "image": "couverture-rs-1717613020.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-06-05T18:47:11.000000Z",
    "updated_at": "2024-06-12T16:03:09.000000Z",
    "published_at": "2024-06-05 18:47:59",
    "payment_terms": "Orange Money : + 225 07 77 777 104",
    "infoline": "+225 07 77 777 104",
    "visibility": 0,
    "short_url": "HvIhcu",
    "localizations": [
      {
        "id": 13,
        "event_id": 12,
        "date_event": "2024-08-12",
        "starttime_event": "10:00:00",
        "endtime_event": "16:00:00",
        "place": "Jardin Botanique de Bingerville",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-06-05T18:47:11.000000Z",
        "updated_at": "2024-08-12T16:56:36.000000Z"
      }
    ],
    "passes": [
      {
        "id": 15,
        "event_id": 12,
        "name": "Enfant",
        "description": "Normal",
        "price": 0,
        "passes_quantity": "2",
        "remaining_passes": "1",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-06-05T18:47:11.000000Z",
        "updated_at": "2024-08-12T17:01:08.000000Z",
        "people_max": "1"
      },
      {
        "id": 16,
        "event_id": 12,
        "name": "VIP",
        "description": "VIP",
        "price": 25000,
        "passes_quantity": "1",
        "remaining_passes": "2",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-06-05T18:47:11.000000Z",
        "updated_at": "2024-08-12T17:01:08.000000Z",
        "people_max": "1"
      },
      {
        "id": 32,
        "event_id": 12,
        "name": "GBONHI",
        "description": "GBONHI",
        "price": 75000,
        "passes_quantity": "1",
        "remaining_passes": null,
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-12T16:58:59.000000Z",
        "updated_at": "2024-08-12T17:01:08.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 7,
      "user_id": 187,
      "avatar": "digifaz-event-2024-05-23-104549.jpg",
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
        "id": 187,
        "name": "Konan",
        "firstname": "Nadège",
        "phone": "0748086093",
        "email": "nadege.assohou@digifaz.com",
        "email_verified_at": "2024-05-23T10:59:28.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-04-15T15:17:29.000000Z",
        "updated_at": "2024-07-12T13:03:16.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Divertissement",
    "package": "Pack PRO CHAP",
    "images": [
      {
        "id": 91,
        "url": "https://anowan.com/events/images/couverture-rs-1717613020.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Brunch"
  },
  {
    "id": 16,
    "organizer_id": 8,
    "category_id": 7,
    "event_type_id": 6,
    "package_id": 3,
    "name": "Sweet Lunch",
    "unique_code": "7607331742",
    "slug": "sweet-lunch",
    "description":
        "<p>Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins et repartant avec des lots🥰</p><p> </p><p>Nous profitons de ce moment pour récompenser nos meilleurs clients, partageurs, soutiens ...</p><p> </p><p>COÛT DES TICKETS(disponibilité des tickets jusqu'au 15 Août 2024)</p><p> </p><p>    ● 0-6 ans gratuit (20 places) prière rajouter une pièce justificative comme preuve de paiement pour confirmer l'âge. </p><p>   ● 7-15 ans 15000F</p><p>    ● 16 ans et plus 20000F</p><p>    ●Gbonhi (4 personnes) 75000F</p><p> </p>",
    "short_description":
        "Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins et repartant avec des lots🥰\r\n \r\nNous profitons de ce moment pour récompenser nos meilleurs clients, partageurs, soutiens ...",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQhJREFUOI2F0rGNhjAMBeD8cpEOFkBijXRZCRbgYIFkpXRZI5IXyHUUUd4ZcddhztWnNH6YZ4CTY0L36EZzMW7ujndnBtXcHY5cNofw6pgn84/L5lHfLHvpO3H9zfDoK39wHP6+5ckyFHxbzD2Plo2MDCTZq3laE8VUvlAG1VzvSwpUT2PGcRIg+TW3xc0xY7fzrhrIbfNlcdRVSyqzXC/84k/mau8X3Wcxnrptuudu+cgk2arqskJujuBoV03y6yXbLpVTPQ2eDyACumXa57xK0lVLT6RL1F1bVEvfzHjK9raplt5StW2EZHsxy6HW3IY3t8FRsBRUy16OuYz5zvZoyY8jXV1S/QMNhxiMYVmFvgAAAABJRU5ErkJggg==",
    "image": "shared-image-10-1717677948.jpeg",
    "published": 1,
    "active": 1,
    "created_at": "2024-06-06T12:59:14.000000Z",
    "updated_at": "2024-08-12T21:52:36.000000Z",
    "published_at": "2024-06-06 16:48:59",
    "payment_terms":
        "Numéros pour les dépôts:\n\nWave/Moov money: 01 01 30 26 12\n\nMTN money: 05 66 99 84 16\n\nOrange money: 07 09 89 34 77",
    "infoline": "05 66 99 84 16",
    "visibility": 1,
    "short_url": "FvHqU1",
    "localizations": [
      {
        "id": 17,
        "event_id": 16,
        "date_event": "2024-08-15",
        "starttime_event": "12:00:00",
        "endtime_event": "18:00:00",
        "place": "Rosiers  programme 3, Rive gauche Rue Muguet",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-06-06T12:59:14.000000Z",
        "updated_at": "2024-06-06T12:59:14.000000Z"
      }
    ],
    "passes": [
      {
        "id": 20,
        "event_id": 16,
        "name": "Enfants(0 à 6ans )",
        "description": "Pour les enfants de 0 à 6 ans",
        "price": 0,
        "passes_quantity": "20",
        "remaining_passes": "1",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-06-06T12:59:14.000000Z",
        "updated_at": "2024-08-14T21:47:54.000000Z",
        "people_max": "1"
      },
      {
        "id": 21,
        "event_id": 16,
        "name": "Ado(7 à 15 ans )",
        "description": "Pour les adolescents de 7 à 15 ans",
        "price": 15000,
        "passes_quantity": null,
        "remaining_passes": "1",
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-06-06T12:59:14.000000Z",
        "updated_at": "2024-08-02T17:22:02.000000Z",
        "people_max": "1"
      },
      {
        "id": 22,
        "event_id": 16,
        "name": "Jeune (16ans à plus)",
        "description": "Pour les jeunes de 16 ans et plus",
        "price": 20000,
        "passes_quantity": null,
        "remaining_passes": "1",
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-06-06T12:59:14.000000Z",
        "updated_at": "2024-08-14T10:04:15.000000Z",
        "people_max": "1"
      },
      {
        "id": 23,
        "event_id": 16,
        "name": "Gbonhi(max 4 personnes)",
        "description": "Pour les groupes de 4 personnes maximum",
        "price": 75000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-06-06T12:59:14.000000Z",
        "updated_at": "2024-06-12T16:54:35.000000Z",
        "people_max": "4"
      }
    ],
    "organizer": {
      "id": 8,
      "user_id": 195,
      "avatar": "noblesse-sweetness-food-2024-06-05-171910.jpg",
      "name": "Noblesse Sweetness & Food",
      "unique_code": "117140478",
      "phone": null,
      "description":
          "<p>Nous sommes un E-Restaurant-Traiteur-Event spécialisé dans la vente de mignardises, Entrées, plats,desserts, jus locaux, box surprises.. pour les petites envies, séminaires, dîners et cérémonies(Mariage, Baptême…)</p><p> </p><p>Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins et surtout repartant avec des lots nous accueillons tout le monde (petits et grands)</p><p> </p>",
      "active": 1,
      "short_description":
          "Le Sweet Lunch, est un événement que nous organisons chaque année histoire de permettre à nos Foodlovers de se retrouver dans une belle ambiance en dégustant tous nos mets tout en payant moins.",
      "website": null,
      "facebook": "Noblesse Sweetness & Food",
      "twitter": null,
      "instagram": "Noblesse.sweetness_food23",
      "created_at": "2024-06-05T17:19:10.000000Z",
      "updated_at": "2024-06-05T17:19:10.000000Z",
      "user": {
        "id": 195,
        "name": "Brou",
        "firstname": "Éloïse",
        "phone": null,
        "email": "eloisesaarahbrou24@gmail.com",
        "email_verified_at": "2024-06-05T17:09:07.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-06-05T17:08:03.000000Z",
        "updated_at": "2024-06-05T17:09:07.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Divertissement",
    "package": "Pack PRO CHAP",
    "images": [
      {
        "id": 96,
        "url":
            "https://anowan.com/events/images/shared-image-10-1717677948.jpeg",
        "image_cover": 1
      },
      {
        "id": 97,
        "url": "https://anowan.com/events/images/foodlovers-1717677962.jpeg",
        "image_cover": 0
      }
    ],
    "video": null,
    "event_type": "Festival"
  },
  {
    "id": 17,
    "organizer_id": 4,
    "category_id": 3,
    "event_type_id": 5,
    "package_id": 1,
    "name": "test SMS",
    "unique_code": "8074765241",
    "slug": "test-sms",
    "description": "<p>tzet</p>",
    "short_description": "tet",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ1JREFUOI2F0rGtxCAMBmA/uaDjFkBiDbqslCzAgwXISumyBpIXuOsoEH7m7so4jyL6hAS2yQ/MjV+N0sIDNFcIdTu4BLCqaQT3w/4ZuNwZovHpH9df7nDnOr8B07eHS0v/VAKV7yyXliUXQoTPujTn1qOpG9eo2ssTWYNjAd2UG+8nvpovqvF1Ip+4nw50p+CT3Dln1Oy2g/LZ46yrGXOD1cAK86xiLobzQWOpoBr3Nsd88DyrORlnDT0XHKo5s7yDW2VHNYAMaMDOupr71jAzPLivqmVR5joHVC05cRs7G6pVPfOWJJlw45n/+I5uvLMvBvn45Fwz7Uz5qFH1rDuAipGcaJb+3z/FdKv5D5oP2hnScqqSAAAAAElFTkSuQmCC",
    "image": null,
    "published": 1,
    "active": 1,
    "created_at": "2024-06-25T17:05:58.000000Z",
    "updated_at": "2024-06-25T17:06:01.000000Z",
    "published_at": "2024-06-25 17:06:01",
    "payment_terms": null,
    "infoline": "tess",
    "visibility": 0,
    "short_url": "ePzHD6",
    "localizations": [
      {
        "id": 18,
        "event_id": 17,
        "date_event": "2024-07-12",
        "starttime_event": "16:00:00",
        "endtime_event": "18:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-06-25T17:05:58.000000Z",
        "updated_at": "2024-06-25T17:05:58.000000Z"
      }
    ],
    "passes": [
      {
        "id": 24,
        "event_id": 17,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-06-25T17:05:58.000000Z",
        "updated_at": "2024-06-25T17:05:58.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Sport",
    "package": "Pack Classic",
    "images": [],
    "video": null,
    "event_type": "Exposition"
  },
  {
    "id": 18,
    "organizer_id": 9,
    "category_id": 4,
    "event_type_id": 4,
    "package_id": 1,
    "name": "THE MOTHER’S DAY",
    "unique_code": "6083947067",
    "slug": "the-mothers-day",
    "description":
        "<p>L’Agence Faith Event, structure spécialisée dans l’événementiel, organise, en partenariat avec l’Assemblée des Régions et Districts de Côte d’Ivoire (ARDCI), l’Union des Villes et Communes de Côte d’Ivoire (UVICOCI) et le Réseau des Femmes Elues Locales d’Afrique (REFELA)/Section Côte d’Ivoire, la cinquième édition de la Journée Spéciale dédiée aux Femmes élues locales, régionales et nationales dénommée « <strong>THE MOTHER’S DAY</strong> »,</p><p>Cette activité festive, d’échanges et de réflexion sur des problématiques majeures liées à la gouvernance territoriale vise à célébrer les Elues en tant que Mères mais également en tant qu’actrices majeures du développement des territoires qui œuvrent inlassablement, au quotidien, à l’amélioration des conditions de vie des populations.</p><p>L’événement bénéficie d’un soutien institutionnel fort et mobilise la participation de hautes autorités nationales.</p><p>« THE MOTHER’S DAY » est le cadre privilégie pour rendre un hommage mérité à toutes ces femmes et à toutes ces mères qui consacrent leur énergie au bien-être de leurs concitoyens et à l'évolution de la situation de la femme, en particulier. Cette journée constitue également une occasion unique de :</p><p>- promouvoir l’excellence dans la gouvernance locale et susciter la saine émulation entre les Elues Locales et Nationales ;</p><p>- renforcer la visibilité des femmes élues qui contribuent significativement à l’amélioration de la qualité de vie des populations à la base ;</p><p>- promouvoir l’image de la femme au service de la communauté et de la nation.</p><p> </p><p>Pour la présente édition, prévue pour se tenir le jeudi 11 juillet 2024, à Ivotel Hôtel d’Abidjan, le thème est : « Leadership des femmes et Développement Local : Renforcer le leadership et l’entrepreneuriat des femmes en économie sociale et solidaire ».</p><p>Il s’agira, à travers cette thématique, de célébrer la femme leader dans tous les domaines d’activités concernés par l’économie sociale et solidaire, d’une part, et de créer un cadre afin de partager les expériences et bonnes pratiques, d’autre part. L’organisation de cette célébration recherche la mobilisation du leadership et la participation qualitative des femmes dans le processus de gouvernance et de développement, au niveau territorial.</p><p> </p><p>1. Objectif général :</p><p> </p><p>Cette célébration, organisée en hommage aux femmes Elues à l’occasion de la Fête des Mères, vise à contribuer à l’émergence du leadership féminin par la pleine participation des femmes à la vie politique et économique, au niveau régional et local.</p><p> </p><p>2. Objectifs spécifiques :</p><p>De manière spécifique, il s’agit de :</p><p>- présenter des exemples concrets et inspirants de leadership féminin engagé dans l’économie sociale et solidaire (ESS), au niveau territorial ;</p><p>- échanger les expériences et bonnes pratiques et formuler des recommandations relatives aux problématiques majeures de développement du leadership féminin et de l’entrepreneuriat des femmes en ESS, au niveau régional et local ;</p><p>- vulgariser les initiatives de développement et les actions sociales entreprises par les entrepreneures en ESS en faveur de leurs communautés ;</p><p>- susciter davantage de soutien des femmes élues locales et nationales aux actions des entrepreneures en ESS.</p><p> </p><p>Au terme de cette activité, les résultats attendus sont les suivants : </p><ul><li>des exemples concrets et inspirants de leadership féminin engagé dans l’économie sociale et solidaire (ESS), au niveau territorial, sont présentés ;</li><li>les expériences et bonnes pratiques sont partagées et des recommandations relatives aux problématiques majeures de développement du leadership féminin et de l’entrepreneuriat des femmes en ESS, au niveau régional et local sont formulées ;</li><li>les initiatives de développement et les actions sociales entreprises par les entrepreneures en ESS en faveur de leurs communautés sont vulgarisées ;</li><li>les femmes élues locales et nationales sont engagées à apporter davantage de soutien aux actions des entrepreneures en ESS.</li></ul><p> </p><p>Sont attendues à cette édition de « <strong>THE MOTHER’S DAY</strong> », près de 350 femmes, à savoir : les élues et autorités locales : Ministre-Gouverneur et Vice-Gouverneurs de Districts, Présidentes de Régions, Vice-Présidentes et Conseillères Régionales, Maires et Conseillères Municipales.</p><p>L’activité mobilisera également la participation des femmes parlementaires (Députés et Sénatrices).</p><p>Outre ces personnalités, seront invités à prendre part à ces moments de célébration, de hautes autorités nationales, des représentants d’institutions internationales partenaires au développement, des leaders d’Organisations de la Société Civile et de jeunesse engagées dans l’ESS, ainsi que des dirigeants d’entreprises du secteur privé et des experts en ESS.</p><p> </p><p>Cette journée prendra la forme d’un déjeuner de gala dont le programme s’articulera comme suit : - des allocutions ; - la remise de présents aux Elues ; - des prestations musicales ; - un défilé de mode (autour de la thématique du textile et de l’ESS) ; - une matinée dansante. A l’occasion de ce moment de partage et de convivialité, un déjeuner sera servi à tous les convives à cet événement.</p><p> </p><p>Programme :<br>- 9 h 00 – 12 h 00 : Conférence débat autour du thème : « Leadership des femmes et développement local : Renforcer le leadership et l’entrepreneuriat des femmes dans l’économie sociale et solidaire ».<br>- 12 h – 16 h 00 : Déjeuner, remise de présents, jeux et animation musicale.</p><p> </p>",
    "short_description":
        "L’Agence Faith Event, en partenariat avec le Réseau des Femmes Elues Locales d’Afrique (REFELA) Section Côte d’Ivoire, vous convie à la 5ème édition de la Journée spéciale dédiée aux femmes élues locales, régionales et nationales dénommée « THE MOTHER’S DAY »",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ9JREFUOI2F07GNxCAQBdBZEZDhBpBog4yW2Abs3QagJTLaGIkG2MwBYm6429DjI7BegPEf8Q1Ep0va9UATJCN4fNaWPBjRbXqagZKndGfXdev/GGPgk2/Mz8Hfnd8Ml+b8HKyl7yyX5jX2YHf4W5ceMSg60YTWRTuq7VMon9aIHtHTp/CYrou2UcNGqmslm4jwUSkTxxOd65ruKJxfsjV+3exW3BQNoO1BnH9E0QPC2GEYANkq1/aCxtmM6NbDMB4eBXbR8CxqersVlI3H6XLFg/hkybzwWJvbFL168l5VwSia+6YyIZftJZrbaE0YGyHcmXti90D9zo5f4ctNotff8eYiFIiiOT+l4H7vTvAPkmUMX5d6AuYAAAAASUVORK5CYII=",
    "image": "whatsapp-image-2024-07-09-at-122115-1720531917.jpeg",
    "published": 1,
    "active": 1,
    "created_at": "2024-07-09T13:32:16.000000Z",
    "updated_at": "2024-07-09T13:33:53.000000Z",
    "published_at": "2024-07-09 13:33:53",
    "payment_terms": null,
    "infoline": "07 09 85 84 85 / 27 22 41 99 50",
    "visibility": 1,
    "short_url": "pobvGt",
    "localizations": [
      {
        "id": 19,
        "event_id": 18,
        "date_event": "2024-07-11",
        "starttime_event": "09:00:00",
        "endtime_event": "16:00:00",
        "place": "Ivotel Hôtel Plateau Abidjan, Côte d'Ivoire",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-07-09T13:32:16.000000Z",
        "updated_at": "2024-07-09T13:32:16.000000Z"
      }
    ],
    "passes": [
      {
        "id": 25,
        "event_id": 18,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-07-09T13:32:16.000000Z",
        "updated_at": "2024-07-09T13:32:16.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 9,
      "user_id": 213,
      "avatar": "faith-event-agence-1720531908.jpg",
      "name": "Faith Event Agence",
      "unique_code": "853533932",
      "phone": null,
      "description":
          "Pour l'organisation de vos événements sans stress ni contraintes, contactez Faith Event au 0709858485",
      "active": 1,
      "short_description": null,
      "website": null,
      "facebook": "https://www.facebook.com/faitheventci",
      "twitter": null,
      "instagram": null,
      "created_at": "2024-07-09T13:09:07.000000Z",
      "updated_at": "2024-07-09T13:31:48.000000Z",
      "user": {
        "id": 213,
        "name": "Faith Event",
        "firstname": "Agence",
        "phone": null,
        "email": "ardci@hotmail.com",
        "email_verified_at": "2024-07-09T13:07:00.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-07-09T13:04:36.000000Z",
        "updated_at": "2024-07-09T13:04:36.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Social",
    "package": "Pack Classic",
    "images": [
      {
        "id": 116,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-07-09-at-122115-1720531917.jpeg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 19,
    "organizer_id": 7,
    "category_id": 1,
    "event_type_id": 2,
    "package_id": 1,
    "name": "CLASSIC EMAIL",
    "unique_code": "5740777971",
    "slug": "classic-email",
    "description": "<p>CLASSIC EMAIL</p>",
    "short_description": "CLASSIC EMAIL",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ1JREFUOI2F07HRhCAQBeB1CMi0AWZog4yWvAbUa0BbMqMNZrYBzQwY9n/eXejyEzhfBOt7QCJXni+zRKmkOVPw76uMgXrVXIPZxNQga8s0pNL/Y/e692wY55qVHP1meDTm5zXw+vuXR2PxufNC3/XoMgVfI77YU7N7JTcIjZYP1YIcquX3bhbdZ/KV3HCVXnXpLjeFOzHdrks0i/90pxk5mC25ySIxzXwmmmIeW0Zr2JDm5Eg1kpQt+YOQg+ZCkSWZw7petSyIdKcx+kV1mZEDlUHkUI0lR/QYnlQjBzcL+m34c9/s/UBG1WiERRB76VsuneAOUNPmFFTDVTXORSmZ4veNPBrzS7UZ9ZHmPwJR7FW6yMU3AAAAAElFTkSuQmCC",
    "image": "design-sans-titre-1-1720774025.png",
    "published": 1,
    "active": 1,
    "created_at": "2024-07-12T08:48:15.000000Z",
    "updated_at": "2024-07-12T08:48:27.000000Z",
    "published_at": "2024-07-12 08:48:27",
    "payment_terms": null,
    "infoline": "0707070707",
    "visibility": 0,
    "short_url": "S7mR9q",
    "localizations": [
      {
        "id": 20,
        "event_id": 19,
        "date_event": "2024-07-12",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "ABIDJAN",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-07-12T08:48:15.000000Z",
        "updated_at": "2024-07-12T08:48:15.000000Z"
      }
    ],
    "passes": [
      {
        "id": 26,
        "event_id": 19,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-07-12T08:48:15.000000Z",
        "updated_at": "2024-07-12T08:48:15.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 7,
      "user_id": 187,
      "avatar": "digifaz-event-2024-05-23-104549.jpg",
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
        "id": 187,
        "name": "Konan",
        "firstname": "Nadège",
        "phone": "0748086093",
        "email": "nadege.assohou@digifaz.com",
        "email_verified_at": "2024-05-23T10:59:28.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-04-15T15:17:29.000000Z",
        "updated_at": "2024-07-12T13:03:16.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Entreprise",
    "package": "Pack Classic",
    "images": [
      {
        "id": 117,
        "url":
            "https://anowan.com/events/images/design-sans-titre-1-1720774025.png",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Brunch"
  },
  {
    "id": 20,
    "organizer_id": 4,
    "category_id": 1,
    "event_type_id": 5,
    "package_id": 1,
    "name": "Test grandeur nature",
    "unique_code": "1113249663",
    "slug": "test-grandeur-nature",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAGMAAABjAQMAAAC19SzWAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAUpJREFUOI2N1D3OwyAMBmBXGdjCBZC4hjeulF4gPxcIV2LjGpa4QLsxoPgzadY4H+qQBzXqi7ELzHWIDEsemAk0EWDZmF61rKCrHAg2g5W366N4D27E/8iBoYUfJVnaDH6H4Up2Kzlf2bF/rtPeSpb/9CPCtW7FR2gTNAjtnXV5TiWylLasgXStV3XlKkCVm6FXd8m8oy6/sVTXf8AtSRdvuYEphxk+hlTBjDSDXAIfBlTJ12HCEqvvWTR5rjTJHrrZ6IIROLL/5mHLpEq6gF5yXSjxQVXvlJjhzW7CJ2Ebg98DnckUtaUHkrY6s2giy3Iy+R0fezJF5ZtoCiUmv1Vd8thrtiMffR4UyTp7MNGIumRW2quSzbIHqqS6Q0ySnexvUm/1m/5hlSzmWSv4A5xNjyq9+4L8S4Gq3gUTOpudrbr47EEnMz0aVX8aY3gX22kwFQAAAABJRU5ErkJggg==",
    "image": "telechargement-1-1721040851.jfif",
    "published": 1,
    "active": 1,
    "created_at": "2024-07-15T10:55:03.000000Z",
    "updated_at": "2024-07-15T10:55:13.000000Z",
    "published_at": "2024-07-15 10:55:13",
    "payment_terms": null,
    "infoline": "tets",
    "visibility": 0,
    "short_url": "QnuXUO",
    "localizations": [
      {
        "id": 21,
        "event_id": 20,
        "date_event": "2024-07-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-07-15T10:55:03.000000Z",
        "updated_at": "2024-07-15T10:55:03.000000Z"
      }
    ],
    "passes": [
      {
        "id": 27,
        "event_id": 20,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-07-15T10:55:03.000000Z",
        "updated_at": "2024-07-15T10:55:03.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Entreprise",
    "package": "Pack Classic",
    "images": [
      {
        "id": 118,
        "url":
            "https://anowan.com/events/images/telechargement-1-1721040851.jfif",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Exposition"
  },
  {
    "id": 21,
    "organizer_id": 10,
    "category_id": 1,
    "event_type_id": 4,
    "package_id": 2,
    "name": "YAMOUSSOUKRO CONNECT 24",
    "unique_code": "4311205462",
    "slug": "yamoussoukro-connect-24",
    "description":
        "<p>Yamoussoukro Connect 2024 est une soirée exclusive dédiée à la promotion des opportunités d'investissement dans la ville de Yamoussoukro. Cet événement de quatre heures rassemblera des entrepreneurs, des investisseurs, des décideurs et des experts de divers secteurs pour explorer les potentiels de développement économique, technologique et durable de la région.</p><p><br><strong>OBJECTIFS DE L'ÉVÉNEMENT :</strong><br>•Promouvoir les opportunités d'investissement à Yamoussoukro.<br>•Faciliter le réseautage entre les acteurs économiques locaux et internationaux.<br>•Mettre en avant les atouts de Yamoussoukro dans des secteurs clés tels que l'infrastructure, l'agriculture, le tourisme, la technologie, l'énergie renouvelable et l'éducation.</p><p><br>PUBLIC CIBLE :<br>•Investisseurs locaux et internationaux.<br>•Entrepreneurs et start-ups.<br>•Responsables gouvernementaux et décideurs politiques.<br>•Experts sectoriels et universitaires.</p>",
    "short_description":
        "Yamoussoukro Connect 2024 est une soirée exclusive dédiée à la promotion des opportunités d'investissement dans la ville de Yamoussoukro. Cet événement de quatre heures rassemblera des entrepreneurs, des investisseurs, des décideurs et des experts de divers secteurs pour explorer les potentiels de développement économique, technologique et durable de la région.",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAGMAAABjAQMAAAC19SzWAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAU9JREFUOI2N072thTAMBWAjCjpYIBJrpMtKYQF+FoCV0mUNS1ng0aWI8DuB12IeorgfEpdjxyaR3K62PSWJMGlisrKSHLFdSVe6LJMzvktH/pQZQrrcfyQ7jWvXfglZ0t7xktNfslehvrTbev9V+ypc6Ywi4f6pqXhHs+WpBteFHpglcm/HDa9qkt3SIuRpPD5EQ6hBmkh9pwtlpR9XlnB/QRMOlibBq09fFNGUy4S2Odki6UIE341bTMeHjHeYghGTuBOrYjRsEG6kNJlUtZczs01bLnisClkQ2QxQIFWy3htw3g1WZTyxd9wEPGZVZXaYU/I44aBrlGjoXpQm6kqrw67IFuSqg6sIl1z3GA7PaL8Ku8J9h0NAP0gV9g8NM4jcP9v4qrr9U24lP8l0cf1nSod8qq3T53h+vvAqZOEpjmcotVRNtb7ZtkcoU1T1C96hriMI2KgoAAAAAElFTkSuQmCC",
    "image": "4af48638-3084-49f3-a098-4f6109a5335d-1721417704.jpeg",
    "published": 1,
    "active": 1,
    "created_at": "2024-07-17T17:21:31.000000Z",
    "updated_at": "2024-07-22T13:14:30.000000Z",
    "published_at": "2024-07-17 17:22:12",
    "payment_terms": null,
    "infoline": "0777062900",
    "visibility": 1,
    "short_url": "dX8loI",
    "localizations": [
      {
        "id": 22,
        "event_id": 21,
        "date_event": "2024-07-27",
        "starttime_event": "18:00:00",
        "endtime_event": "21:00:00",
        "place": "Hôtel Palace, Yamoussoukro, Millionnaire",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-07-17T17:21:31.000000Z",
        "updated_at": "2024-07-18T16:26:42.000000Z"
      }
    ],
    "passes": [
      {
        "id": 28,
        "event_id": 21,
        "name": "Pass",
        "description": null,
        "price": 15000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-07-17T17:21:31.000000Z",
        "updated_at": "2024-07-17T17:21:31.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 10,
      "user_id": 215,
      "avatar": "p-expertise-conseils-1721237446.jpeg",
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
        "id": 215,
        "name": "PODA",
        "firstname": "Diornite Joseph",
        "phone": "0777062900",
        "email": "diornitep@gmail.com",
        "email_verified_at": "2024-07-17T17:23:12.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-07-17T17:01:05.000000Z",
        "updated_at": "2024-07-18T01:15:56.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Entreprise",
    "package": "Pack PRO LITE",
    "images": [
      {
        "id": 125,
        "url":
            "https://anowan.com/events/images/4af48638-3084-49f3-a098-4f6109a5335d-1721417704.jpeg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 22,
    "organizer_id": 7,
    "category_id": 2,
    "event_type_id": 2,
    "package_id": 2,
    "name": "PRO LITE PRIVE",
    "unique_code": "2786051265",
    "slug": "pro-lite-prive",
    "description": "<p>PRO LITE PRIVE</p>",
    "short_description": "PRO LITE PRIVE",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARFJREFUOI190rGthTAMBVAjF+lgAaSskS4r5S0QYIGwUjrWsJQFeF2KKP7m80oM1UFC8SXXwFwbOO6eO2gmcDBUXB2Mqkt3tGSKjtOb28LXsa/mL/P5Zpk7DxnPX4ZHS/6SXEm/f3m0PHOAFuB+Hi0TCTxzlrmaKZoWHSxMo2pYKgyZAMqpOxqaMjJLfs12q+3DdjV2VY2nsclTcNhVz9GXb2U+yovlHkZPC0PQLadttXTTdOOeCx8o2U7VNFXsRqrBVTUEc1UMrui23eF+8M6s+6p1y1LKvQOPlj253qOT/JplKH6rlNJG1bK385TnieU+X9zA0+e4v9dcEthkMKmWuQ1kVY4726MlPwUP/90p/gOrWOQYnfI4vQAAAABJRU5ErkJggg==",
    "image": "logo-anowancom-ok-03-1721239291.png",
    "published": 1,
    "active": 1,
    "created_at": "2024-07-17T18:03:30.000000Z",
    "updated_at": "2024-07-17T18:03:35.000000Z",
    "published_at": "2024-07-17 18:03:35",
    "payment_terms": null,
    "infoline": "+225 07070707",
    "visibility": 0,
    "short_url": "ZdKIDd",
    "localizations": [
      {
        "id": 23,
        "event_id": 22,
        "date_event": "2024-07-27",
        "starttime_event": "12:00:00",
        "endtime_event": "20:00:00",
        "place": "ABIDJAN",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-07-17T18:03:30.000000Z",
        "updated_at": "2024-07-27T00:22:01.000000Z"
      }
    ],
    "passes": [
      {
        "id": 29,
        "event_id": 22,
        "name": "Normal",
        "description": "Normal",
        "price": 100,
        "passes_quantity": "10",
        "remaining_passes": "6",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-07-17T18:03:30.000000Z",
        "updated_at": "2024-07-27T18:41:34.000000Z",
        "people_max": "1"
      },
      {
        "id": 30,
        "event_id": 22,
        "name": "VIP",
        "description": "VIP",
        "price": 125,
        "passes_quantity": "10",
        "remaining_passes": "10",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-07-17T18:03:30.000000Z",
        "updated_at": "2024-07-17T18:03:30.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 7,
      "user_id": 187,
      "avatar": "digifaz-event-2024-05-23-104549.jpg",
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
        "id": 187,
        "name": "Konan",
        "firstname": "Nadège",
        "phone": "0748086093",
        "email": "nadege.assohou@digifaz.com",
        "email_verified_at": "2024-05-23T10:59:28.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-04-15T15:17:29.000000Z",
        "updated_at": "2024-07-12T13:03:16.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Culture et Art",
    "package": "Pack PRO LITE",
    "images": [
      {
        "id": 122,
        "url":
            "https://anowan.com/events/images/logo-anowancom-ok-03-1721239291.png",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Brunch"
  },
  {
    "id": 27,
    "organizer_id": 10,
    "category_id": 1,
    "event_type_id": 3,
    "package_id": 2,
    "name": "YAMOUSSOUKRO CONNECT Soirée d'investissement Acte 2",
    "unique_code": "8306173970",
    "slug": "yamoussoukro-connect-soiree-dinvestissement-acte-2",
    "description":
        "<h4>THEME: <i>LE MARCHE IMMOBILIER: PERSPECTIVES ET DEVELOPPEMENT A YAMOUSSOUKRO.</i></h4><p> </p><p>L'objectif de cette soirée est de promouvoir et de mettre en lumière les opportunités de développement et d'investissement dans le marché immobilier de Yamoussoukro. Voici les objectifs spécifiques :</p><p> </p><ul><li>Sensibiliser : Informer les participants sur la dynamique du marché immobilier à Yamoussoukro et les projets de développement en cours.</li><li>Créer des opportunités de réseautage : Faciliter les échanges entre investisseurs, promoteurs, décideurs et autres parties prenantes pour encourager les collaborations et les investissements.</li><li>Présenter les projets : Montrer les projets en cours et futurs, ainsi que les avantages d'investir dans la région.</li><li>Stimuler l'intérêt : Générer de l'intérêt pour le marché immobilier de Yamoussoukro en soulignant les bénéfices économiques et les opportunités d'investissement.</li><li>Établir des partenariats : Encourager la formation de partenariats stratégiques pour soutenir le développement immobilier et urbain à Yamoussoukro.</li></ul><p>Réservation : 07 77 062 900</p>",
    "short_description":
        "Participez à une soirée d'échanges avec des experts pour explorer les perspectives et opportunités du marché immobilier à Yamoussoukro",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAG8AAABvAQMAAADYCwwjAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAZRJREFUOI2NlDHOhSAQhNdQ0OkFSLiGHVfSC6jvAnIlOq5BwgW0oyDuP/hevfzE5jMBZobdJebCJxE5szl+SMZEMx+U9qDOmcYO5mfOd6w7A3FIF+vi0kL2+hfSUPjQ6ukjVKWdaYGkn0gB4Tef8/v97AuIZcbZ+pAv+i4B61RoZbNzGrV9Ophx10nq0GbT2C5jmhgx1inmy5mlg/YO6o7sgzocDpExbXP2wUwB2lQPzRDqUPInKsi7OkhTMaRpinXRiTqYhlZR7GFBY6+MtJZ8l5bkq0rGumk+cYWue8DeDu4lM1sfzauqg/C7xrpy2ou6Osifggcya6GBWz4iZkga+JskOkJGZG4PzZ6hPx8dTENsSaIGnreuROTHQT/fzXUTKWKdAgr7VdXeSEZ1c+ZS8eeaK/XwIIwR0ywzVMmILlM+Kl/Q8s2+iK1nBzbk7EncQ0wGQ8hQo+Xx+jK2OYkB4kt+O13Gd04WezMaGRd10bSZphWzGf+BcOqjfRzsyAhVSFLdAS5QsTLCL960qVpcfmT8A21EW+SJDBRJAAAAAElFTkSuQmCC",
    "image": "compressed-whatsapp-image-2024-08-06-at-22850-pm-1722961339.jpeg",
    "published": 1,
    "active": 1,
    "created_at": "2024-08-06T16:35:31.000000Z",
    "updated_at": "2024-08-21T09:48:27.000000Z",
    "published_at": "2024-08-06 16:35:54",
    "payment_terms": null,
    "infoline": "07 77 06 29 00",
    "visibility": 1,
    "short_url": "rjPZHm",
    "localizations": [
      {
        "id": 24,
        "event_id": 27,
        "date_event": "2024-12-14",
        "starttime_event": "18:00:00",
        "endtime_event": "21:00:00",
        "place": "Hôtel Palace, Yamoussoukro, Millionnaire",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-06T16:35:31.000000Z",
        "updated_at": "2024-08-06T16:35:31.000000Z"
      }
    ],
    "passes": [
      {
        "id": 31,
        "event_id": 27,
        "name": "Pass",
        "description": null,
        "price": 15000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-06T16:35:31.000000Z",
        "updated_at": "2024-08-06T16:35:31.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 10,
      "user_id": 215,
      "avatar": "p-expertise-conseils-1721237446.jpeg",
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
        "id": 215,
        "name": "PODA",
        "firstname": "Diornite Joseph",
        "phone": "0777062900",
        "email": "diornitep@gmail.com",
        "email_verified_at": "2024-07-17T17:23:12.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-07-17T17:01:05.000000Z",
        "updated_at": "2024-07-18T01:15:56.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Entreprise",
    "package": "Pack PRO LITE",
    "images": [
      {
        "id": 138,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1722961339.jpeg",
        "image_cover": 1
      },
      {
        "id": 139,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1722961366.jpeg",
        "image_cover": 0
      },
      {
        "id": 140,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1722961404.jpeg",
        "image_cover": 0
      },
      {
        "id": 147,
        "url":
            "https://anowan.com/events/images/9431731b-973b-4295-9c42-b86030469f0e-1724233659.jpeg",
        "image_cover": 0
      }
    ],
    "video": null,
    "event_type": "Séminaire"
  },
  {
    "id": 28,
    "organizer_id": 2,
    "category_id": 7,
    "event_type_id": 2,
    "package_id": 3,
    "name": "EVENT MOSSOUMA",
    "unique_code": "9751375679",
    "slug": "event-mossouma",
    "description": "<p>EVENT MOSSOUMA</p>",
    "short_description": "EVENT MOSSOUMA",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQpJREFUOI2F07GNxSAMBmBOKdKRBZCyBh0rkQUevAW4ldKxBpIXyHWvQPjs5Mr8ORShL5HBBjmG+eO+dh6Bh0FuxvfE3XpjoWn49fBT8VyerPHmH0twez1Z8lIJMl813Frqp6Kv11lurcP66QKw3sA396W6CL0O49LeEjcL7RI7I0uq7Ims6Q7f7NwjNL3Zpc+a5zVDT/IcclLNi+wWpjJ3GyQe+iWZg9RvIvQ6gkm723aJR+5bldT0IztDUw5TmZtce4ZuSeLntmheZOK/26YBLaNtuzYJtvRJj8FJv2Xos9OCbNgitPb2Vvty1oDNh8zaMA+mdzWJzy/31v9RjrDUHqHP/jcuesrIvzen7GR5H/WoAAAAAElFTkSuQmCC",
    "image": null,
    "published": 1,
    "active": 1,
    "created_at": "2024-08-12T17:18:23.000000Z",
    "updated_at": "2024-08-12T17:21:07.000000Z",
    "published_at": "2024-08-12 17:21:07",
    "payment_terms": "Mobile money : 0707070707",
    "infoline": "0707070707",
    "visibility": 0,
    "short_url": "t6FAz9",
    "localizations": [
      {
        "id": 25,
        "event_id": 28,
        "date_event": "2024-08-12",
        "starttime_event": "12:00:00",
        "endtime_event": "20:00:00",
        "place": "ABIDJAN",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-12T17:18:23.000000Z",
        "updated_at": "2024-08-12T17:18:23.000000Z"
      }
    ],
    "passes": [
      {
        "id": 33,
        "event_id": 28,
        "name": "ENFANT",
        "description": "ENFANT",
        "price": 0,
        "passes_quantity": "1",
        "remaining_passes": "0",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-12T17:18:23.000000Z",
        "updated_at": "2024-08-12T17:36:47.000000Z",
        "people_max": "1"
      },
      {
        "id": 34,
        "event_id": 28,
        "name": "VIP",
        "description": "VIP",
        "price": 15000,
        "passes_quantity": "1",
        "remaining_passes": "1",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-12T17:18:23.000000Z",
        "updated_at": "2024-08-12T17:18:23.000000Z",
        "people_max": "1"
      },
      {
        "id": 35,
        "event_id": 28,
        "name": "GROUPE",
        "description": "GROUPE",
        "price": 75000,
        "passes_quantity": "2",
        "remaining_passes": "1",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-12T17:18:23.000000Z",
        "updated_at": "2024-08-12T17:24:00.000000Z",
        "people_max": "4"
      }
    ],
    "organizer": {
      "id": 2,
      "user_id": 3,
      "avatar": "lifelor-event-2024-02-22-094859.jpg",
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
        "id": 3,
        "name": "K Nad",
        "firstname": "Nadege",
        "phone": null,
        "email": "mossouma@gmail.com",
        "email_verified_at": "2024-02-22T09:52:21.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-02-22T09:47:18.000000Z",
        "updated_at": "2024-02-22T09:52:21.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Divertissement",
    "package": "Pack PRO CHAP",
    "images": [],
    "video": null,
    "event_type": "Brunch"
  },
  {
    "id": 29,
    "organizer_id": 4,
    "category_id": 4,
    "event_type_id": 6,
    "package_id": 3,
    "name": "test pro chap sms 2",
    "unique_code": "3427523326",
    "slug": "test-pro-chap-sms-2",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARFJREFUOI2F07GRhSAQBuC9MSDDBpihDTJa0gZ4vAawJTLaYIYGNDNg3PvxXvjWM3C+QNyF/SHm0x6ZL88XSa7kelBdO9Ki2+VMoCk5Tk/mgw39YxuphiejbiWF918PX43+W3Itffby1Xhs9O2GZJxAn08zF7OIrq+M9ujFVYue+DRB8VbwT8nYWscqrfoi2mjX52yjwmlItjv1n8w86kqekiftjfb4XrJ9FwwF/dMiuq6n3biveUxHcF+UCa6u3JLo9mZ7FNJuiqLrnKfdT9tdVzAOHEv6izE+yeOoOaMoy0ZOOPqRtygaSTMLTFWLvrONnHx6kDwuUSD76LYVi+Htosd91L7OBTmRPPK/Aa5Fyb8SGPfCaIaB9gAAAABJRU5ErkJggg==",
    "image": null,
    "published": 1,
    "active": 1,
    "created_at": "2024-08-12T22:10:45.000000Z",
    "updated_at": "2024-08-12T22:10:45.000000Z",
    "published_at": "2024-08-12 22:17:19",
    "payment_terms": "test",
    "infoline": "test",
    "visibility": 0,
    "short_url": "xjS0HN",
    "localizations": [
      {
        "id": 26,
        "event_id": 29,
        "date_event": "2024-08-14",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-12T22:10:45.000000Z",
        "updated_at": "2024-08-12T22:10:45.000000Z"
      }
    ],
    "passes": [
      {
        "id": 36,
        "event_id": 29,
        "name": "enfant",
        "description": "test",
        "price": 0,
        "passes_quantity": "5",
        "remaining_passes": "0",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-12T22:10:45.000000Z",
        "updated_at": "2024-08-12T23:23:29.000000Z",
        "people_max": "1"
      },
      {
        "id": 37,
        "event_id": 29,
        "name": "ado",
        "description": "test",
        "price": 1800,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-12T22:19:40.000000Z",
        "updated_at": "2024-08-12T22:21:37.000000Z",
        "people_max": "1"
      },
      {
        "id": 38,
        "event_id": 29,
        "name": "groupe",
        "description": "tset",
        "price": 5000,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-12T22:19:40.000000Z",
        "updated_at": "2024-08-12T22:21:37.000000Z",
        "people_max": "4"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Social",
    "package": "Pack PRO CHAP",
    "images": [],
    "video": null,
    "event_type": "Festival"
  },
  {
    "id": 30,
    "organizer_id": 4,
    "category_id": 5,
    "event_type_id": 5,
    "package_id": 1,
    "name": "test",
    "unique_code": "6194986212",
    "slug": "test",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ9JREFUOI2F07GtxCAMBmCfUtCRBZBYg46VyAIJt0CyUrqsgcQCuS4Fis9+eWX+HNWHZGFjAzEf/rPVHPkk5EKBxthsIAtdz+A/a50Dz0+uu5H4H16OMj5Z8vr3qtkttNQvSev8f5dby3JaOV3r1u3Ffg6ybdiu37ocKJm6QwvaaHjZ5ExkDdup9FvDlvr5zdKN6463LlL8svozlhG6DQe92NnoM3Sxxi9ckulm7IGLjW5YNR5Zu2QoRWkpcpu49OyS0ZYCSzzvOjvpFXR/UCI3sZ4PrGPt5U3q7JCvfpK8twwtL03i6a+xyDIRN21lYp0jdpcNTavfn+xG45kZW/MmuUS8/sittX75aynUjPwFDlbghZRSlI8AAAAASUVORK5CYII=",
    "image": "compressed-whatsapp-image-2024-08-06-at-22850-pm-1724066915.jpeg",
    "published": 0,
    "active": 1,
    "created_at": "2024-08-19T11:31:05.000000Z",
    "updated_at": "2024-08-19T11:31:06.000000Z",
    "published_at": null,
    "payment_terms": null,
    "infoline": "test",
    "visibility": 1,
    "short_url": "zlW8ME",
    "localizations": [
      {
        "id": 27,
        "event_id": 30,
        "date_event": "2024-08-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-19T11:31:06.000000Z",
        "updated_at": "2024-08-19T11:31:06.000000Z"
      }
    ],
    "passes": [
      {
        "id": 39,
        "event_id": 30,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-19T11:31:06.000000Z",
        "updated_at": "2024-08-19T11:31:06.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Education",
    "package": "Pack Classic",
    "images": [
      {
        "id": 141,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1724066915.jpeg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Exposition"
  },
  {
    "id": 31,
    "organizer_id": 1,
    "category_id": 6,
    "event_type_id": 8,
    "package_id": 2,
    "name": "test pro lite",
    "unique_code": "7589036359",
    "slug": "test-pro-lite",
    "description": "<p>tet</p>",
    "short_description": "test",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAARBJREFUOI2F07GxhiAMAOB4FHS8BbhjDTpWwgUQF8CV7FiDOxb47Sg48sL7LY0v1aenJpEEEFsJVkSHAzgXsJjAJAuKdR1WYDafeefNO5r4j/E6NbyZ8hZva7xreDTVX5Ot6e7l0RSVugvwjUfj3mbGFemSMwQwUYrh4MVbK1sWVzOJdQ+gwdUja2AtsPVg6W9Qj6wjgJc9zLyc+4r1wuKBnueMEXSY9Rdg3Rc0F8IPzncZ6zX3LdePE4N1V84cuXupFWvYzr9hm3k5U/0FHOXtnjVF8bJQg4k1zYkZTitbFGuat5ruUeFMJ6IXOmLs6s0iSYHnvQuM8ch1P7/ffPTcx0GpJc0J57nXSwYlu+L8C7+63HohMJ9kAAAAAElFTkSuQmCC",
    "image": "compressed-whatsapp-image-2024-08-06-at-22850-pm-1724067553.jpeg",
    "published": 1,
    "active": 1,
    "created_at": "2024-08-19T11:32:44.000000Z",
    "updated_at": "2024-08-19T11:39:27.000000Z",
    "published_at": "2024-08-19 11:39:27",
    "payment_terms": null,
    "infoline": "test",
    "visibility": 0,
    "short_url": "kSXwmm",
    "localizations": [
      {
        "id": 28,
        "event_id": 31,
        "date_event": "2024-08-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-19T11:32:44.000000Z",
        "updated_at": "2024-08-19T11:39:17.000000Z"
      }
    ],
    "passes": [
      {
        "id": 40,
        "event_id": 31,
        "name": "test",
        "description": null,
        "price": 9689,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-19T11:32:44.000000Z",
        "updated_at": "2024-08-19T11:39:17.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 2,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "sorogneneyeridavid@gmail.com",
        "email_verified_at": "2024-02-15T15:59:13.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-02-15T15:58:53.000000Z",
        "updated_at": "2024-02-15T16:09:17.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Charité et Levée de fonds",
    "package": "Pack PRO LITE",
    "images": [
      {
        "id": 142,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1724067553.jpeg",
        "image_cover": 1
      },
      {
        "id": 143,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1724067731.jpeg",
        "image_cover": 0
      }
    ],
    "video": null,
    "event_type": "Dîner"
  },
  {
    "id": 32,
    "organizer_id": 4,
    "category_id": 4,
    "event_type_id": 4,
    "package_id": 3,
    "name": "test pro chap",
    "unique_code": "4414212094",
    "slug": "test-pro-chap",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQtJREFUOI2F072xhCAQAOB1CMiwAWZog4yWsAHUBqQlMtpghgZ8mQHDvtW70OUIdr5E9g8B8SrBis1hB84FrNmv5i0o1rVbERNFPEaGOTX1w9pbunNgyisO0PCt4dVUfz1sPb69vJpO/Ut1g895dQvWdEuR7mS95KZk8bKerHFztbu6J7Gxpmi61PPVFOsyIyW9J8YbpqRnxGd3nE28YM0tSJoY5+Zp7I7qH7hMWIIra9bAukbKmzV9dbJu3pUpNy+1Yo2nNDGJ05mN9+YgyLvNk/WzVnc3AqzpnejlHunA9N7Agw5QPOv75cerrNjUyBWRtgNDix0x5tpZU17KCOA+/8irqf62PKsBzv8aUOzQf0pl2QAAAABJRU5ErkJggg==",
    "image": "compressed-whatsapp-image-2024-08-06-at-22850-pm-1724067806.jpeg",
    "published": 0,
    "active": 1,
    "created_at": "2024-08-19T11:44:03.000000Z",
    "updated_at": "2024-08-19T12:03:16.000000Z",
    "published_at": null,
    "payment_terms": "test",
    "infoline": "test",
    "visibility": 0,
    "short_url": "yvurOg",
    "localizations": [
      {
        "id": 29,
        "event_id": 32,
        "date_event": "2024-08-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-19T11:44:03.000000Z",
        "updated_at": "2024-08-19T11:44:03.000000Z"
      }
    ],
    "passes": [
      {
        "id": 41,
        "event_id": 32,
        "name": "test",
        "description": null,
        "price": 578,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-19T11:44:03.000000Z",
        "updated_at": "2024-08-19T11:44:03.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Social",
    "package": "Pack PRO CHAP",
    "images": [
      {
        "id": 144,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1724067806.jpeg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Conférence / Panel"
  },
  {
    "id": 33,
    "organizer_id": 4,
    "category_id": 4,
    "event_type_id": 5,
    "package_id": 3,
    "name": "test pro chap 2",
    "unique_code": "2826075213",
    "slug": "test-pro-chap-2",
    "description": "<p>tets</p>",
    "short_description": "test",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ1JREFUOI2F07GNxSAMBmBHKehgASTWoGMl3gKEW4CslI41kLxArkuB8Jn3XhnnUkQfEgmO/QeILrscNAINkNzA96S69qBF4/DuhLV4Kk/uG1n4x2uBlp7M52JRfP/UcGuuHwsvv99y6/cV8It7zw5wK0y1UbT7rVw8bNS0aDDUtaK9zpcKxv2Y3daqR9E2BmsOl5XLott2cK+I5rmSXQl4KqsD75fcTMUTuH6Iot3Pxfv765jPCm5J2eVqL8Ii21zrTqD9mmVvtaUwl1G29o4qxwmH6DnWkzMAJJuHSzvNvGXRM2kLG5oWzbnl8VlDmB/Npydw48kcOcfDO0W3+Qcpng7nRPI7/6FHj1nyH/Kk9z7JCCktAAAAAElFTkSuQmCC",
    "image": "compressed-whatsapp-image-2024-08-06-at-22850-pm-1724068546.jpeg",
    "published": 0,
    "active": 1,
    "created_at": "2024-08-19T11:57:18.000000Z",
    "updated_at": "2024-08-19T11:57:18.000000Z",
    "published_at": null,
    "payment_terms": "tet",
    "infoline": "test",
    "visibility": 0,
    "short_url": "zjoAJf",
    "localizations": [
      {
        "id": 30,
        "event_id": 33,
        "date_event": "2024-08-31",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-19T11:57:18.000000Z",
        "updated_at": "2024-08-19T11:57:18.000000Z"
      }
    ],
    "passes": [
      {
        "id": 42,
        "event_id": 33,
        "name": "test",
        "description": null,
        "price": 89,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-19T11:57:18.000000Z",
        "updated_at": "2024-08-19T11:57:18.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Social",
    "package": "Pack PRO CHAP",
    "images": [
      {
        "id": 145,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-06-at-22850-pm-1724068546.jpeg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Exposition"
  },
  {
    "id": 34,
    "organizer_id": 11,
    "category_id": 7,
    "event_type_id": 8,
    "package_id": 1,
    "name": "LA RUMBA DU ROBERT'S  HÔTEL",
    "unique_code": "3485728907",
    "slug": "la-rumba-du-roberts-hotel",
    "description":
        "<p>C'est fait ! Le nouveau rendez-vous RUMBA de vos Dimanches fin d'après-midi, début de soirée.</p><p> </p><p><strong>Dimanche 8 Septembre 2024.</strong> 17H00. <strong> Dix-Sept Heures Zéro Zéro !</strong> Dans le magnifique jardin du Robert's Hôtel !<strong> La Répétition Générale avant la Réunion de Famille avec JB M'PIANA ...</strong></p>",
    "short_description":
        "C'est fait ! Le nouveau rendez-vous RUMBA de vos Dimanches fin d'après-midi, début de soirée.",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAGMAAABjAQMAAAC19SzWAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAU5JREFUOI2N1LGNhTAMBuAfpaCDBSJljXRZCRbgwQKPldJljUheALoUET5zcCXmEM2HFPTbTgLmwpunJRrmDE0ZHpOvk6cZuujwdgho2KzlVWbztUn0Hx2t24t5k2SxA2hlcyd7lNRHX3++d7WPkqd2rcTB/TxKemC7UHF1QpObW5qD/N5OAboOX/tUEfjbZlW0JDTRdpBmQJXZi5MUgwSXdZp4j7xGNEk6B1V0BFpYvr2qjgl9odm7zWdVdiyOE7rAnHSxhB1a6bHsBV3oZfdxHRkddPEB2gttwSLowshujzKHetanSepzK+PD+ZN0ERf5IG2z0zlbTUvKn2hxbUNNzGw40SHxW11n1IZ59rlnXXJWZF0eAsleUHWdP0zhd50mOdPSsCyzPSf2Ijko5sDvHF6EQe6JePVMkWShb6DNu/vme9R5R66lov2r9kk/F3entMjsZ5MAAAAASUVORK5CYII=",
    "image": "compressed-whatsapp-image-2024-08-17-at-145012-1-1724072224.jpeg",
    "published": 1,
    "active": 1,
    "created_at": "2024-08-19T13:00:46.000000Z",
    "updated_at": "2024-08-19T13:01:12.000000Z",
    "published_at": "2024-08-19 13:01:12",
    "payment_terms": null,
    "infoline": "+225 07 99 26 44 21 / 07 09 84 26 03",
    "visibility": 1,
    "short_url": "NHhx7j",
    "localizations": [
      {
        "id": 31,
        "event_id": 34,
        "date_event": "2024-09-08",
        "starttime_event": "17:00:00",
        "endtime_event": "23:59:00",
        "place": "Jardin Event - Robert's Hôtel",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-19T13:00:46.000000Z",
        "updated_at": "2024-08-19T13:00:57.000000Z"
      }
    ],
    "passes": [
      {
        "id": 43,
        "event_id": 34,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-19T13:00:46.000000Z",
        "updated_at": "2024-08-19T13:00:46.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 217,
        "name": "KOUAME",
        "firstname": "Roland",
        "phone": null,
        "email": "rolandkouameb@gmail.com",
        "email_verified_at": "2024-08-22T17:14:06.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-08-17T15:43:06.000000Z",
        "updated_at": "2024-08-17T15:43:06.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Divertissement",
    "package": "Pack Classic",
    "images": [
      {
        "id": 146,
        "url":
            "https://anowan.com/events/images/whatsapp-image-2024-08-17-at-145012-1-1724072224.jpeg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Dîner"
  },
  {
    "id": 35,
    "organizer_id": 4,
    "category_id": 5,
    "event_type_id": 3,
    "package_id": 1,
    "name": "test classic",
    "unique_code": "5013400312",
    "slug": "test-classic",
    "description": "<p>test</p>",
    "short_description": "test",
    "free": 1,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAQ1JREFUOI2F0rGNxSAMBmA/UdBxCyBlDTpW4hYgyQJkJTrWQGKBpKNA+GzllXGO6isgduwfEDueTm0eJ0iu4GoATA6M6Dad/WR6gunNsHbc/nFdu4U3U108ctu+PTya+m/JtfT9l0fTGeAhwn0ejXsf0cMv1ihaYalGt8lPJDeawIHq6ksSra7cJqijWBA9At/niRnRC13eC7cXRbe917XQ+nh3gi1otTnqv4Jo+hqv5ge5B8HLPYfTqymaBl6jt0FbI1qdgFOD4bqScfrxQao7gmjeb9CVQpJEU05gLda4akRz/oHmAC/m/EeKLo5XqwsV5jvnkgfNas+UN8mcf4pK0pQTydT/MB6MHkbyH2Wt7pi2lgKYAAAAAElFTkSuQmCC",
    "image": "compressed-agl-banner-1724346721.jpg",
    "published": 0,
    "active": 1,
    "created_at": "2024-08-22T17:12:40.000000Z",
    "updated_at": "2024-08-22T17:12:41.000000Z",
    "published_at": null,
    "payment_terms": null,
    "infoline": "test",
    "visibility": 0,
    "short_url": "sLqOO1",
    "localizations": [
      {
        "id": 32,
        "event_id": 35,
        "date_event": "2024-09-01",
        "starttime_event": "12:00:00",
        "endtime_event": "13:00:00",
        "place": "test",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-22T17:12:41.000000Z",
        "updated_at": "2024-08-22T17:12:41.000000Z"
      }
    ],
    "passes": [
      {
        "id": 45,
        "event_id": 35,
        "name": "Gratuit",
        "description": "Gratuit",
        "price": 0,
        "passes_quantity": null,
        "remaining_passes": null,
        "unlimited": 1,
        "active": 1,
        "created_at": "2024-08-22T17:12:41.000000Z",
        "updated_at": "2024-08-22T17:12:41.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
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
        "id": 4,
        "name": "Soro",
        "firstname": "David",
        "phone": "0504360023",
        "email": "david.soro@digifaz.com",
        "email_verified_at": "2024-05-23T10:55:16.000000Z",
        "avatar": "soro-2024-05-29-125138.jpg",
        "active": 1,
        "created_at": "2024-02-28T12:30:07.000000Z",
        "updated_at": "2024-06-12T16:50:10.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Education",
    "package": "Pack Classic",
    "images": [
      {
        "id": 148,
        "url": "https://anowan.com/events/images/agl-banner-1724346721.jpg",
        "image_cover": 1
      }
    ],
    "video": null,
    "event_type": "Séminaire"
  },
  {
    "id": 36,
    "organizer_id": 12,
    "category_id": 2,
    "event_type_id": 1,
    "package_id": 2,
    "name": "CONCERT DE L'ESPERANCE",
    "unique_code": "8724131404",
    "slug": "concert-de-lesperance",
    "description":
        "<p>Le <strong>Concert de l’Espérance</strong> est un événement musical organisé dans le but de lever des fonds pour la construction d’une chapelle dédiée à <strong>Padre Pio</strong>. Ce concert rassemble des artistes et des musiciens qui se produisent pour soutenir cette noble cause. L’objectif principal est de réunir la communauté autour de la musique et de la foi, tout en collectant des dons nécessaires pour la réalisation de ce projet spirituel et architectural.</p>",
    "short_description":
        "Le Concert de l’Espérance est un événement musical organisé dans le but de lever des fonds pour la construction d’une chapelle dédiée à Padre Pio.",
    "free": 0,
    "qrcode":
        "iVBORw0KGgoAAAANSUhEUgAAAGMAAABjAQMAAAC19SzWAAAABlBMVEX///8AAABVwtN+AAAAAXRSTlMAQObYZgAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAUdJREFUOI2N1MGNwyAQBdCxOHAzDSC5Dd9oKVTguAHcEjfaQKKBcOOAdvbjzdXDokjxk4LymWFMzC0vjcgp5kySMu354O2zlzfJKj97XzVfrVxtKg6k3qT+oS3sI8tMyMJvKhzVN9mjcL4S9vH5nvZRWKqmbtL9KKmbpq5kTcwe+yRZH/PC5Uz0QnZJ29mQmoO25CbiZFe3XZHPKKsbRgp7J8qiVI0qEK3avu6jPssaxqLVYbcsws89KpH6EmUhBZlkD3QDHZPUPU42aobikSh0tRMKpjm4mfQWRs1wZWQxbmtt9mAeWURhR0DfUh9ZJClu/WD8D3+cLFoSWoG+Yf5kdY+axbsbSRYW7iDamw3LwqwQaSKMi5OV72/ULK86ixrTX9n6hixTqfGe0Jh+mmk04Yx4kDWy1MT1b6YljXekiVvFxMQs6RfpXZgD+wBUVQAAAABJRU5ErkJggg==",
    "image": "compressed-worship-1724350574.jpg",
    "published": 1,
    "active": 1,
    "created_at": "2024-08-22T17:48:15.000000Z",
    "updated_at": "2024-08-22T18:16:32.000000Z",
    "published_at": "2024-08-22 17:48:35",
    "payment_terms": null,
    "infoline": "07 10 07 43 74",
    "visibility": 0,
    "short_url": "HXVqCs",
    "localizations": [
      {
        "id": 33,
        "event_id": 36,
        "date_event": "2024-08-25",
        "starttime_event": "14:30:00",
        "endtime_event": "18:00:00",
        "place":
            "Fraternité saint Padre Pio des Freres Mineurs Capucins Cocody Angré",
        "longitude": null,
        "latitude": null,
        "created_at": "2024-08-22T17:48:15.000000Z",
        "updated_at": "2024-08-23T21:23:17.000000Z"
      }
    ],
    "passes": [
      {
        "id": 46,
        "event_id": 36,
        "name": "Standard",
        "description": "Standard",
        "price": 100,
        "passes_quantity": "15",
        "remaining_passes": "15",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-22T17:48:15.000000Z",
        "updated_at": "2024-08-23T12:15:14.000000Z",
        "people_max": "1"
      },
      {
        "id": 47,
        "event_id": 36,
        "name": "VIP",
        "description": "VIP",
        "price": 125,
        "passes_quantity": "10",
        "remaining_passes": "9",
        "unlimited": 0,
        "active": 1,
        "created_at": "2024-08-22T17:48:15.000000Z",
        "updated_at": "2024-08-23T21:04:47.000000Z",
        "people_max": "1"
      }
    ],
    "organizer": {
      "id": 12,
      "user_id": 196,
      "avatar": "kouame-marie-andree-2024-08-18-162433.jpg",
      "name": "ANDY EVENT'S",
      "unique_code": "932823468",
      "phone": null,
      "description": null,
      "active": 1,
      "short_description":
          "Vous satisfaire lors de vos évenéments est notre priorité.",
      "website": null,
      "facebook": null,
      "twitter": null,
      "instagram": null,
      "created_at": "2024-08-18T16:24:33.000000Z",
      "updated_at": "2024-08-22T18:23:03.000000Z",
      "user": {
        "id": 196,
        "name": "Kouame",
        "firstname": "Marie andrée",
        "phone": "0759921664",
        "email": "mandree.kouame@digifaz.com",
        "email_verified_at": "2024-06-05T20:21:11.000000Z",
        "avatar": null,
        "active": 1,
        "created_at": "2024-06-05T20:20:24.000000Z",
        "updated_at": "2024-08-22T18:17:28.000000Z",
        "phone_code": "+225"
      }
    },
    "category": "Culture et Art",
    "package": "Pack PRO LITE",
    "images": [
      {
        "id": 149,
        "url": "https://anowan.com/events/images/worship-1724350574.jpg",
        "image_cover": 1
      },
      {
        "id": 150,
        "url": "https://anowan.com/events/images/worship-1724351240.jpg",
        "image_cover": 0
      }
    ],
    "video": null,
    "event_type": "One Time"
  }
];
