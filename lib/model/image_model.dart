import 'dart:convert';

List<ImageModel> listImageModelFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String listImageModelToJson(List<ImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//single
ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  final int id;
  final String? url;
  final int imageCover;

  ImageModel({
    required this.id,
    required this.url,
    required this.imageCover,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        url: json["url"] ?? '',
        imageCover: json["image_cover"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "image_cover": imageCover,
      };
}
