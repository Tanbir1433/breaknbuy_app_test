import 'dart:convert';

BannerResponse bannerResponseFromMap(String str) => BannerResponse.fromMap(json.decode(str));

String bannerResponseToMap(BannerResponse data) => json.encode(data.toMap());

class BannerResponse {
  String message;
  List<Banners> banners;
  BannerResponse({
    required this.message,
    required this.banners,
  });

  factory BannerResponse.fromMap(Map<String, dynamic> json) => BannerResponse(
    message: json["message"],
    banners: List<Banners>.from(json["data"].map((x) => Banners.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(banners.map((x) => x.toMap())),
  };
}

Banners bannersFromMap(String str) => Banners.fromMap(json.decode(str));

class Banners {
  int id;
  String title;
  String imagePath;

  Banners({
    required this.id,
    required this.title,
    required this.imagePath,
  });

  factory Banners.fromMap(Map<String, dynamic> json) => Banners(
    id: json["id"],
    title: json["title"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image_path": imagePath,
  };
}
